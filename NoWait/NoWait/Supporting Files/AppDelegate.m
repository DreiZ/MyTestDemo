//
//  AppDelegate.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLaunchManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //初始化UI
    [[ZLaunchManager sharedInstance] launchInWindow:self.window];
    [[ZLaunchManager sharedInstance] showIntroductionOrAdvertise];
//
    
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
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return _window;
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}



@end
