//
//  AppDelegate+PushService.m
//  ZBigHealth
//
//  Created by zzz on 2018/10/27.
//  Copyright © 2018 zzz. All rights reserved.
//

#import "AppDelegate+PushService.h"
#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import "ZAppConfig.h"

#import "ZUMengShareManager.h"
#import "ZUserHelper.h"
#import "ZPushModel.h"
#import "ZPublicTool.h"
#import "ZLaunchManager.h"

@implementation AppDelegate (PushService)

- (void)registerNotificationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSString *version = [UIDevice currentDevice].systemVersion;
    
    [[ZUMengShareManager sharedManager] umengShare];
    
    // Push's basic setting
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    } else {
        // Fallback on earlier versions
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
}


// 注册成功回调方法，其中deviceToken即为APNs返回的token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if (@available(iOS 13.0, *)) {
        NSMutableString *deviceTokenString = [NSMutableString string];
        const char *bytes = deviceToken.bytes;
        NSInteger count = deviceToken.length;
        for (int i = 0; i < count; i++) {
            [deviceTokenString appendFormat:@"%02x", bytes[i]&0x000000FF];
        }
        [ZUserHelper sharedHelper].push_token = deviceTokenString;
        DLog(@"--2---------------------token %@--%@",deviceTokenString,[ZUserHelper sharedHelper].push_token);
    } else {
        
        
        NSString *token = [NSString stringWithFormat:@"%@",deviceToken];
        token=[token stringByReplacingOccurrencesOfString:@"<" withString:@""];
        token=[token stringByReplacingOccurrencesOfString:@">" withString:@""];
        token=[token stringByReplacingOccurrencesOfString:@" " withString:@""];
        [ZUserHelper sharedHelper].push_token = token;
        DLog(@"--2---------------------token %@--%@",token,[ZUserHelper sharedHelper].push_token);
    }
    
    [[ZUserHelper sharedHelper] updateToken:YES];
}
// 注册失败回调方法，处理失败情况
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DLog(@"--3----------------------token %@",@"失败");
}



//iOS10以下使用这两个方法接收通知，(前后台)
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    DLog(@"push userinfo %@",userInfo);
    ZPushModel *pushModel = [ZPushModel mj_objectWithKeyValues:userInfo];
    if(pushModel){
        [ZPublicTool pushNotifyHandle:pushModel];
    }
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
}


//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    DLog(@"push userinfo- %@",userInfo);
    
    ZPushModel *pushModel = [ZPushModel mj_objectWithKeyValues:userInfo];
    if(pushModel){
        [ZPublicTool pushNotifyHandle:pushModel];
    }
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        DLog(@"message push %@",userInfo);
        ZPushModel *pushModel = [ZPushModel mj_objectWithKeyValues:userInfo];
        if(pushModel){
            [ZPublicTool pushNotifyHandle:pushModel];
            
        }
    }else{
        //应用处于后台时的本地推送接受
    }
}
@end
