//
//  ZStudentLessonSelectMainOrderTimeView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectMainOrderTimeView.h"
#import "ZStudentLessonSelectOrderTimeView.h"
#import "ZBaseUnitModel.h"

#define  MenuWindow        [UIApplication sharedApplication].keyWindow

@interface ZStudentLessonSelectMainOrderTimeView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) ZStudentLessonSelectOrderTimeView *timeView;

@end


@implementation ZStudentLessonSelectMainOrderTimeView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWithRGB:0x000000 alpha:0.8], [UIColor colorWithRGB:0xffffff alpha:0.2]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    __weak typeof(self) weakSelf = self;
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (ZStudentLessonSelectOrderTimeView *)timeView {
    if (!_timeView) {
        __weak typeof(self) weakSelf = self;
        _timeView = [[ZStudentLessonSelectOrderTimeView alloc] init];
        _timeView.bottomBlock = ^{
            if (!weakSelf.timeModel) {
                [TLUIUtility showErrorHint:@"您还没有选择预约时间"];
                return ;
            }
            [weakSelf removeFromSuperview];
            if (weakSelf.completeBlock) {
                weakSelf.completeBlock(weakSelf.timeModel);
            }
        };
        
        _timeView.timeBlock = ^(ZOriganizationLessonExperienceTimeModel *model) {
            weakSelf.timeModel = model;
        };
        
        _timeView.closeBlock = ^{
            [weakSelf removeFromSuperview];
        };
        
        _timeView.lastStepBlock = ^{
            [weakSelf timeToLesson];
        };
    }
    
    return _timeView;
}

#pragma mark --切换显示
- (void)showToTime{
    self.timeView.list = self.experience_time;
    [self addSubview:self.timeView];
    
    [MenuWindow addSubview:self];
    self.frame = CGRectMake(0 , 0, KScreenWidth, KScreenHeight);
    self.alpha = 0;
    
    self.timeView.frame = CGRectMake(0, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
    
    [UIView animateWithDuration:.5 delay:0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)timeToLesson{
    [self removeFromSuperview];
}
@end


