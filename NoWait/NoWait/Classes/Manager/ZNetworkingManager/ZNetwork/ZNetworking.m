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
    newParams = [ZNetworking setIdentifierWithCommonDict:newParams serverURL:path];
    
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
            if ([backModel.code integerValue] == 0) {
                completionHandler(backModel.data, nil);
            }else if ([backModel.code integerValue] == 401 || [backModel.code integerValue] == 2001 || [backModel.code integerValue] == 2002 || [backModel.code integerValue] == 2005){
                [[ZUserHelper sharedHelper] loginOutUser:[ZUserHelper sharedHelper].user];
                [[ZLaunchManager sharedInstance] launchInWindow:nil];
                NSError *error = [[NSError alloc] initWithDomain:backModel.code code:[backModel.code integerValue] userInfo:@{@"msg":backModel.message}];
                completionHandler(nil, error);
                [TLUIUtility showErrorHint:backModel.message];
            }else{
                NSError *error = [[NSError alloc] initWithDomain:backModel.code code:[backModel.code integerValue] userInfo:@{@"msg":@"获取服务器数据错误"}];
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
    NSString *fullUrl = @"";
    switch (serverType) {
        case ZServerTypeCode:
            fullUrl = [NSString stringWithFormat:@"%@/%@%@",URL_code,URL_Service,url];
            break;
        case ZServerTypeUser:
            fullUrl = [NSString stringWithFormat:@"%@/%@%@",URL_user,URL_Service,url];
            break;
        case ZServerTypeOrder:
            fullUrl = [NSString stringWithFormat:@"%@/%@%@",URL_order,URL_Service,url];
            break;
        case ZServerTypeFile:
            fullUrl = [NSString stringWithFormat:@"%@/%@%@",URL_file,URL_Service,url];
            break;
        case ZServerTypeCoach:
            fullUrl = [NSString stringWithFormat:@"%@/%@%@",URL_coach,URL_Service,url];
            break;
        case ZServerTypeOrganization:
            fullUrl = [NSString stringWithFormat:@"%@/%@%@",URL_organization,URL_Service,url];
            break;
            
            
        default:
            fullUrl = [NSString stringWithFormat:@"%@/%@%@",URL_user,URL_Service,url];
            break;
    }
    
    return fullUrl;
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
    
//    [newDict setObject:[ZAppConfig sharedConfig].version forKey:@"version"];
//    [newDict setObject:@"customer" forKey:@"identity"];
//    [newDict setObject:SERVICE_APP_KEY forKey:@"app_key"];
//    [newDict setObject:@"ios" forKey:@"terminal"];
//    [newDict setObject:[ZNetworking randomStringWithLength:16] forKey:@"nonce"];
//    [newDict setObject:[[NSString stringWithFormat:@"%@%@%@",SERVICE_APP_SECRET,newDict[@"nonce"],newDict[@"curtime"]] sha1String] forKey:@"checksum"];
    
    [newDict setObject:[NSString stringWithFormat:@"%ld",(long)[[NSDate new] timeIntervalSince1970]] forKey:@"timestamp"];
    return newDict;
}


#pragma mark -设置identifier
+(NSMutableDictionary *)setIdentifierWithCommonDict:(NSDictionary *)originalDict serverURL:(NSString *)url{
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithDictionary:originalDict];
    if ([url isEqualToString:URL_sms_v1_captcha] || [url isEqualToString:URL_sms_v1_send_code]) {
        [newDict setObject:@"graphic" forKey:@"identifier"];
    }else if ([url isEqualToString:URL_account_v1_register]|| [url isEqualToString:URL_account_v1_login]|| [url isEqualToString:URL_account_v1_refresh]) {
        [newDict setObject:@"login" forKey:@"identifier"];
    }else if ([url isEqualToString:URL_file_v1_upload]) {
        [newDict setObject:@"upload" forKey:@"identifier"];
    }else {
        [newDict setObject:@"account" forKey:@"identifier"];
    }
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
//    [parameterDic setObject:urlStr forKey:@"s"];
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
    
    //私钥
    NSString *appKey = @"";
    if ([postDic objectForKey:@"identifier"]) {
        NSString *identifier = postDic[@"identifier"];
        
        if([identifier isEqualToString:@"graphic"]){
            appKey = sign_graphic_appKey;
        }else if([identifier isEqualToString:@"login"]){
            appKey = sign_login_appKey;
        }else if([identifier isEqualToString:@"account"]){
            appKey = sign_account_appKey;;
        }else if([identifier isEqualToString:@"upload"]){
            appKey = sign_upload_appKey;;
        }
    }
    
    
    // 拼接 私钥
    [resultStr insertString:SERVICE_SIGN atIndex:0];
    // MD5加密
    NSString *MD5Str = [resultStr md5String];
    // 生成sign值
    [parameterDic setObject:MD5Str forKey:@"signature"];
    // 去掉service
//    [parameterDic removeObjectForKey:@"s"];
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
