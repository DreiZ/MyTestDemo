//
//  ZRewardCenterViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseViewModel.h"
#import "ZRewardModel.h"

@interface ZRewardCenterViewModel : ZBaseViewModel

+ (void)rewardCenterInfo:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)rewardTeamList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)rankingList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;


+ (void)refectList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)refectDetailList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

