//
//  ZCircleMineDynamicCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMineDynamicCell : ZBaseCell
@property (nonatomic,strong) NSMutableArray *list;

@property (nonatomic,strong) void (^menuBlock)(id);
@end

NS_ASSUME_NONNULL_END
