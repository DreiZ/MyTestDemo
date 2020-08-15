//
//  AppDelegate.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLaunchManager.h"
#import "AppDelegate+AppService.h"
#import "AppDelegate+PushService.h"
#import "ZPayManager.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import "ZStudentMessageVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //初始化UI
    [[ZLaunchManager sharedInstance] launchInWindow:self.window];
    [[ZLaunchManager sharedInstance] showIntroductionOrAdvertise];
//
    [self initService];
    [self launchAnimation];
    
    //注册推送通知
    [self registerNotificationDidFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [ZStudentMessageVC refreshMessageNum];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application{
    
}


#pragma mark 懒加载
- (UIWindow *)window
{
//     return [[[UIApplication sharedApplication] windows] indexOfObject:0];
//    if (!_window) {
//        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    }
    
    return _window;
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


#pragma mark - Private Methods
- (void)launchAnimation {
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIImageView *logo = nil;
    for (UIView *temp in viewController.view.subviews) {
        if ([temp.restorationIdentifier isEqualToString:@"logo"]) {
            logo = (UIImageView *)temp;
            temp.frame = CGRectMake((KScreenWidth - 53)/2.0, (KScreenHeight - 53 - 43)-safeAreaBottom(), 53, 53);
            logo.hidden = YES;
        }
    }
    UIView *launchView = viewController.view;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] windows][0];
    launchView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [mainWindow addSubview:launchView];
    [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}

#pragma mark 支付回调
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        return [[ZPayManager sharedManager] pay_handleUrl:url];
    }
    
    return result;;
}

#pragma mark Universal Link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *url = userActivity.webpageURL;
       // TODO 根据需求进行处理
        DLog(@"webpageURL %@",url);
         return [[ZPayManager sharedManager] pay_handleUrl:url];
    }
      // TODO 根据需求进行处理
    return YES;
}

@end
