//
//  ZCircleMineViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMineViewModel : ZBaseViewModel

+ (void)getCircleMineData:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)updateUserAutograph:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
