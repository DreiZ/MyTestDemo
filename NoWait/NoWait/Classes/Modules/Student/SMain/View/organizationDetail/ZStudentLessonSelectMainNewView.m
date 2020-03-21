//
//  ZStudentLessonSelectMainNewView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectMainNewView.h"
#import "ZStudentLessonBuySelectViem.h"

#define  MenuWindow        [UIApplication sharedApplication].keyWindow

@interface ZStudentLessonSelectMainNewView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) ZStudentLessonBuySelectViem *lessonView;

@end


@implementation ZStudentLessonSelectMainNewView


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
    
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (ZStudentLessonBuySelectViem *)lessonView {
    if (!_lessonView) {
//        __weak typeof(self) weakSelf = self;
        _lessonView = [[ZStudentLessonBuySelectViem alloc] init];
    }
    
    return _lessonView;
}
#pragma mark --切换显示
- (void)showSelectViewWithType:(ZLessonBuyType )type {
    _buyType = type;
    [self addSubview:self.lessonView];
    self.lessonView.frame = CGRectMake(0, KScreenHeight/5.0f *2.5, KScreenWidth, KScreenHeight/5.0f * 2.5);
    
    
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
@end

