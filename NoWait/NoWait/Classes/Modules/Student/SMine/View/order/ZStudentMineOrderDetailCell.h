//
//  ZStudentMineOrderDetailCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentMineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMineOrderDetailCell : ZBaseCell
@property (nonatomic,strong) ZStudentOrderListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger, ZStudentOrderListModel *);

@end

NS_ASSUME_NONNULL_END
