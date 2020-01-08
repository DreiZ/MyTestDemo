//
//  ZStudentOrganizationPersonnelListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentDetailModel.h"

@interface ZStudentOrganizationPersonnelListCell : ZBaseCell
@property (nonatomic,strong) void (^menuBlock)(ZStudentDetailPersonnelModel *);

@property (nonatomic,strong) NSArray <ZStudentDetailPersonnelModel *>*peopleslList;
@end

