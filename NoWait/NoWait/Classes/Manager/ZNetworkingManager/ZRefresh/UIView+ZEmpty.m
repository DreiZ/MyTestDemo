//
//  UIView+ZEmpty.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "UIView+ZEmpty.h"
#import "UIView+Extensions.h"

@implementation UIView (ZEmpty)

- (void)showEmptyViewWithTitle:(NSString *)title
{
    CGRect rect = CGRectEqualToRect(self.bounds, CGRectZero) ? CGRectMake(15, 0, SCREEN_WIDTH - 30, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVBAR_HEIGHT) : self.bounds;
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    [label setNumberOfLines:0];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setTextColor:[UIColor grayColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:title ? title : @"没有请求到相应数据"];
    [self showTipView:label retryAction:nil];
}

- (void)showErrorViewWithTitle:(NSString *)title
{
    [self showErrorViewWithTitle:title retryAction:nil];
}

- (void)showErrorViewWithTitle:(NSString *)title retryAction:(void (^)(id userData))retryAction
{
    [self showErrorViewWithTitle:title userData:nil retryAction:retryAction];
}

- (void)showErrorViewWithTitle:(NSString *)title userData:(id)userData retryAction:(void (^)(id userData))retryAction
{
    CGRect rect = CGRectEqualToRect(self.bounds, CGRectZero) ? CGRectMake(15, 0, SCREEN_WIDTH - 30, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVBAR_HEIGHT) : self.bounds;
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    [label setNumberOfLines:0];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setTextColor:[UIColor grayColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self showTipView:label userData:userData retryAction:retryAction];
}

@end
