//
//  ZOriganizationStatisticsCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationStatisticsCell : ZBaseCell
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@property (nonatomic,strong) ZStoresStatisticalModel *model;

@end

NS_ASSUME_NONNULL_END
