//
//  ZNetworking.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/15.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCompletionHandler completionHandler:(void(^)(id model, NSError *error))completionHandler

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZServerTypeApi,        //31
    ZServerTypeSocket,     //及时通讯会话 32
    ZServerTypeIM,         //登录 32
} ZServerType;

@interface ZNetworking : NSObject

#pragma mark get请求
+ (id)getServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;
#pragma mark post请求
+ (id)postServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;
#pragma mark post请求不带userid token
+ (id)postWithoutUserIDServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

#pragma mark post直接请求 不签名
+ (id)singlePostServerUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

//上传图片
+ (id)postImageServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;


+ (NSMutableDictionary *)handleData:(NSDictionary *)data;

+ (NSMutableDictionary *)setCommonDict:(NSDictionary *)originalDict;

#pragma mark 获取请求体
+ (NSDictionary *)getPostParamsServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params;

+ (NSString *)getPostUrlServerType:(ZServerType)serverType url:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
