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
#import "ZPayManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //初始化UI
    [[ZLaunchManager sharedInstance] launchInWindow:self.window];
//    [[ZLaunchManager sharedInstance] showIntroductionOrAdvertise];
//
    [self initService];
    [self launchAnimation];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

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
    
    UIView *launchView = viewController.view;
    UIWindow *mainWindow = [[UIApplication sharedApplication] windows][0];
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}

#pragma mark 支付回调
/**
 *  @author gitKong
 *
 *  iOS 9.0 之前 会调用
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (!result) {
        // 其他如支付等SDK的回调
        return [[ZPayManager sharedManager] pay_handleUrl:url];
//    }
//    return result;
    
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
//    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
//    if (!result) {
        return [[ZPayManager sharedManager] pay_handleUrl:url];
//    }
    
//    return result;;
}
#pragma mark Universal Link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *url = userActivity.webpageURL;
       // TODO 根据需求进行处理
        NSLog(@"--------------sssssss%@",url);
    }
      // TODO 根据需求进行处理
    return YES;
}

/**
 *  @author gitKong
 *
 *  最老的版本，最好也写上
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (!result) {
        // 其他如支付等SDK的回调
        return [[ZPayManager sharedManager] pay_handleUrl:url];
//    }
//    return result;
    
}
@end
