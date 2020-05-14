//
//  ZStudentMainOrganizationListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

@interface ZStudentMainOrganizationListCell : ZBaseCell
@property (nonatomic,strong) ZStoresListModel *model;
@property (nonatomic,strong) void (^handleBlock)(ZStoresListModel *);
@end

