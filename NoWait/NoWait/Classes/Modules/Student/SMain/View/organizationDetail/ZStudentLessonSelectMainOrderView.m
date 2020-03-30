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
        _lessonView.bottomBlock = ^{
            [weakSelf teacherToTime];
        };
    }
    return _lessonView;
}


- (ZStudentLessonSelectOrderTimeView *)timeView {
    if (!_timeView) {
        __weak typeof(self) weakSelf = self;
        _timeView = [[ZStudentLessonSelectOrderTimeView alloc] init];
        _timeView.bottomBlock = ^{
            [weakSelf removeFromSuperview];
            if (weakSelf.completeBlock) {
                weakSelf.completeBlock(0);
            }
        };
        
        _timeView.timeBlock = ^(ZStudentDetailLessonTimeModel *model) {
            
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
    NSMutableArray *list = @[].mutableCopy;
    for (int i = 0; i < 10; i++) {
        ZStudentDetailLessonTimeModel *model = [[ZStudentDetailLessonTimeModel alloc] init];
        model.isTimeSelected = i==0? YES: NO;
        model.time = @"周五 10-25日";
        NSArray *subTimeArr = @[@"09:00", @"10:00",@"11:00", @"12:00",@"13:00", @"14:00",@"15:00", @"16:00",@"17:00", @"18:00",@"19:00", @"20:00",@"21:00", @"22:00",@"23:00", @"24:00"];
        NSMutableArray *subArr = @[].mutableCopy;
        for (int j = 0; j < subTimeArr.count; j++) {
            ZStudentDetailLessonTimeSubModel *subModel = [[ZStudentDetailLessonTimeSubModel alloc] init];
            subModel.subTime = subTimeArr[j];
            [subArr addObject:subModel];
        }
        model.subTimes = subArr;
        [list addObject:model];
    }
    self.timeView.list = list;
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

