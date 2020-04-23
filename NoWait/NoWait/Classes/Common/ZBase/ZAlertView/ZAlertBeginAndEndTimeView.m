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

@interface ZAlertBeginAndEndTimeView ()<PGDatePickerDelegate>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *endContView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *subLabel;

@property (nonatomic,strong) PGDatePicker *dateBeginPicker;
@property (nonatomic,strong) PGDatePicker *dateEndPicker;
@property (nonatomic,strong) NSDateComponents *beginComponents;
@property (nonatomic,strong) NSDateComponents *endComponents;

@property (nonatomic,strong) void (^handleBlock)(NSDateComponents *,NSDateComponents *);
 
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
            make.top.equalTo(topView.mas_bottom);
        }];
    }
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(400));
        make.width.mas_equalTo(CGFloatIn750(690));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.endContView.mas_top).offset(-CGFloatIn750(20));
    }];
    
    UIView *topView = [[UIView alloc] init];
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
        if (self.handleBlock) {
            self.handleBlock(self.beginComponents, self.endComponents);
        }
        [self removeFromSuperview];
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
        make.top.equalTo(topView.mas_bottom);
    }];
   
}

- (PGDatePicker *)dateBeginPicker {
    if (!_dateBeginPicker) {
        _dateBeginPicker = [[PGDatePicker alloc]init];
        _dateBeginPicker.backgroundColor = [UIColor whiteColor];
        _dateBeginPicker.lineBackgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        //设置选中行的字体颜色
        _dateBeginPicker.textColorOfSelectedRow = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        //设置未选中行的字体颜色
        _dateBeginPicker.textColorOfOtherRow = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _dateBeginPicker.delegate = self;
        _dateBeginPicker.autoSelected = YES;
        _dateBeginPicker.datePickerMode = PGDatePickerModeDate;
    }
    return _dateBeginPicker;
}


- (PGDatePicker *)dateEndPicker {
    if (!_dateEndPicker) {
        _dateEndPicker = [[PGDatePicker alloc]init];
        _dateEndPicker.backgroundColor = [UIColor whiteColor];
        _dateEndPicker.lineBackgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        //设置选中行的字体颜色
        _dateEndPicker.textColorOfSelectedRow = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        //设置未选中行的字体颜色
        _dateEndPicker.textColorOfOtherRow = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _dateEndPicker.delegate = self;
        _dateEndPicker.autoSelected = YES;
        _dateEndPicker.datePickerMode = PGDatePickerModeDate;
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
- (void)setName:(NSString *)title subName:(NSString *)subTitle  pickerMode:(PGDatePickerMode)model handlerBlock:(void(^)(NSDateComponents *,NSDateComponents*))handleBlock {
    self.handleBlock = handleBlock;
    self.nameLabel.text = title;
    self.subLabel.text = subTitle;
    self.dateEndPicker.datePickerMode = model;
    self.dateBeginPicker.datePickerMode = model;
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}

+ (void)setAlertName:(NSString *)title subName:(NSString *)subTitle pickerMode:(PGDatePickerMode)model handlerBlock:(void(^)(NSDateComponents *,NSDateComponents *))handleBlock  {
    [[ZAlertBeginAndEndTimeView sharedManager] setName:title subName:subTitle pickerMode:model handlerBlock:handleBlock];
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    DLog(@"dateComponents = %@", dateComponents);
    if (datePicker == self.dateBeginPicker) {
        self.beginComponents = dateComponents;
    }
    if (datePicker == self.dateEndPicker) {
        self.endComponents = dateComponents;
    }
}
@end
