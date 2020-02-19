
//
//  NSDate+ZChat.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZChat)

- (NSString *)chatTimeInfo;

- (NSString *)conversaionTimeInfo;

- (NSString *)chatFileTimeInfo;

- (NSInteger)getAge;

+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;
@end

NS_ASSUME_NONNULL_END
