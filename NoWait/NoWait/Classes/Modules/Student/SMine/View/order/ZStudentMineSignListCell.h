//
//  ZStudentMineSignListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

@interface ZStudentMineSignListCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationClassListModel *model;

@property (nonatomic,strong) void (^handleBlock)(ZOriganizationClassListModel *);
@end

