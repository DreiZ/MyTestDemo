//
//  ZOriganizationStudentListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

@interface ZOriganizationStudentListCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationStudentListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end


