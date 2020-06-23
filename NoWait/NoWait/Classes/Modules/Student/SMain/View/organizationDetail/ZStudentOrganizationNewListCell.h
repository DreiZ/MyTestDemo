//
//  ZStudentOrganizationNewListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentOrganizationListCell.h"

@interface ZStudentOrganizationNewListCell : ZStudentOrganizationListCell
@property (nonatomic,strong) void (^lessonBlock)(ZStoresCourse *);
@end

