//
//  ZStudentLessonSelectMainOrderView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectMainOrderView.h"
#import "ZStudentLessonSelectOrderLessonView.h"
#import "ZStudentLessonSelectCoachView.h"
#import "ZStudentLessonSelectOrderTimeView.h"

#define  MenuWindow        [UIApplication sharedApplication].keyWindow

@interface ZStudentLessonSelectMainOrderView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) ZStudentLessonSelectOrderLessonView *lessonView;
@property (nonatomic,strong) ZStudentLessonSelectOrderTimeView *timeView;
@property (nonatomic,strong) ZStoresDetailModel *detailModel;
@property (nonatomic,strong) ZOrderAddModel *orderModel;

@property (nonatomic,strong) ZOriganizationLessonListModel *listModel;
@property (nonatomic,strong) ZOriganizationLessonExperienceTimeModel *timeModel;

@end


@implementation ZStudentLessonSelectMainOrderView
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
    [backBtn bk_whenTapped:^{
        [weakSelf removeFromSuperview];
    }];
    
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _orderModel = [[ZOrderAddModel alloc] init];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (ZStudentLessonSelectOrderLessonView *)lessonView {
    if (!_lessonView) {
        __weak typeof(self) weakSelf = self;
        _lessonView = [[ZStudentLessonSelectOrderLessonView alloc] init];
        _lessonView.closeBlock = ^{
            [weakSelf removeFromSuperview];
        };
        _lessonView.handleBlock = ^(ZOriganizationLessonListModel *model) {
            weakSelf.listModel = model;
        };
        _lessonView.bottomBlock = ^{
            if (weakSelf.listModel) {
                [weakSelf teacherToTime];
            }else{
                [TLUIUtility showErrorHint:@"您还没有选择课程"];
            }
        };
    }
    return _lessonView;
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
                weakSelf.completeBlock(weakSelf.listModel,weakSelf.timeModel);
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
- (void)showSelectViewWithModel:(ZStoresDetailModel *)model {
    _detailModel = model;
    self.lessonView.addModel = self.orderModel;
    self.lessonView.detailModel = model;
    [self addSubview:self.lessonView];
    self.lessonView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight/5.0f * 3.2);
    
    [MenuWindow addSubview:self];
    
    self.frame = CGRectMake(0 , KScreenHeight, KScreenWidth, KScreenHeight);
    self.alpha = 0;
    
    [UIView animateWithDuration:.5 delay:0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.frame = CGRectMake(0 , 0, KScreenWidth, KScreenHeight);
        self.alpha = 1;
        self.lessonView.frame = CGRectMake(0, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)teacherToTime{
    self.timeView.list = self.listModel.experience_time;
    [self addSubview:self.timeView];
    
     self.timeView.frame = CGRectMake(KScreenWidth, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
    
    [UIView animateWithDuration:.5 delay:0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.lessonView.frame = CGRectMake(-KScreenWidth , KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        self.timeView.frame = CGRectMake(0, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)timeToLesson{
    [self addSubview:self.lessonView];
    
     self.lessonView.frame = CGRectMake(-KScreenWidth, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
    
    [UIView animateWithDuration:.5 delay:0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.timeView.frame = CGRectMake(KScreenWidth , KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        self.lessonView.frame = CGRectMake(0, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
@end

