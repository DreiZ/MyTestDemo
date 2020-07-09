//
//  ZCircleMineDynamicCollectionListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMineDynamicCollectionListCell : ZBaseCollectionViewCell
@property (nonatomic,strong) NSMutableArray *list;

@property (nonatomic,strong) void (^menuBlock)(id);
@end

NS_ASSUME_NONNULL_END
