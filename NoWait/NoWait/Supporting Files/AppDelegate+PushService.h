//
//  AppDelegate+PushService.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/27.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (PushService)<UNUserNotificationCenterDelegate>

- (void)registerNotificationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

