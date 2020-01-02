//
//  ZAppConfig.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/23.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZAppConfig : NSObject

/// App 版本信息
@property (nonatomic, strong, readonly) NSString *version;

+ (ZAppConfig *)sharedConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

