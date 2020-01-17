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
    
    ZServerTypeCode,              //验证码服务器
    ZServerTypeUser,               //用户服务器
    ZServerTypeOrder,               //订单服务
    ZServerTypeFile,                 //文件服务器
    ZServerTypeCoach,               //教练服务器
    ZServerTypeOrganization,        //机构服务器
} ZServerType;

@interface ZNetworking : NSObject
+ (AFHTTPSessionManager *)defaultAFManager;

+ (id)getWithUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

+ (id)postWithUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

@end

NS_ASSUME_NONNULL_END
