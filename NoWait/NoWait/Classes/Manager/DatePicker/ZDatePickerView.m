//
//  ZDatePickerView.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/11/6.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import "ZDatePickerView.h"

@interface ZDatePickerView ()
@property (nonatomic,strong) UIDatePicker *iDatePicker;
@property (nonatomic,strong) NSDate *orDate;

@end

@implementation ZDatePickerView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = RGBAColor(1, 1, 1, 0.5);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    

    UIButton *backGroundBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backGroundBtn bk_whenTapped:^{
        [self removeFromSuperview];
    }];
    [self addSubview:backGroundBtn];
    [backGroundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    UIView *contView = [[UIView alloc] init];
    contView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(580));
    }];
    
    UIView *topHanderView = [[UIView alloc] init];
    topHanderView.backgroundColor = [UIColor whiteColor];
    [contView addSubview:topHanderView];
    [topHanderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(contView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KLineColor;
    [topHanderView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topHanderView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn bk_addEventHandler:^(id sender) {
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    [cancleBtn setTitleColor:KMainColor forState:UIControlStateHighlighted];
    [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [topHanderView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(topHanderView);
        make.width.mas_equalTo(60);
    }];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    [sureBtn setTitleColor:KMainColor forState:UIControlStateHighlighted];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sureBtn bk_addEventHandler:^(id sender) {
        if (_dateSelectBlock) {
            _dateSelectBlock(self.iDatePicker.date);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [topHanderView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(topHanderView);
        make.width.mas_equalTo(60);
    }];
    
    [contView addSubview:self.iDatePicker];
    [self.iDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contView);
        make.top.equalTo(topHanderView.mas_bottom);
    }];
}

- (UIDatePicker *)iDatePicker {
    if (!_iDatePicker) {
        __weak typeof(self) weakSelf = self;
        _iDatePicker = [[UIDatePicker alloc] init];
        _iDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _iDatePicker.datePickerMode = UIDatePickerModeDate;
        _iDatePicker.maximumDate = [NSDate new];
        
        [_iDatePicker setDate:[NSDate date]];
        [_iDatePicker bk_addEventHandler:^(UIDatePicker *sender) {
            if (weakSelf.dateSelectBlock) {
                weakSelf.dateSelectBlock(sender.date);
            }
            NSLog(@"date %@",sender.date);
        } forControlEvents:UIControlEventValueChanged];
    }
    
    return _iDatePicker;
}

+ (void)showTimePickerInView:(UIView *)view dateSelect:(void(^)(NSDate *))selectBlock{
    ZDatePickerView *picker = [[ZDatePickerView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    picker.dateSelectBlock = selectBlock;
    [view addSubview:picker];
}

+ (void)showTimePickerInView:(UIView *)view date:(NSDate *)date dateSelect:(void(^)(NSDate *))selectBlock{
    ZDatePickerView *picker = [[ZDatePickerView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    picker.dateSelectBlock = selectBlock;
    if (date) {
        [picker.iDatePicker setDate:date];
    }else{
       [picker.iDatePicker setDate:[NSDate date]];
    }
    [view addSubview:picker];
}
@end
