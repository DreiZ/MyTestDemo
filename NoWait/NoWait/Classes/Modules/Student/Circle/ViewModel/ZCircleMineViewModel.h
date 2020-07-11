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


+ (void)getDynamicsList:(NSDictionary *)params isLike:(BOOL)isLike completeBlock:(resultDataBlock)completeBlock;


+ (void)getFollowList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock;


+ (void)getFansList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock;


+ (void)followUser:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)cancleFollowUser:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getRecommondDynamicsList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock;


+ (void)getRecommondMyAttentionList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock;


+ (void)getCircleDynamicInfo:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getEvaList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock;


+ (void)getDynamicLikeList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock;


+ (void)evaDynamic:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
