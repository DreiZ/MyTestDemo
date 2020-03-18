//
//  ZNetworkingManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZNetworkingManager.h"
#import "ZBaseNetworkBackModel.h"
#import "ZUserHelper.h"
#import "ZLaunchManager.h"
#import "ZAppConfig.h"

@implementation ZNetworkingManager
#pragma mark --get请求
+ (id)getWithServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    NSDictionary *newParams = [ZNetworkingManager getPostParamsWithUrl:path params:params];
    NSString *newUrl = [ZNetworkingManager getMUrl:path serverType:serverType];

    return [ZNetworking getWithUrl:newUrl params:newParams completionHandler:completionHandler];
}


+ (id)singleGetWithFullUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    return [ZNetworking getWithUrl:path params:params completionHandler:completionHandler];
}

#pragma mark --post请求
//请求数据 传入位完整url  无签名
+ (id)singlePostWithFullUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    return [ZNetworkingManager postWithUrl:path params:params completionHandler:completionHandler];
}

//完整数据带userid 签名
+ (id)postServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    NSDictionary *newParams = [ZNetworkingManager getPostParamsWithUrl:path params:params];
    NSString *newUrl = [ZNetworkingManager getMUrl:path serverType:serverType];
    
    return [ZNetworkingManager postWithUrl:newUrl params:newParams completionHandler:completionHandler];
}


//获取数据 不设置userid
+ (id)postWithoutUserIDWithServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    
    NSDictionary *newParams = [ZNetworkingManager getPostParamsWithoutUserIDWithUrl:path params:params];
    NSString *newUrl = [ZNetworkingManager getMUrl:path serverType:serverType];
    
    return [ZNetworkingManager postWithUrl:newUrl params:newParams completionHandler:completionHandler];
}


#pragma mark post请求
+ (id)postWithUrl:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    return [ZNetworking postWithUrl:path params:params completionHandler:^(id responseObject, NSError *error) {
        DLog(@"return data *** %@", responseObject);
        if (ValidDict(responseObject)) {
            ZBaseNetworkBackModel *backModel = [ZBaseNetworkBackModel mj_objectWithKeyValues:responseObject];
            
            if (backModel && backModel.code) {
                if ([backModel.code integerValue] == 0) {
                    completionHandler(backModel, nil);
                    
                }else if ([backModel.code integerValue] == 401 || [backModel.code integerValue] == 2001 || [backModel.code integerValue] == 2002 || [backModel.code integerValue] == 2005 || [backModel.code integerValue] == 100005){
                    
                    [[ZUserHelper sharedHelper] loginOutUser:[ZUserHelper sharedHelper].user];
                    [[ZLaunchManager sharedInstance] launchInWindow:nil];
                    NSError *error = [[NSError alloc] initWithDomain:backModel.code code:[backModel.code integerValue] userInfo:@{@"msg":backModel.message}];
                    completionHandler(backModel, error);
                    [TLUIUtility showErrorHint:backModel.message];
                    
                }else{
                    
                    NSError *error = [[NSError alloc] initWithDomain:backModel.code code:[backModel.code integerValue] userInfo:@{@"msg":@"获取服务器数据错误"}];
    
                    if (!backModel.message) {
                        backModel.message = @"获取服务器数据错误";
                    }
                    
                    completionHandler(backModel, error);
                    
                }
            }else{
                backModel = [[ZBaseNetworkBackModel alloc] init];
                backModel.code = @"888888";
                backModel.message = @"获取服务器数据错误";
                completionHandler(backModel, error);
            }
            
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"fail" code:404 userInfo:@{@"msg":@"连接服务器失败"}];
            ZBaseNetworkBackModel *backModel = [[ZBaseNetworkBackModel alloc] init];
            backModel.code = @"888888";
            backModel.message = @"连接服务器失败";
            completionHandler(backModel, error);
        }
    }];
}


