//
//  NSMutableURLRequest+TLNetwork.h
//  TLChat
//
//  Created by ZZZ on 2017/7/14.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLRequestMacros.h"

@class AFHTTPRequestSerializer;
@interface NSMutableURLRequest (TLNetwork)

+ (NSMutableURLRequest *)tt_mutableURLRequestWithSerializer:(AFHTTPRequestSerializer *)serializer
                                                     method:(NSString *)method
                                                  URLString:(NSString *)urlString
                                                 parameters:(id)parameters
                                  constructingBodyWithBlock:(TLConstructingBlock)constructingBodyWithBlock
                                                      error:(NSError *__autoreleasing *)error;

@end
