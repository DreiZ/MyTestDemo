//
//  ZOrganizationTrachingScheduleNewClassVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"

@interface ZOrganizationTrachingScheduleNewClassVC : ZTableViewViewController
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@property (nonatomic,strong) NSArray *lessonOrderArr;
@property (nonatomic,assign) BOOL isBu;
@end

