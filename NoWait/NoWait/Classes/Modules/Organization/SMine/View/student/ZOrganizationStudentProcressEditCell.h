//
//  ZOrganizationStudentProcressEditCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

@interface ZOrganizationStudentProcressEditCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationStudentListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSString *);
@end

