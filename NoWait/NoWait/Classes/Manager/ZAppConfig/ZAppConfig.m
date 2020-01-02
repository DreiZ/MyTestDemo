//
//  ZAppConfig.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/23.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import "ZAppConfig.h"

@implementation ZAppConfig

+ (ZAppConfig *)sharedConfig
{
    static ZAppConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}


#pragma mark - # Getters
- (NSString *)version
{
    NSString *shortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSString *buildID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//    NSString *version = [NSString stringWithFormat:@"%@ (%@)", shortVersion, buildID];
    NSString *version = [NSString stringWithFormat:@"%@", shortVersion];
    return version;
}


@end
