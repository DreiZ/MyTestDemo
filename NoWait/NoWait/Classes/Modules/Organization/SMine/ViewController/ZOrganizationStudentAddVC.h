//
//  ZOrganizationStudentAddVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZOriganizationTeacherViewModel.h"

@interface ZOrganizationStudentAddVC : ZTableViewViewController
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,strong) ZOriganizationStudentViewModel *viewModel;
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@end


