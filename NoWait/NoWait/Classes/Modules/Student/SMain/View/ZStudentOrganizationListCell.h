//
//  ZStudentOrganizationListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

@interface ZStudentOrganizationListCell : ZBaseCell
@property (nonatomic,strong) ZStoresListModel *model;
@property (nonatomic,strong) void (^handleBlock)(ZStoresListModel *);
@property (nonatomic,strong) void (^moreBlock)(ZStoresListModel *);
@end
