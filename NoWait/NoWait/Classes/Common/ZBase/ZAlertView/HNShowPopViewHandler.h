//
//  HNShowPopViewHandler.h
//  hntx
//
//  Created by RoyLei on 2018/6/5.
//  Copyright © 2018年 LaKa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HNShowPopViewType) {
    HNShowPopViewTypeSpringMiddle = 0,
    HNShowPopViewTypeSpringTop    = 1,
    HNShowPopViewTypeSpringBottom = 2,
    HNShowPopViewTypeNormalBottom = 3,
};

typedef void(^HNShowPopViewNoParamsBlock)(void);

/**
 显示弹框处理类
 */
@interface HNShowPopViewHandler : NSObject

@property (strong, nonatomic, readonly) UIControl *backgroundView;
@property (weak,   nonatomic, readonly) UIView    *containerView;/**<必须先设置containerView*/
@property (weak,   nonatomic, readonly) UIView    *popContentView;

@property (assign, nonatomic) BOOL useBlurBackground;

@property (copy, nonatomic) HNShowPopViewNoParamsBlock backgroundViewPressedBlock;
@property (copy, nonatomic) HNShowPopViewNoParamsBlock viewDidDisappearPressedBlock;

/**
 弹出界面动画显示

 @param contentView 要显示的界面
 @param containerView 要显示在的容器View
 @param useBlurBackground 是否使用模糊化背景
 @param popType 弹出动画方式
 @return 控制显示实例
 */
+ (instancetype)showContentView:(UIView *)contentView
                inContainerView:(UIView *)containerView
              useBlurBackground:(BOOL)useBlurBackground
                        popType:(HNShowPopViewType)popType;

- (void)setBackgroundViewPressedBlock:(HNShowPopViewNoParamsBlock)backgroundViewPressedBlock;
- (void)setViewDidDisappearPressedBlock:(HNShowPopViewNoParamsBlock)viewDidDisappearPressedBlock;

/**
 *  消失动画
 */
- (void)dissmiss;

- (void)dissmissWithCompletion:(HNShowPopViewNoParamsBlock)completion;

@end
