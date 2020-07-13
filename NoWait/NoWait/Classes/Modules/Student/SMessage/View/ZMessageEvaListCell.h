//
//  ZMessageEvaListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZCircleMineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZMessageEvaListCell : ZBaseCell
@property (nonatomic,strong) ZCircleMineDynamicEvaModel *model;

@property (nonatomic,strong) void (^handleBlock)(ZCircleMineDynamicEvaModel *,NSInteger);
@end

NS_ASSUME_NONNULL_END
