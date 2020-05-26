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
@property (nonatomic,assign) BOOL isEnd;
//@property (nonatomic,assign) NSInteger type; //1:教师 2：机构

@property (nonatomic,strong) ZOriganizationClassDetailModel *model;
@property (nonatomic,strong) ZOriganizationClassListModel *listModel;
@end


