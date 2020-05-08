//
//  ZRewardCenterDetailCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZRewardModel.h"

@interface ZRewardCenterDetailCell : ZBaseCell
@property (nonatomic,strong) ZRewardInfoModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