#pragma mark - 上传图片
+ (id)postImageServerType:(ZServerType)serverType url:(NSString *)path params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler{
    NSDictionary *newParams = [ZNetworkingManager getPostParamsWithUrl:path params:params];
    NSString *newUrl = [ZNetworkingManager getMUrl:path serverType:serverType];
    
    return [[ZNetworking defaultAFManager] POST:newUrl parameters:newParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (id key in params[@"imageKey"]) {
            UIImage *image = [params[@"imageKey"] objectForKey:key];
            if (image == nil) {
                return ;
            }
//            NSData* tempData = UIImagePNGRepresentation(image);
            NSData* tempData = UIImageJPEGRepresentation(image, 0.3);
            if (tempData == nil) {
                return;
            }
            [formData appendPartWithFileData:tempData name:[NSString stringWithFormat:@"%@",key] fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        completionHandler(responseObject, nil);
        DLog(@"return data *** %@", responseObject);
            if (ValidDict(responseObject)) {
                ZBaseNetworkBackModel *backModel = [ZBaseNetworkBackModel mj_objectWithKeyValues:responseObject];
                
                if (backModel && backModel.code) {
                    if ([backModel.code integerValue] == 0) {
                        completionHandler(backModel, nil);
                        
                    }else if ([backModel.code integerValue] == 401 || [backModel.code integerValue] == 2001 || [backModel.code integerValue] == 2002 || [backModel.code integerValue] == 2005 || [backModel.code integerValue] == 100005){
                        
                        [[ZUserHelper sharedHelper] loginOutUser:[ZUserHelper sharedHelper].user];
                        [[ZLaunchManager sharedInstance] launchInWindow:nil];
                        NSError *error = [[NSError alloc] initWithDomain:backModel.code code:[backModel.code integerValue] userInfo:@{@"msg":backModel.message}];
                        completionHandler(backModel, error);
                        [TLUIUtility showErrorHint:backModel.message];
                        
                    }else{
                        
                        NSError *error = [[NSError alloc] initWithDomain:backModel.code code:[backModel.code integerValue] userInfo:@{@"msg":@"获取服务器数据错误"}];
        
                        if (!backModel.message) {
                            backModel.message = @"获取服务器数据错误";
                        }
                        
                        completionHandler(backModel, error);
                        
                    }
                }else{
                    backModel = [[ZBaseNetworkBackModel alloc] init];
                    backModel.code = @"888888";
                    backModel.message = @"获取服务器数据错误";
                    completionHandler(backModel, nil);
                }
                
            }else{
                NSError *error = [[NSError alloc] initWithDomain:@"fail" code:404 userInfo:@{@"msg":@"连接服务器失败"}];
                ZBaseNetworkBackModel *backModel = [[ZBaseNetworkBackModel alloc] init];
                backModel.code = @"888888";
                backModel.message = @"连接服务器失败";
                completionHandler(backModel, error);
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}

#pragma mark - 参数签名获取请求体
+ (NSDictionary *)getPostParamsWithoutUserIDWithUrl:(NSString *)path params:(NSDictionary *)params {
    
    NSMutableDictionary *newParams = [ZNetworkingManager setWithoutIDCommonDict:params];
    newParams = [ZNetworkingManager setIdentifierWithCommonDict:newParams serverURL:path];
    newParams = [ZNetworkingManager signTheParameters:path postDic:newParams];

    return newParams;
}


+ (NSDictionary *)getPostParamsWithUrl:(NSString *)path params:(NSDictionary *)params {
    NSMutableDictionary *newParams = [ZNetworkingManager setCommonDict:params];
    newParams = [ZNetworkingManager setIdentifierWithCommonDict:newParams serverURL:path];
    newParams = [ZNetworkingManager signTheParameters:path postDic:newParams];
    
    return newParams;
}

+ (NSString *)getPostUrlServerType:(ZServerType)serverType url:(NSString *)path {
    NSString *newUrl = [ZNetworkingManager getMUrl:path serverType:serverType];
    
    return newUrl;
}

//方法：把path和参数拼接起来，把字符串中的中文转换为 百分号 形势，因为有的服务器不接收中文编码
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


//设置公共参数 common parameter
+(NSMutableDictionary *)setCommonDict:(NSDictionary *)originalDict {
    
    NSMutableDictionary *newDict = [ZNetworkingManager setWithoutIDCommonDict:originalDict];

//    if ([ZUserHelper sharedHelper].user && [ZUserHelper sharedHelper].user.userID) {
//        [newDict setObject:[ZUserHelper sharedHelper].user.userID forKey:@"user_id"];
//    }
//    if ([ZUserHelper sharedHelper].user && [ZUserHelper sharedHelper].user.token) {
//        [newDict setObject:[ZUserHelper sharedHelper].user.token forKey:@"token"];
//    }
    return newDict;
}

// 设置公共参数 不带userid 和 token
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


//设置identifier
+(NSMutableDictionary *)setIdentifierWithCommonDict:(NSDictionary *)originalDict serverURL:(NSString *)url{
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithDictionary:originalDict];
    if ([url isEqualToString:URL_sms_v1_captcha] || [url isEqualToString:URL_sms_v1_send_code]) {
        [newDict setObject:@"graphic" forKey:@"identifier"];
    }else if ([url isEqualToString:URL_account_v1_register]|| [url isEqualToString:URL_account_v1_login]|| [url isEqualToString:URL_account_v1_refresh] || [url isEqualToString:URL_account_v1_updatePwd]) {
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

// -签名
+(NSMutableDictionary*)signTheParameters:(NSString *)urlStr postDic:(NSDictionary *)postDic {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    NSMutableDictionary *parameterDic = [[NSMutableDictionary alloc] init];
    [parameterDic addEntriesFromDictionary:postDic];

    for (NSString *key  in [parameterDic allKeys]) {
        NSString *valueStr = parameterDic[key];
        if ([parameterDic[key] isKindOfClass:[UIImage class]] || [key isEqualToString:@"imageKey"]){
            [parameterDic removeObjectForKey:key];
            continue;
        }else if([parameterDic[key] isKindOfClass:[NSArray class]] || [parameterDic[key] isKindOfClass:[NSDictionary class]]){
            
//            valueStr = [ZNetworkingManager toJSONString:parameterDic[key]];
            valueStr = [ZNetworkingManager getJsonStr:parameterDic[key]];

            [parameterDic setObject:valueStr forKey:key];;
        } else{
            valueStr = parameterDic[key];
        }
        [parameters addObject:[NSString stringWithFormat:@"%@%@",key,parameterDic[key]]];
    }
    
    // 根据key排序值
    NSArray *sortedArray = [parameters sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (NSString *key in sortedArray) {
        NSString *valueStr = key;
//
//        if([parameterDic[newKey] isKindOfClass:[NSArray class]] || [parameterDic[newKey] isKindOfClass:[NSDictionary class]]){
//            valueStr = [ZNetworkingManager toJSONString:parameterDic[newKey]];
//
//            [parameterDic setObject:valueStr forKey:newKey];;
//        }else{
//            valueStr = parameterDic[newKey];
//        }
        // 拼接值 字符串
        if (valueStr) {
            if ([valueStr isKindOfClass:[NSNumber class]]) {
                valueStr = [NSString stringWithFormat:@"%ld",(long)[valueStr integerValue]];
            }
            [resultStr appendString:valueStr];
        }
    }
    
    NSString *appKey = @"";
    if ([postDic objectForKey:@"identifier"]) {
        NSString *identifier = postDic[@"identifier"];
        appKey = [ZNetworkingManager getServiceAppSecretWithIdentifier:identifier];
    }
    
    // 拼接 私钥
    [resultStr insertString:appKey atIndex:0];
    // MD5加密
    NSString *MD5Str = [resultStr md5String];
    // 生成sign值
    [parameterDic setObject:MD5Str forKey:@"signature"];
    return parameterDic;
}

+ (NSString *)getJsonStr:(id)parameter {
    NSString *valueStr = @"";
    
    if([parameter isKindOfClass:[NSArray class]]){
        NSMutableArray *newParameter = [[NSMutableArray alloc] initWithArray:parameter];
        for (int i = 0; i < newParameter.count; i++) {
            [newParameter replaceObjectAtIndex:i withObject:[ZNetworkingManager getJsonStr:newParameter[i]]];
        }
        
        valueStr = [ZNetworkingManager toJSONString:parameter];
    }else if([parameter isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *newParameter = [[NSMutableDictionary alloc] initWithDictionary:parameter];
        for (NSString *key  in [newParameter allKeys]) {
            [newParameter setObject:[ZNetworkingManager getJsonStr:newParameter[key]] forKey:key];
        }
        valueStr = [ZNetworkingManager toJSONString:newParameter];
    }else{
        valueStr = parameter;
    }
    
    return valueStr;
}


+ (NSString *)getServiceAppSecretWithIdentifier:(NSString *)identifier {
    //私钥
    NSString *appKey = @"";
    if([identifier isEqualToString:@"graphic"]){
        appKey = sign_graphic_appKey;
    }else if([identifier isEqualToString:@"login"]){
        appKey = sign_login_appKey;
    }else if([identifier isEqualToString:@"account"]){
        appKey = sign_account_appKey;
    }else if([identifier isEqualToString:@"upload"]){
        appKey = sign_upload_appKey;
    }else{
        appKey = sign_account_appKey;
    }
    return appKey;
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
