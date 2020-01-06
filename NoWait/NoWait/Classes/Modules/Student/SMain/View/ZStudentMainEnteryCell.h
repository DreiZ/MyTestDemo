//
//  ZStudentMainEnteryCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentMainModel.h"

@interface ZStudentMainEnteryCell : ZBaseCell
@property (nonatomic,strong) void (^menuBlock)(ZStudentEnteryItemModel *);

@property (nonatomic,strong) NSArray <ZStudentEnteryItemModel *>*channelList;
@end

