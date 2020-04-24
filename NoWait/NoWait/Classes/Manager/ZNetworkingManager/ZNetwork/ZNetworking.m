//
//  ZNetworking.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "ZNetworking.h"
#import "ZBaseNetworkBackModel.h"
#import "ZUserHelper.h"
#import "ZLaunchManager.h"
#import "ZAppConfig.h"
static AFHTTPSessionManager *manager = nil;

@implementation ZNetworking
+ (AFHTTPSessionManager *)defaultAFManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
        //记录网络状态
        [manager.reachabilityManager startMonitoring];
        manager.requestSerializer.timeoutInterval = 30;
    });
    return manager;
}




#pragma mark get请求
+ (id)getWithUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    
    if ([self defaultAFManager].reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil];
        //        error.errorMsg = @"网络无法连接,请检查您的网络";
        completionHandler(nil,error);
        return nil;
    }
    
    return [[self defaultAFManager] GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}


+ (id)postWithUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    
    if ([ZNetworking defaultAFManager].reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil];
        //        error.errorMsg = @"网络无法连接,请检查您的网络";
        completionHandler(nil,error);
        return nil;
    }
    
    if([ZUserHelper sharedHelper].user && [ZUserHelper sharedHelper].user.token.length > 0 && [ZUserHelper sharedHelper].user.token){
        [manager.requestSerializer setObject:[NSString stringWithFormat:@"Bearer %@",[ZUserHelper sharedHelper].user.token] forHTTPHeaderField:@"Authorization"];
    }else{
        [manager.requestSerializer setObject:[NSString stringWithFormat:@" %@",@""] forHTTPHeaderField:@"Authorization"];
    }
    
    return [[ZNetworking defaultAFManager] POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
            NSDictionary *header = [r allHeaderFields];
            if (header && [header objectForKey:@"Token"]) {
                NSString *token = header[@"Token"];
                if (responseObject && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"data"] && [responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithDictionary:responseObject[@"data"]];
                    [dataDict setObject:token forKey:@"token"];
                    
                    NSMutableDictionary *tempResponseObject = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
                    tempResponseObject[@"data"] = dataDict;
                    completionHandler(tempResponseObject, nil);
                }else{
                    completionHandler(responseObject, nil);
                }
                if (ValidStr(token)) {
                    ZUser *user = [ZUserHelper sharedHelper].user;
                    user.token = token;
                    [[ZUserHelper sharedHelper] setUser:user];
                }
            }else{
                completionHandler(responseObject, nil);
            }
        }else{
            completionHandler(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}
@end
