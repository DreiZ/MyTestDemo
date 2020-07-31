//
//  ZCache.m
//  zzz
//
//  Created by zzz on 2018/6/21.
//  Copyright © 2018年 LaKa. All rights reserved.
//

#import "ZCache.h"

@implementation ZCache

+ (instancetype)shareInstance
{
    static ZCache *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [cacheFolder stringByAppendingPathComponent:@"ZCache"];
        _instance = [[self alloc] initWithPath:path];
    });
    return _instance;
}

@end
