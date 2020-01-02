//
//  ZMenuItem.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "ZMenuItem.h"
#import <TLTabBarController/TLBadge.h>

ZMenuItem *createMenuItem(NSString *icon, NSString *title)
{
    ZMenuItem *item = [[ZMenuItem alloc] init];
    [item setIconName:icon];
    [item setTitle:title];
    return item;
}


@implementation ZMenuItem

- (void)setBadge:(NSString *)badge
{
    _badge = badge;
    _badgeSize = [TLBadge badgeSizeWithValue:badge];
}

- (void)setRightIconURL:(NSString *)rightIconURL withRightIconBadge:(BOOL)rightIconBadge
{
    [self setRightIconURL:rightIconURL];
    [self setShowRightIconBadge:rightIconBadge];
}

- (BOOL)showRightIconBadge
{
    if (!self.rightIconURL) {
        return NO;
    }
    return _showRightIconBadge;
}

@end
