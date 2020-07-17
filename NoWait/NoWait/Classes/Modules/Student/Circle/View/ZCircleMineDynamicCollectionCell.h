//
//  ZCircleMineDynamicCollectionCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCollectionViewCell.h"
#import "ZCircleMineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMineDynamicCollectionCell : ZBaseCollectionViewCell
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) ZCircleMineDynamicModel *model;
@property (nonatomic,strong) void (^handleBlock)(ZCircleMineDynamicModel*);
@end

NS_ASSUME_NONNULL_END
