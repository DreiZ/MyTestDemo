//
//  ZCircleDetailEvaListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZCircleMineModel.h"

@interface ZCircleDetailEvaListCell : ZBaseCell
@property (nonatomic,strong) ZCircleDynamicEvaModel *model;
@property (nonatomic,strong) void (^userBlock)(ZCircleDynamicEvaModel *);
@property (nonatomic,strong) void (^delBlock)(ZCircleDynamicEvaModel *);
@end

