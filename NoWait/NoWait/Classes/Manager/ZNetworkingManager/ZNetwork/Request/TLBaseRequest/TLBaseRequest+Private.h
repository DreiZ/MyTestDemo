//
//  TLBaseRequest+Private.h
//  TLChat
//
//  Created by ZZZ on 2017/7/14.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import "TLBaseRequest.h"

@class AFHTTPRequestSerializer;
@interface TLBaseRequest (Private)

/// 请求方式字符串
@property (nonatomic, strong, readonly) NSString *requestMethodString;

/// TLNetworkConfig中设置的baseURL
@property (nonatomic, strong, readonly) NSString *baseURL;

/// 真正请求时的URL
@property (nonatomic, strong, readonly) NSString *requestURL;
/// 系统原生的URLRequest
@property (nonatomic, strong, readonly) NSURLRequest *customURLRequest;

@property (nonatomic, strong, readonly) AFHTTPRequestSerializer *requestSerializer;

@end
