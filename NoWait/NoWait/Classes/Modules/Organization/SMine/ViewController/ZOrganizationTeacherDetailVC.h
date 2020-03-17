//
//  ZOrganizationTeacherDetailVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationTeacherViewModel.h"

@interface ZOrganizationTeacherDetailVC : ZTableViewViewController
@property (nonatomic,strong) ZOriganizationTeacherAddModel *addModel;
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@end

