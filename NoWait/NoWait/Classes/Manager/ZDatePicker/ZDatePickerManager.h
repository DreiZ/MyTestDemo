//
//  ZDatePickerManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGDatePickManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDatePickerManager : NSObject
//+ (ZDatePickerManager *)sharedManager ;
- (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type handle:(void(^)(NSDateComponents *))handleBlock ;
- (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type viewController:(UIViewController *)viewController handle:(void(^)(NSDateComponents *))handleBlock;

+ (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type handle:(void(^)(NSDateComponents *))handleBlock;

+ (void)showDatePickerWithTitle:(NSString *)title type:(PGDatePickerMode)type viewController:(UIViewController *)viewController handle:(void(^)(NSDateComponents *))handleBlock;
@end

NS_ASSUME_NONNULL_END
