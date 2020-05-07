//
//  ZIMManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZIMManager.h"
#import <NIMSDK/NIMSDK.h>
#import <NIMKit.h>

#import "NTESAttachmentDecoder.h"
#import "NTESCellLayoutConfig.h"
#import "ZSessionListViewController.h"

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
    NSString *appKey        = @"8fc95f505b6cbaedf613677c8e08fc0b";// kNIMKey;
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
//    option.apnsCername      = @"nowaitpush";
//    option.pkCername        = @"your pushkit cer name";
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    //需要自定义消息时使用
    [NIMCustomObject registerCustomDecoder:[[NTESAttachmentDecoder alloc]init]];
    
    //开启控制台调试
    [[NIMSDK sharedSDK] enableConsoleLog];
    
    //注入 NIMKit 布局管理器
    [[NIMKit sharedKit] registerLayoutConfig:[NTESCellLayoutConfig new]];
}

//设置
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

- (void)loginIMComplete:(void(^)(BOOL))complete {
    //请将 NIMMyAccount 以及 NIMMyToken 替换成您自己提交到此App下的账号和密码
    [[NIMSDK sharedSDK].loginManager login:@"hanmeimei" token:@"123456" completion:^(NSError *error) {
        if (!error) {
            NSLog(@"登录成功");
            if (complete) {
                complete(YES);
            }
            //创建会话列表页
//            ZSessionListViewController *vc = [[ZSessionListViewController alloc] initWithNibName:nil bundle:nil];
//            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSLog(@"登录失败");
            if (complete) {
                complete(YES);
            }
        }
    }];
}

- (void)setCellConfig {
    [NIMKit sharedKit].config.cellBackgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
}
@end
