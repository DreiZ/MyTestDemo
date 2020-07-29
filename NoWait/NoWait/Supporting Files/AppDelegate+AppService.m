//
//  AppDelegate+AppService.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/27.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "ZLaunchManager.h"
#import "IQKeyboardManager.h"
#import "ZPayManager.h"
#import "ZUMengShareManager.h"

#import "JPFPSStatus.h"

@implementation AppDelegate (AppService)

#pragma mark ————— 初始化服务 —————
-(void)initService {
//    //注册登录状态监听
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(loginStateChange:)
//                                                 name:KNotificationLoginStateChange
//                                               object:nil];
//
    [IQKeyboardManager sharedManager].toolbarTintColor = [UIColor colorMain];
    
    [AMapServices sharedServices].apiKey = KMapKey;
    [[ZUMengShareManager sharedManager] umengShare];
    [[ZPayManager sharedManager] wxPayRefisterApp];
    //更新用户信息
    if ([ZUserHelper sharedHelper].user) {
        [[ZUserHelper sharedHelper] updateUserInfoWithCompleteBlock:^(BOOL isSuccess) {
            if (!isSuccess) {
            }
        }];
    }
    
    [ZImagePickerManager initSDWebImage];

#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
}


#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
//    [[ZLaunchManager sharedInstance] launchInWindow:self.window];
}


//获取当前根vc
-(UIViewController *)getCurrentVC
{

    UIViewController *result = nil;

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }

    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;

    DLog(@"getCurrentVC %@", result);
    return result;
}



//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentUIVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}

@end
