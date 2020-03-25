//
//  ZStudentMineOrderDetailCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"

@interface ZStudentMineOrderDetailCell : ZBaseCell
@property (nonatomic,strong) ZOrderDetailModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger, ZOrderDetailModel *);

@end

