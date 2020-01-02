//
//  ZNetworking.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/15.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import "ZNetworking.h"
#import "ZBaseNetworkBackModel.h"
#import "ZUserHelper.h"
#import "ZLaunchManager.h"
#import "ZAppConfig.h"

@implementation ZNetworking
+ (AFHTTPSessionManager *)defaultAFManager {
    static AFHTTPSessionManager *manager = nil;
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
+ (id)getServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *newUrl = [self getMUrl:path serverType:serverType];
    
    if ([self defaultAFManager].reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil];
        //        error.errorMsg = @"网络无法连接";
        completionHandler(nil,error);
        return nil;
    }
    
    return [[self defaultAFManager] GET:newUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}


#pragma mark 获取请求体
+ (NSDictionary *)getPostParamsServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params {
    
    NSMutableDictionary *newParams = [ZNetworking setCommonDict:params];
    newParams = [ZNetworking signTheParameters:path postDic:newParams];
    
    return newParams;
}

+ (NSString *)getPostUrlServerType:(ZServerType)serverType url:(NSString *)path {
    NSString *newUrl = [ZNetworking getMUrl:path serverType:serverType];
    
    return newUrl;
}

#pragma mark post请求
+ (id)postServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    NSMutableDictionary *newParams = [ZNetworking setCommonDict:params];
    
    newParams = [ZNetworking signTheParameters:path postDic:newParams];
    
    NSString *newUrl = [ZNetworking getMUrl:path serverType:serverType];
    
    return [ZNetworking postWithUrl:newUrl params:newParams completionHandler:completionHandler];
}

//获取数据 不设置userid
+ (id)postWithoutUserIDServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    
    NSMutableDictionary *newParams = [ZNetworking setWithoutIDCommonDict:params];
    
    newParams = [ZNetworking signTheParameters:path postDic:newParams];
    
    NSString *newUrl = [ZNetworking getMUrl:path serverType:serverType];
    
    return [ZNetworking postWithUrl:newUrl params:newParams completionHandler:completionHandler];
}

+ (id)postWithUrl:(NSString *)newUrl params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    
//    if ([ZNetworking defaultAFManager].reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
//        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil];
//        //        error.errorMsg = @"网络无法连接";
//        completionHandler(nil,error);
//        return nil;
//    }
    
    return [[ZNetworking defaultAFManager] POST:newUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"znetworking data back %@",responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            ZBaseNetworkBackModel *backModel = [ZBaseNetworkBackModel mj_objectWithKeyValues:responseObject];
            if ([backModel.ret integerValue] == 200) {
                completionHandler(backModel.data, nil);
            }else if ([backModel.ret integerValue] == 401){
                [[ZUserHelper sharedHelper] loginOutUser:[ZUserHelper sharedHelper].user];
                [[ZLaunchManager sharedInstance] launchInWindow:nil];
                NSError *error = [[NSError alloc] initWithDomain:backModel.ret code:[backModel.ret integerValue] userInfo:@{@"msg":backModel.msg}];
                completionHandler(nil, error);
                [TLUIUtility showErrorHint:backModel.msg];
            }else{
                NSError *error = [[NSError alloc] initWithDomain:backModel.ret code:[backModel.ret integerValue] userInfo:@{@"msg":@"获取服务器数据错误"}];
                completionHandler(nil, error);
            }
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"fail" code:404 userInfo:@{@"msg":@"连接服务器失败"}];
            completionHandler(nil, error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}


+ (id)singlePostServerUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    AFHTTPSessionManager *manager = nil;
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    //记录网络状态
    [manager.reachabilityManager startMonitoring];
    NSString *newUrl = path;
    if (manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil];
        //        error.errorMsg = @"网络无法连接";
        completionHandler(nil,error);
        return nil;
    }
    return [manager POST:newUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}


