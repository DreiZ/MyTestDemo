//
//  ZStudentMainOrganizationSearchListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentOrganizationListCell.h"

@interface ZStudentMainOrganizationSearchListCell : ZStudentOrganizationListCell
@property (nonatomic,strong) void (^lessonBlock)(ZStoresCourse *);
@end

