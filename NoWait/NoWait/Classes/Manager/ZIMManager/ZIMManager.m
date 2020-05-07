//
//  ZIMManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZIMManager.h"
#import <NIMSDK/NIMSDK.h>


static ZIMManager *shareManager = NULL;

@interface ZIMManager ()<NIMSDKConfigDelegate>

@end

@implementation ZIMManager

+ (ZIMManager *)shareManager
{
    static ZIMManager *helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[ZIMManager alloc] init];
    });
    return helper;
}

- (void)registerIM {
    //推荐在程序启动的时候初始化 NIMSDK
    NSString *appKey        = kNIMKey;
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    option.apnsCername      = @"nowaitpush";
//    option.pkCername        = @"your pushkit cer name";
    [[NIMSDK sharedSDK] registerWithOption:option];
}


- (void)setupNIMSDK
{
    [[NIMSDKConfig sharedConfig] setDelegate:self];
    [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
    [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];
    [[NIMSDKConfig sharedConfig] setMaximumLogDays:7];
    [[NIMSDKConfig sharedConfig] setShouldCountTeamNotification:YES];
    [[NIMSDKConfig sharedConfig] setAnimatedImageThumbnailEnabled:YES];
    
    
    //多端登录时，告知其他端，这个端的登录类型，目前对于android的TV端，手表端使用。
    [[NIMSDKConfig sharedConfig] setCustomTag:[NSString stringWithFormat:@"%ld",(long)NIMLoginClientTypeiOS]];
}
@end
