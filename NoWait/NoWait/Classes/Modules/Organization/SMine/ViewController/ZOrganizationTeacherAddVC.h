//
//  ZOrganizationTeacherAddVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationTeacherViewModel.h"
#import "ZOriganizationModel.h"

@interface ZOrganizationTeacherAddVC : ZTableViewViewController
@property (nonatomic,strong) ZOriganizationTeacherViewModel *viewModel;
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@property (nonatomic,assign) BOOL isEdit;
@end


