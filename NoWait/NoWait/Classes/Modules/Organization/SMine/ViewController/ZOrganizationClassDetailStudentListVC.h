//
//  ZOrganizationClassDetailStudentListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZOrganizationClassDetailStudentListVC : ZTableViewViewController
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) ZOriganizationClassDetailModel *model;
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;

@end


