//
//  AppDelegate.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)shareAppDelegate;

@end

