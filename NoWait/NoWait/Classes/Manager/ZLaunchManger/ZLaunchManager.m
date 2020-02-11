//
//  ZLaunchManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLaunchManager.h"
#import "ZUserHelper.h"
#import "AppDelegate.h"
#import "ZAdvertiseHelper.h"
#import "ZAccountViewController.h"
#import "ZIntroductryPagesManager.h"
#import "AppDelegate+AppService.h"

#import "ZStudentMainVC.h"
#import "ZStudentMessageVC.h"
#import "ZStudentMineVC.h"

@interface ZLaunchManager ()

@property (nonatomic, weak) UIWindow *window;

@end

@implementation ZLaunchManager
@synthesize tabBarController = _tabBarController;

+ (ZLaunchManager *)sharedInstance
{
    static ZLaunchManager *rootVCManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVCManager = [[self alloc] init];
    });
    return rootVCManager;
}


- (void)launchInWindow:(UIWindow *)window
{
    
    if (window) {
        self.window = window;
    }
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userID"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    if ([ZUserHelper sharedHelper].isLogin) {      // 已登录
        [self showMainTab];
    }
    else
    {  // 未登录
        ZAccountViewController *accountVC = [[ZAccountViewController alloc] init];
        @weakify(self);
        [accountVC setLoginSuccess:^{
            @strongify(self);
            [self launchInWindow:window];
        }];
        UINavigationController *navc = addNavigationController(accountVC);
        [self setCurRootVC:navc];
    }
}

- (void)showMainTab {
//    if ([ZUserHelper sharedHelper].isLogin) {      // 已登录
//        //第一次登录且为未保存广告信息
//        NSString *isFirst = [[NSUserDefaults standardUserDefaults] objectForKey:kHadAppLogin];
//        if (!isFirst) {
//            [ZAdvertiseHelper updateAdvertiserData];
//            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.0f",[[NSDate new] timeIntervalSince1970]] forKey:@"stepDay"];
//        }
//
//
//        [[NSUserDefaults standardUserDefaults] setObject:kHadAppLogin forKey:kHadAppLogin];
//
//
//        // 初始化用户信息
//        [self initUserData];
//
//    }
    
    [self.tabBarController setViewControllers:[self p_createTabBarChildViewController]];
    [self setCurRootVC:self.tabBarController];
    [self.tabBarController.tabBar setBarTintColor:KAdaptAndDarkColor(KWhiteColor, K1aBackColor)];
}


- (void)showLoginVC {
    if (![ZUserHelper sharedHelper].isLogin) {
        // 未登录
        ZAccountViewController *accountVC = [[ZAccountViewController alloc] init];
        @weakify(self);
        [accountVC setLoginSuccess:^{
            @strongify(self);
            [self launchInWindow:self.window];
        }];
        UINavigationController *navc = addNavigationController(accountVC);
        [self setCurRootVC:navc];
    }
}

- (void)setCurRootVC:(__kindof UIViewController *)curRootVC
{
    _curRootVC = curRootVC;
    
    {
        UIWindow *window = self.window ? self.window : [UIApplication sharedApplication].keyWindow;
        [window removeAllSubviews];
        [window setRootViewController:curRootVC];
//        [window addSubview:curRootVC.view];
        [window makeKeyAndVisible];
    }
}

#pragma mark  ------介绍页面-----------------------
- (void)showIntroductionOrAdvertise {
    NSString *isFirst = [[NSUserDefaults standardUserDefaults] objectForKey:kHadInApp];
    if (isFirst) {
        NSString *isLoginFirst = [[NSUserDefaults standardUserDefaults] objectForKey:kHadAppLogin];
        if (isLoginFirst) {
            [self showAdvertise];
        }
    }else{
        [self showIntroduction];
        [[NSUserDefaults standardUserDefaults] setObject:kHadInApp forKey:kHadInApp];
    }
}

- (void)showIntroduction {
    if (kStatusBarHeight > 20) {
        [ZIntroductryPagesManager showIntroductryPageView:@[@"introX_0.jpg", @"introX_1.jpg", @"introX_2"]];
        return;
    }
    [ZIntroductryPagesManager showIntroductryPageView:@[@"intro_0.jpg", @"intro_1.jpg", @"intro_2"]];
    
}

#pragma mark  ------广告页面-----------------------
- (void)showAdvertise {
    // 启动广告
    [ZAdvertiseHelper showAdvertiserView:nil];
}


#pragma mark - # Private Methods
- (NSArray *)p_createTabBarChildViewController
{
    ZStudentMainVC *studentMainVC = [[ZStudentMainVC alloc] init];
    ZStudentMessageVC *studentMessageVC = [[ZStudentMessageVC alloc] init];
    ZStudentMineVC *mineVC = [[ZStudentMineVC alloc] init];

    
    
    NSArray *data = @[addNavigationController(studentMainVC),
                      addNavigationController(studentMessageVC),
                      addNavigationController(mineVC),
                      ];
    return data;
    
}


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
