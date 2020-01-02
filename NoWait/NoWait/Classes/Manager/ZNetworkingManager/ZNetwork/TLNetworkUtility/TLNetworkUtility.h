//
//  TLNetworkUtility.h
//  TLChat
//
//  Created by ZZZ on 2017/7/14.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLBaseRequest.h"

@interface TLNetworkUtility : NSObject

+ (NSString *)requestMethodStringByMethod:(TLRequestMethod)method;

+ (NSString *)sharedCookie;

@end
