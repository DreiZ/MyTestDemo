//
//  ZNetworkingManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNetworking.h"

#define kCompletionHandler completionHandler:(void(^)(id model, NSError *error))completionHandler


@interface ZNetworkingManager : NSObject
+ (id)getWithServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

//请求数据 传入位完整url  无签名

+ (id)singleGetWithFullUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler ;

#pragma mark --post请求
//请求数据 传入位完整url  无签名
+ (id)singlePostWithFullUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

//完整数据带userid 签名
+ (id)postServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler ;


//获取数据 不设置userid
+ (id)postWithoutUserIDWithServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

#pragma mark - 上传图片
+ (id)postImageServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;
@end

