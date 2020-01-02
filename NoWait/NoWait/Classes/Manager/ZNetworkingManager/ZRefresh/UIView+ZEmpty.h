//
//  UIView+ZEmpty.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/16.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZEmpty)

- (void)showEmptyViewWithTitle:(NSString *)title;

- (void)showErrorViewWithTitle:(NSString *)title retryAction:(void (^)(id userData))retryAction;
- (void)showErrorViewWithTitle:(NSString *)title userData:(id)userData retryAction:(void (^)(id userData))retryAction;

@end

