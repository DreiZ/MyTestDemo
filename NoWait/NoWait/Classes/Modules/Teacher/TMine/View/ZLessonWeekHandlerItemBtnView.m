//
//  ZLessonWeekHandlerItemBtnView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLessonWeekHandlerItemBtnView.h"

@interface ZLessonWeekHandlerItemBtnView ()
@property (nonatomic,strong) UIView *contView;

@end

@implementation ZLessonWeekHandlerItemBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.contView];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(self.contView.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(18));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(6));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *seletBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [seletBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handerBlock) {
            weakSelf.handerBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:seletBtn];
    [seletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _timeLabel.text = @"03/12";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [_timeLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
    }
    return _timeLabel;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _titleLabel.text = @"周一";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont boldFontSmall]];
    }
    return _titleLabel;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    if (date.isToday) {
        self.contView.backgroundColor = [UIColor colorMainSub];
    }else {
        self.contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    
    NSArray *week = @[@"周天",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    _titleLabel.text = week[date.weekday - 1];
    _timeLabel.text = [date formatMDWithSeparate:@"/"];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4 delay:0.2
         usingSpringWithDamping:0.3 initialSpringVelocity:0.5
    options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //这里书写动画相关代码
        [weakSelf.titleLabel setFont:[UIFont boldFontSmall]];
        [weakSelf.timeLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
        
//        weakSelf.titleLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMain]);
//        weakSelf.timeLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMain]);
        
        weakSelf.timeLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        weakSelf.titleLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
    //动画结束后执行的代码块
//        weakSelf.titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
//        weakSelf.timeLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        [weakSelf.titleLabel setFont:[UIFont boldFontSmall]];
        [weakSelf.timeLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
        
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.timeLabel.transform = CGAffineTransformIdentity;
            weakSelf.titleLabel.transform = CGAffineTransformIdentity;
        }];
    }];
}
@end
