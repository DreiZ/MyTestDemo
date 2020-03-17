//
//  ZOriganizationTeachListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

@interface ZOriganizationTeachListCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationTeacherListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

