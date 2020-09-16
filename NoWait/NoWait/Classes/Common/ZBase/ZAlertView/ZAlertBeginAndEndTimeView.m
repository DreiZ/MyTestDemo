//
//  ZAlertBeginAndEndTimeView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertBeginAndEndTimeView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"


@interface ZAlertBeginAndEndTimeView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *endContView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *subLabel;

@property (nonatomic,strong) BRDatePickerView *dateBeginPicker;
@property (nonatomic,strong) BRDatePickerView *dateEndPicker;
@property (nonatomic,strong) NSDate *beginDate;
@property (nonatomic,strong) NSDate *endDate;

@property (nonatomic,assign) BRDatePickerMode beginMode;
@property (nonatomic,assign) BRDatePickerMode endMode;

@property (nonatomic,strong) void (^handleBlock)(NSDate *,NSDate *);
 
@property (nonatomic,assign) NSInteger proIndex;

@end

@implementation ZAlertBeginAndEndTimeView

static ZAlertBeginAndEndTimeView *sharedManager;

+ (ZAlertBeginAndEndTimeView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertBeginAndEndTimeView alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor(RGBAColor(0, 0, 0, 0.8), RGBAColor(1, 1, 1, 0.8));
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    __weak typeof(self) weakSelf = self;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.endContView];
    [self.endContView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(400));
        make.width.mas_equalTo(CGFloatIn750(690));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(80));
    }];
    
    {
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        [self.endContView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(116));
            make.left.right.top.equalTo(self.endContView);
        }];
        [topView addSubview:self.subLabel];
        
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(topView);
        }];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
        [topView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(topView);
            make.height.mas_equalTo(1);
        }];
        
        [self.endContView addSubview:self.dateEndPicker];
        [self.dateEndPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.endContView);
            make.top.equalTo(topView.mas_bottom).offset(-CGFloatIn750(80));
        }];
        [self.endContView bringSubviewToFront:topView];
    }
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(400));
        make.width.mas_equalTo(CGFloatIn750(690));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.endContView.mas_top).offset(-CGFloatIn750(20));
    }];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(116));
        make.left.right.top.equalTo(self.contView);
    }];
    
    [topView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
    }];
    
   
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]) forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont fontContent]];
    [leftBtn bk_addEventHandler:^(id sender) {
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(136));
        make.left.equalTo(topView);
        make.bottom.equalTo(topView);
        make.top.equalTo(topView);
    }];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont fontContent]];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (!weakSelf.beginDate) {
            weakSelf.beginDate = [NSDate new];
        }
        if (!weakSelf.endDate) {
            weakSelf.endDate = [NSDate new];
        }
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(weakSelf.beginDate, weakSelf.endDate);
        }
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(136));
        make.right.equalTo(topView);
        make.bottom.equalTo(topView);
        make.top.equalTo(topView);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
       bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
       [topView addSubview:bottomLineView];
       [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.bottom.equalTo(topView);
           make.height.mas_equalTo(1);
       }];
       
    [self.contView addSubview:self.dateBeginPicker];
    [self.dateBeginPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contView);
        make.top.equalTo(topView.mas_bottom).offset(-CGFloatIn750(80));
    }];
   
    [self.contView bringSubviewToFront:topView];
}

- (BRDatePickerView *)dateBeginPicker {
    if (!_dateBeginPicker) {
        __weak typeof(self) weakSelf = self;
        _dateBeginPicker = [[BRDatePickerView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(690), CGFloatIn750(400))];
        _dateBeginPicker.pickerMode = BRDatePickerModeYMD;
//        _dateBeginPicker.maxDate = [NSDate date];
        _dateBeginPicker.isAutoSelect = YES;
        _dateBeginPicker.showUnitType = BRShowUnitTypeOnlyCenter;
        _dateBeginPicker.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
            DLog(@"---begin  %@  %@",selectDate, selectValue);
            weakSelf.beginDate = selectDate;
        };
               
        // 自定义选择器主题样式
        BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
        customStyle.pickerColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        customStyle.separatorColor = [UIColor colorMain];
        customStyle.selectRowTextColor = [UIColor colorMain];
        customStyle.dateUnitTextColor = [UIColor colorMain];
        customStyle.pickerHeight = CGFloatIn750(400);
        customStyle.titleBarHeight = CGFloatIn750(-80);
        _dateBeginPicker.pickerStyle = customStyle;
        // 添加选择器到容器视图
        [_dateBeginPicker addPickerToView:self.contView];
    }
    return _dateBeginPicker;
}


- (BRDatePickerView *)dateEndPicker {
    if (!_dateEndPicker) {
        __weak typeof(self) weakSelf = self;
        _dateEndPicker = [[BRDatePickerView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(690), CGFloatIn750(400))];
        _dateEndPicker.pickerMode = BRDatePickerModeYMD;
//        _dateEndPicker.maxDate = [NSDate date];
        _dateEndPicker.isAutoSelect = YES;
        _dateEndPicker.showUnitType = BRShowUnitTypeOnlyCenter;
        _dateEndPicker.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
            DLog(@"---begin  %@  %@",selectDate, selectValue);
            weakSelf.endDate = selectDate;
        };
               
        // 自定义选择器主题样式
        BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
        customStyle.pickerColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        customStyle.separatorColor = [UIColor colorMain];
        customStyle.selectRowTextColor = [UIColor colorMain];
        customStyle.dateUnitTextColor = [UIColor colorMain];
        customStyle.titleBarHeight = CGFloatIn750(-80);
        customStyle.pickerHeight = CGFloatIn750(400);
        _dateEndPicker.pickerStyle = customStyle;
       
       // 添加选择器到容器视图
        [_dateEndPicker addPickerToView:self.endContView];
    }
    return _dateEndPicker;
}


- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        ViewRadius(_contView, CGFloatIn750(32));
        _contView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    
    return _contView;
}


- (UIView *)endContView {
    if (!_endContView) {
        _endContView = [[UIView alloc] init];
        ViewRadius(_endContView, CGFloatIn750(32));
        _endContView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    
    return _endContView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.text = @"0";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _subLabel.text = @"0";
        _subLabel.numberOfLines = 1;
        _subLabel.textAlignment = NSTextAlignmentCenter;
        [_subLabel setFont:[UIFont boldFontContent]];
    }
    return _subLabel;
}

#pragma mark - set fun
- (void)setName:(NSString *)title subName:(NSString *)subTitle  pickerMode:(BRDatePickerMode)model handlerBlock:(void(^)(NSDate *,NSDate*))handleBlock {
    self.handleBlock = handleBlock;
    self.nameLabel.text = title;
    self.subLabel.text = subTitle;
    
    self.beginDate = [NSDate new];
    self.endDate = [NSDate new];
    self.beginMode = model;
    self.endMode = model;
    
    self.dateBeginPicker.pickerMode = self.beginMode;
    self.dateEndPicker.pickerMode = self.endMode;
    
    [self.dateBeginPicker setSelectDate:self.beginDate];
    [self.dateEndPicker setSelectDate:self.endDate];
    
    
    [self.dateEndPicker reloadData];
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}

+ (void)setAlertName:(NSString *)title subName:(NSString *)subTitle pickerMode:(BRDatePickerMode)model handlerBlock:(void(^)(NSDate *,NSDate *))handleBlock  {
    [[ZAlertBeginAndEndTimeView sharedManager] setName:title subName:subTitle pickerMode:model handlerBlock:handleBlock];
}

@end
