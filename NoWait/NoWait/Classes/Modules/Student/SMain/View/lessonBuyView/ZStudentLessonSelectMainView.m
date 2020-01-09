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
    
    
    [self addSubview:self.lessonView];
    [self.lessonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(KScreenHeight/5.0f * 3);
    }];
    
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
        _lessonView.lessonBlock = ^(ZStudentDetailLessonListModel * model) {
            
        };
        _lessonView.closeBlock = ^{
            [weakSelf removeFromSuperview];
        };
    }
    
    return _lessonView;
}


#pragma mark --切换显示
- (void)showSelectView {
    
    [MenuWindow addSubview:self];
	
    self.frame = CGRectMake(0 , KScreenHeight, KScreenWidth, KScreenHeight);
    self.alpha = 0;
    
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.frame = CGRectMake(0 , 0, KScreenWidth, KScreenHeight);
        self.alpha = 1;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
@end
