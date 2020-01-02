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

#endif /* ZMacros_h */
