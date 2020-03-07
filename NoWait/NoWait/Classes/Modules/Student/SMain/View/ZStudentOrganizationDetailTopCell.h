//
//  ZStudentOrganizationDetailTopCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZBaseUnitModel.h"

@interface ZStudentOrganizationDetailTopCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZBaseUnitModel *>*list;
@property (nonatomic,strong) void (^selectBlock)(ZBaseUnitModel *);
@end

