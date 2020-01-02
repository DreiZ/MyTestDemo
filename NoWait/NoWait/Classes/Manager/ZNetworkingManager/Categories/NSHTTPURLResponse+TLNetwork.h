//
//  NSHTTPURLResponse+TLNetwork.h
//  TLChat
//
//  Created by ZZZ on 2017/7/14.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHTTPURLResponse (TLNetwork)

/// 字符串编码，默认NSUTF8StringEncoding
@property (nonatomic, assign, readonly) NSStringEncoding stringEncoding;

@end