//上传图片
+ (id)postImageServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler{
    NSString *newUrl = [self getMUrl:path serverType:serverType];
    
    return [[self defaultAFManager] POST:newUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (id key in params[@"imageKey"]) {
            UIImage *image = [params objectForKey:key];
            if (image == nil) {
                return ;
            }
            NSData* tempData = UIImagePNGRepresentation(image);
            if (tempData == nil) {
                return;
            }
            [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:[NSString stringWithFormat:@"%@",key] fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}

+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params {
    NSMutableString *percentPath = [NSMutableString stringWithString:path];
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            [percentPath appendFormat:@"?%@=%@", keys[i], params[keys[i]]];
        }else {
            [percentPath appendFormat:@"&%@=%@", keys[i], params[keys[i]]];
        }
    }
    return [percentPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString*)getMUrl:(NSString*)url serverType:(ZServerType)serverType {
    if (serverType == ZServerTypeApi) {
        return [NSString stringWithFormat:@"%@/%@%@",URL_main,URL_Service,url];
    }else if (serverType == ZServerTypeIM) {
        return [NSString stringWithFormat:@"%@/%@%@",URL_Socket,URL_Service,url];
    }else {
        return [NSString stringWithFormat:@"%@/%@%@",URL_Socket,URL_Service,url];
    }
    
}


#pragma mark common parameter
+(NSMutableDictionary *)setCommonDict:(NSDictionary *)originalDict {
    
    NSMutableDictionary *newDict = [ZNetworking setWithoutIDCommonDict:originalDict];
//
//    if ([ZUserHelper sharedHelper].user && [ZUserHelper sharedHelper].user.userID) {
//        [newDict setObject:[ZUserHelper sharedHelper].user.userID forKey:@"user_id"];
//    }
//    if ([ZUserHelper sharedHelper].user && [ZUserHelper sharedHelper].user.token) {
//        [newDict setObject:[ZUserHelper sharedHelper].user.token forKey:@"token"];
//    }
    return newDict;
}

#pragma mark common parameter without id token
+(NSMutableDictionary *)setWithoutIDCommonDict:(NSDictionary *)originalDict {
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithDictionary:originalDict];
    
    [newDict setObject:[ZAppConfig sharedConfig].version forKey:@"version"];
    [newDict setObject:@"customer" forKey:@"identity"];
    [newDict setObject:SERVICE_APP_KEY forKey:@"app_key"];
    [newDict setObject:@"ios" forKey:@"terminal"];
    [newDict setObject:[NSString stringWithFormat:@"%ld",(long)[[NSDate new] timeIntervalSince1970]] forKey:@"curtime"];
    [newDict setObject:[ZNetworking randomStringWithLength:16] forKey:@"nonce"];
    [newDict setObject:[[NSString stringWithFormat:@"%@%@%@",SERVICE_APP_SECRET,newDict[@"nonce"],newDict[@"curtime"]] sha1String] forKey:@"checksum"];
    return newDict;
}

//随机字符串
+ (NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%c", [letters characterAtIndex: arc4random_uniform(36)]];
    }
    return randomString;
}

#pragma mark 签名
+(NSMutableDictionary*)signTheParameters:(NSString *)urlStr postDic:(NSDictionary *)postDic {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    NSMutableDictionary *parameterDic = [[NSMutableDictionary alloc] init];
    [parameterDic setObject:urlStr forKey:@"s"];
    [parameterDic addEntriesFromDictionary:postDic];
    for (NSString *key  in [parameterDic allKeys]) {
        [parameters addObject:[NSString stringWithFormat:@"%@=%@",key,parameterDic[key]]];
    }
    
    // 根据key排序值
    NSArray *sortedArray = [parameters sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (NSString *key in sortedArray) {
        NSRange range = [key rangeOfString:@"="];
        NSString *newKey = [key substringToIndex:range.location];
        NSString *valueStr;
        
        if([parameterDic[newKey] isKindOfClass:[NSArray class]] || [parameterDic[newKey] isKindOfClass:[NSDictionary class]]){
            valueStr = [ZNetworking toJSONString:parameterDic[newKey]];
            
            [parameterDic setObject:valueStr forKey:newKey];;
        }else{
            valueStr = parameterDic[newKey];
        }
        // 拼接值 字符串
        if (valueStr) {
            if ([valueStr isKindOfClass:[NSNumber class]]) {
                valueStr = [NSString stringWithFormat:@"%ld",(long)[valueStr integerValue]];
            }
            [resultStr appendString:valueStr];
        }
    }
    // 拼接 私钥
    [resultStr insertString:SERVICE_SIGN atIndex:0];
    // MD5加密
    NSString *MD5Str = [resultStr md5String];
    // 生成sign值
    [parameterDic setObject:MD5Str forKey:@"sign"];
    // 去掉service
    [parameterDic removeObjectForKey:@"s"];
    return parameterDic;
}


+ (NSString *)toJSONString:(id)object{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
    if (jsonData.length > 0 && error == nil ) {
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
}

+ (NSMutableDictionary *)handleData:(NSDictionary *)data {
    NSMutableDictionary *returnData = [[NSMutableDictionary alloc] initWithDictionary:data];
    NSArray *keyValue = [returnData allKeys];
    for (NSString *key in keyValue) {
        if ([returnData[key] isKindOfClass:[NSNull class]]) {
            [returnData setObject:@"" forKey:key];
        }
    }
    return returnData;
}
@end
