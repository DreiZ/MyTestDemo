//
//  ZLaunchManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLaunchManager.h"

@implementation ZLaunchManager

#pragma mark - # Getters
- (TLTabBarController *)tabBarController
{
    if (!_tabBarController) {
        TLTabBarController *tabbarController = [[TLTabBarController alloc] init];
        [tabbarController.tabBar setBackgroundColor:[UIColor colorGrayBG]];
        [tabbarController.tabBar setTintColor:[UIColor colorGreenDefault]];
        _tabBarController = tabbarController;
    }
    return _tabBarController;
}

@end
