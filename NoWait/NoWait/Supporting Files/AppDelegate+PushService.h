//
//  AppDelegate+PushService.h
//  ZBigHealth
//
//  Created by zzz on 2018/10/27.
//  Copyright © 2018 zzz. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (PushService)<UNUserNotificationCenterDelegate>

- (void)registerNotificationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

