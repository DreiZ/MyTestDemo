//
//  ZCircleRecommendCollectionCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCollectionViewCell.h"
#import "ZCircleMineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZCircleRecommendCollectionCell : ZBaseCollectionViewCell
@property (nonatomic,strong) ZCircleMineDynamicModel *model;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
