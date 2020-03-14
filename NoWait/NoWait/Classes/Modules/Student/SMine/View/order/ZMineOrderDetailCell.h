//
//  ZMineOrderDetailCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentMineModel.h"


@interface ZMineOrderDetailCell : ZBaseCell
@property (nonatomic,strong) ZStudentOrderListModel *model;
@property (nonatomic,strong) void (^handleBlock)(NSInteger, ZStudentOrderListModel *);
@end

