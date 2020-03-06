//
//  ZStudentMineOrderListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentMineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMineOrderListCell : ZBaseCell
@property (nonatomic,strong) ZStudentOrderListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger, ZStudentOrderListModel *);

@end

NS_ASSUME_NONNULL_END
