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
@end
