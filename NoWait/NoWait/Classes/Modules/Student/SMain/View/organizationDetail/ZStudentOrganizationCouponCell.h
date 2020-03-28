//
//  ZStudentOrganizationCouponCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentOrganizationCouponCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationCardListModel *model;
@property (nonatomic,strong) void (^handleBlock)(ZOriganizationCardListModel *);
@end

NS_ASSUME_NONNULL_END
