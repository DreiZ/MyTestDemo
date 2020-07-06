//
//  ZHotListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHotListCell : ZBaseCell
@property (nonatomic,strong) void (^menuBlock)(id);
@property (nonatomic,strong) NSArray *list;

@end

NS_ASSUME_NONNULL_END
