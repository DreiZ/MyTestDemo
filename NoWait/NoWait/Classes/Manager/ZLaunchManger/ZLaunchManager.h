//
//  ZLaunchManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TLTabBarController.h>


@interface ZLaunchManager : NSObject

//当前根控制器
@property (nonatomic, strong) __kindof UIViewController *curRootVC;

//根tabBarController
@property (nonatomic, strong) TLTabBarController *tabBarController;

+ (ZLaunchManager *)sharedInstance;


/**
 启动，初始化
 */
- (void)launchInWindow:(UIWindow *)window;
//显示广告业或者介绍页
- (void)showIntroductionOrAdvertise;
//介绍页
- (void)showIntroduction;
//广告页
- (void)showAdvertise;


- (void)showLoginVC;

- (void)showMainTab;


- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;
@end

