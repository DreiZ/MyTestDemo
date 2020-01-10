//
//  ZStudentLessonSelectMainView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectMainView.h"
#import "ZStudentLessonSelectLessonView.h"
#import "ZStudentLessonSelectCoachView.h"
#import "ZStudentLessonSelectTimeView.h"

#define  MenuWindow        [UIApplication sharedApplication].keyWindow

@interface ZStudentLessonSelectMainView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) ZStudentLessonSelectLessonView *lessonView;
@property (nonatomic,strong) ZStudentLessonSelectCoachView *coachView;
@property (nonatomic,strong) ZStudentLessonSelectTimeView *timeView;

@end


@implementation ZStudentLessonSelectMainView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.8];
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
    
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = KWhiteColor;
    }
    return _contView;
}

- (ZStudentLessonSelectLessonView *)lessonView {
    if (!_lessonView) {
        __weak typeof(self) weakSelf = self;
        _lessonView = [[ZStudentLessonSelectLessonView alloc] init];
        _lessonView.buyType = self.buyType;
        _lessonView.lessonBlock = ^(ZStudentDetailLessonListModel * model) {
            
        };
        _lessonView.closeBlock = ^{
            [weakSelf removeFromSuperview];
        };
        _lessonView.bottomBlock = ^{
            [weakSelf lessonToCoach];
        };
    }
    
    return _lessonView;
}

- (ZStudentLessonSelectCoachView *)coachView {
    if (!_coachView) {
        __weak typeof(self) weakSelf = self;
        _coachView = [[ZStudentLessonSelectCoachView alloc] init];
        _coachView.buyType = self.buyType;
        _coachView.coachBlock = ^(ZStudentDetailLessonCoachModel *model) {
             
        };
        _coachView.closeBlock = ^{
            [weakSelf removeFromSuperview];
        };
        _coachView.lastStepBlock = ^{
            if (weakSelf.buyType == lessonBuyTypeSubscribeInitial || weakSelf.buyType == lessonBuyTypeSubscribeInitial) {
                [weakSelf coachLastStep];
            }else{
               
            }
        };
        _coachView.bottomBlock = ^{
            [weakSelf coachToTime];
        };
    }
    
    return _coachView;
}


- (ZStudentLessonSelectTimeView *)timeView {
    if (!_timeView) {
        __weak typeof(self) weakSelf = self;
        _timeView = [[ZStudentLessonSelectTimeView alloc] init];
        _timeView.buyType = self.buyType;
        _timeView.timeBlock = ^(ZStudentDetailLessonTimeModel *model) {
            
        };
        _timeView.closeBlock = ^{
            [weakSelf removeFromSuperview];
        };
        _timeView.lastStepBlock = ^{
            if (weakSelf.buyType == lessonBuyTypeSubscribeInitial || weakSelf.buyType == lessonBuyTypeSubscribeInitial) {
                [weakSelf coachLastStep];
            }else{
               
            }
        };
    }
    
    return _timeView;
}
#pragma mark --切换显示
- (void)showSelectViewWithType:(lessonBuyType )type {
    
    _buyType = type;
    
    if (type == lessonBuyTypeSubscribeInitial || type == lessonBuyTypeBuyInitial) {
        [self addSubview:self.lessonView];
        self.lessonView.frame = CGRectMake(0, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        
        NSMutableArray *list = @[].mutableCopy;
        for (int i = 0; i < 10; i++) {
            ZStudentDetailLessonListModel *model = [[ZStudentDetailLessonListModel alloc] init];
            model.lessonTitle = @"少儿游泳小班";
            model.lessonNum = @"课次：12节";
            model.lessonTime = @"课时：120分钟";
            model.lessonStudentNum = @"人数：20人";
            model.lessonPrice = @"价格：888人";
            [list addObject:model];
        }
        self.lessonView.list = list;
    }else if (type == lessonBuyTypeSubscribeBeginLesson || type == lessonBuyTypeBuyBeginLesson){
        NSMutableArray *list = @[].mutableCopy;
           for (int i = 0; i < 10; i++) {
               ZStudentDetailLessonCoachModel *model = [[ZStudentDetailLessonCoachModel alloc] init];
               model.coachName = @"李小冉";
               model.coachPrice = @"价格：1688";
               model.coachImage = [NSString stringWithFormat:@"coachSelect%d",i%5 + 1];
               [list addObject:model];
           }
           self.coachView.list = list;
           [self addSubview:self.coachView];
           
            self.coachView.frame = CGRectMake(KScreenWidth, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
    }
    
    [MenuWindow addSubview:self];
	
    self.frame = CGRectMake(0 , KScreenHeight, KScreenWidth, KScreenHeight);
    self.alpha = 0;
    
    [UIView animateWithDuration:.5 delay:0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.frame = CGRectMake(0 , 0, KScreenWidth, KScreenHeight);
        self.alpha = 1;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)lessonToCoach{
    NSMutableArray *list = @[].mutableCopy;
    for (int i = 0; i < 10; i++) {
        ZStudentDetailLessonCoachModel *model = [[ZStudentDetailLessonCoachModel alloc] init];
        model.coachName = @"李小冉";
        model.coachPrice = @"价格：1688";
        model.coachImage = [NSString stringWithFormat:@"coachSelect%d",i%5 + 1];
        [list addObject:model];
    }
    self.coachView.list = list;
    [self addSubview:self.coachView];
    
     self.coachView.frame = CGRectMake(KScreenWidth, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
    
    [UIView animateWithDuration:.5 delay:0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.lessonView.frame = CGRectMake(-KScreenWidth , KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        self.coachView.frame = CGRectMake(0, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)coachLastStep{
   
    [UIView animateWithDuration:.5 delay:0  options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.lessonView.frame = CGRectMake(0 , KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        self.coachView.frame = CGRectMake(KScreenWidth, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (void)coachToTime{
    NSMutableArray *list = @[].mutableCopy;
    for (int i = 0; i < 10; i++) {
        ZStudentDetailLessonTimeModel *model = [[ZStudentDetailLessonTimeModel alloc] init];
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
       self.coachView.frame = CGRectMake(-KScreenWidth , KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        self.timeView.frame = CGRectMake(0, KScreenHeight/5.0f *2, KScreenWidth, KScreenHeight/5.0f * 3);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
@end
