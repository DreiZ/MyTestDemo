//
//  ZCircleMineDynamicCollectionTableViewCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMineDynamicCollectionTableViewCell : ZBaseCell
@property (nonatomic,strong) NSMutableArray *list;

@property (nonatomic,strong) void (^menuBlock)(id);
@end

NS_ASSUME_NONNULL_END
