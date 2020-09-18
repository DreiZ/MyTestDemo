//
//  ZTeacherMineSignListDetailTitleCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZTeacherMineSignListDetailTitleCell : ZBaseCell
@property (nonatomic,strong) ZBaseSingleCellModel *model;
@property (nonatomic,strong) void (^handleBlock)(ZOriganizationSignListModel *);
@property (nonatomic,strong) void (^handleAllBlock)(ZOriganizationSignListModel *);
@end

NS_ASSUME_NONNULL_END
