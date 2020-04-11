//
//  ZTeacherMineSignListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"



@interface ZTeacherMineSignListCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationClassListModel *model;
@property (nonatomic,strong) void (^handleBlock)(NSInteger, ZOriganizationClassListModel *);
@end
