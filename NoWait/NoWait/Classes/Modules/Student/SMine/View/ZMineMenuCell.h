//
//  ZMineMenuCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentMineModel.h"

@interface ZMineMenuCell : ZBaseCell
@property (nonatomic,strong) void (^menuBlock)(ZStudentMenuItemModel *);

@property (nonatomic,strong) NSArray <ZStudentMenuItemModel *>*topChannelList;
@end

