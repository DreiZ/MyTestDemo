//
//  UIViewController+PopGesture.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (PopGesture)<UIGestureRecognizerDelegate>

/// 禁用手势返回（默认为NO）
@property (nonatomic, assign) BOOL disablePopGesture;

@end

NS_ASSUME_NONNULL_END
