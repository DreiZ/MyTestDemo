//
//  ZCircleReleaseViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZCircleReleaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleReleaseViewModel : ZBaseViewModel
@property (nonatomic,strong) ZCircleReleaseModel *model;

+ (void)releaseDynamics:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getDynamicTagList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
