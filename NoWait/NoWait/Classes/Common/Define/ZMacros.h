//
//  ZMacros.h
//  ZChat
//
//  Created by ZZZ on 2017/9/20.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#ifndef ZMacros_h
#define ZMacros_h


// 网络请求成功回调
typedef void(^ZBlockRequestSuccessWithDatas)(id datas);

@class NSString;
// 网络请求失败回调
typedef void(^ZBlockRequestFailureWithErrorMessage)(NSString *errMsg);


#pragma mark - # 调试相关宏
#define     DEBUG_LOCAL_SERVER      // 使用本地测试服务器
//#define     DEBUG_MEMERY            // 内存测试

#define mark - # Default
// 默认头像
#define     DEFAULT_AVATAR_PATH         @"defaultHead"


#pragma mark - ——————— 用户相关 ————————
//app登录过
#define kHadAppLogin  @"userHadLogin"
//appy启动过
#define kHadInApp    @"userHadEnterApp"

//healthkit启动过
#define kHadHealthKit    @"kHadHealthKit"

//appstore id
#define kStoreAppId    @"1450127914" //@"1095204149"

//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//高德地图akey
#define KMapKey @"01e6bf5418e297223fda0e325afa0008"

#define KNotificationPayBack @"payBack"

#define kNotificationUpdateToken  @"token"

//微信
#define kAppKey_Wechat @"wx411f6beb954283c6"

//友盟
#define UMengKey @"5e85513e895cca4f46000017"

//网易云信
#define kNIMKey @"ad733c99f8b2486a524048ad73208bd3"
#endif /* ZMacros_h */
