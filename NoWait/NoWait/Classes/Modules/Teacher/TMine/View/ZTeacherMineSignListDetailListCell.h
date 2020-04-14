//
//  ZTeacherMineSignListDetailListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZTeacherMineSignListDetailListCell : ZBaseCell
@property (nonatomic,strong) void (^handleBlock)(ZOriganizationSignListModel *);
@property (nonatomic,strong) void (^menuBlock)(ZOriganizationSignListStudentModel *);
@property (nonatomic,strong) ZOriganizationSignListModel *model;
@end

NS_ASSUME_NONNULL_END
