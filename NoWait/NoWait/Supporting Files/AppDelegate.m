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

@end
