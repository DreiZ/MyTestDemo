//
//  ZAlertDateHourPickerView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertDateHourPickerView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"

@interface ZAlertDateHourPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel *> *data1;
@property (nonatomic,strong) NSMutableArray <ZAlertDataItemModel *> *data2;
@property (nonatomic,strong) void (^handleBlock)(NSString *,NSString *);
 
@property (nonatomic,assign) NSInteger proIndex;
@property (nonatomic,assign) NSInteger cityIndex;

@end

@implementation ZAlertDateHourPickerView

static ZAlertDateHourPickerView *sharedManager;

+ (ZAlertDateHourPickerView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertDateHourPickerView alloc] init];
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
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(500));
        make.width.mas_equalTo(CGFloatIn750(690));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(80));
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
    [leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
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
        NSString *start;
        NSString *end;
        if (weakSelf.proIndex < 10) {
            start = [NSString stringWithFormat:@"0%ld:00",(long)weakSelf.proIndex];
        }else{
            start = [NSString stringWithFormat:@"%ld:00",(long)weakSelf.proIndex];
        }
        
        if (weakSelf.cityIndex < 10) {
            end = [NSString stringWithFormat:@"0%ld:00",(long)weakSelf.cityIndex];
               }else{
                   end = [NSString stringWithFormat:@"%ld:00",(long)weakSelf.cityIndex];
               }
        if (self.handleBlock) {
            self.handleBlock(start,end);
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
       bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
       [topView addSubview:bottomLineView];
       [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.bottom.equalTo(topView);
           make.height.mas_equalTo(0.5);
       }];
       
    
    [self.contView addSubview:self.pickView];
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contView);
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(-60));
        make.top.equalTo(topView.mas_bottom);
    }];
    
    //设置分割线
    for (UIView *line in self.pickView.subviews) {
        if (line.frame.size.height <= 1) {//0.6667
            line.backgroundColor = [UIColor clearColor];
        }
    }
    
    UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    middleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    middleLabel.text = @"~";
    middleLabel.numberOfLines = 0;
    middleLabel.textAlignment = NSTextAlignmentCenter;
    [middleLabel setFont:[UIFont fontContent]];
    [self.pickView addSubview:middleLabel];
    [middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.pickView);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        ViewRadius(_contView, CGFloatIn750(32));
        _contView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    
    return _contView;
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

- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
    }
    return _pickView;
}


- (void)setName:(NSString *)title handlerBlock:(void(^)(NSString *,NSString *))handleBlock {
    self.handleBlock = handleBlock;
    self.nameLabel.text = title;
    
    self.data1 = @[].mutableCopy;
    self.data2 = @[].mutableCopy;
    
    self.proIndex = 0;
    self.cityIndex = 1;
    
    for (int i = 0; i < 24; i++) {
       ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
        if (i < 10) {
            model.name = [NSString stringWithFormat:@"0%d:00",i];
        }else{
            model.name = [NSString stringWithFormat:@"%d:00",i];
        }
       
       [self.data1 addObject:model];
    }
    
    for (int i = 0; i < 24; i++) {
       ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
        if (i < 10) {
            model.name = [NSString stringWithFormat:@"0%d:00",i];
        }else{
            model.name = [NSString stringWithFormat:@"%d:00",i];
        }
       
       [self.data2 addObject:model];
    }
    
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
    [self.pickView reloadAllComponents];
    
    [self.pickView selectRow:0 inComponent:0 animated:YES];
    [self.pickView selectRow:1 inComponent:1 animated:YES];
}

+ (void)setAlertName:(NSString *)title handlerBlock:(void(^)(NSString *,NSString * ))handleBlock  {
    [[ZAlertDateHourPickerView sharedManager] setName:title handlerBlock:handleBlock];
}

+ (void)setAlertName:(NSString *)title now:(NSString *)nowDate  handlerBlock:(void(^)(NSString *,NSString * ))handleBlock  {
    [[ZAlertDateHourPickerView sharedManager] setName:title handlerBlock:handleBlock];
    if (nowDate) {
        NSArray *temp = [nowDate componentsSeparatedByString:@":"];
        if (temp && temp.count == 2) {
            NSInteger index = [temp[0] intValue];
            if (index < 24) {
                [ZAlertDateHourPickerView sharedManager].proIndex = index;
                [ZAlertDateHourPickerView sharedManager].cityIndex = index+1;
                [[ZAlertDateHourPickerView sharedManager].pickView selectRow:index inComponent:0 animated:YES];
                [[ZAlertDateHourPickerView sharedManager].pickView selectRow:index + 1 inComponent:1 animated:YES];
            }
        }
    }
}



#pragma mark -datapicker delegate

//自定义每个pickview的label
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIView *sectionView = [[UIView alloc] init];
//    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
//    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
//    [sectionView addSubview:bottomLineView];
//    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(sectionView);
//        make.height.mas_equalTo(0.5);
//    }];

    UILabel* pickerLabel = [UILabel new];
    pickerLabel.numberOfLines = 0;
    pickerLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    [pickerLabel setFont:[UIFont fontContent]];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];

    [sectionView addSubview:pickerLabel];
    [pickerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.right.equalTo(sectionView);
    }];

    return sectionView;
}

#pragma mark --pickerView delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        _proIndex = row;
        if (_cityIndex <= _proIndex) {
            if (_proIndex < 23) {
                _cityIndex = _proIndex+1;
            }else{
                _cityIndex = _proIndex;
            }
            
            [pickerView selectRow:_cityIndex inComponent:1 animated:YES];
        }
    }
    
    if (component == 1) {
        _cityIndex = row;
        if (_cityIndex <= _proIndex) {
            if (_proIndex < 23) {
                _cityIndex = _proIndex+1;
            }else{
                _cityIndex = _proIndex;
            }
            
            [pickerView selectRow:_cityIndex inComponent:1 animated:YES];
        }
    }
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.data1[row].name;
    }else if (component == 1){
        return self.data2[row].name;
    }
    
    return nil;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.data1.count;
    }else if (component == 1){
        return self.data2.count;
    }
    
    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return CGFloatIn750(86);
}

@end


