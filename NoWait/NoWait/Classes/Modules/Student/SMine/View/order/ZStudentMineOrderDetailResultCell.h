//
//  ZStudentMineOrderDetailResultCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMineOrderDetailResultCell : ZBaseCell
@property (nonatomic,strong) ZOrderDetailModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger, ZOrderDetailModel *);

@end

NS_ASSUME_NONNULL_END
