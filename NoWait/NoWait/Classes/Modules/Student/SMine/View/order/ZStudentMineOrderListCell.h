//
//  ZStudentMineOrderListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"


@interface ZStudentMineOrderListCell : ZBaseCell
@property (nonatomic,strong) ZOrderListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger, ZOrderListModel *);

@end


