//
//  ZOrganizationLessonManageListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZOriganizationLessonModel.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationLessonManageListVC : ZTableViewViewController
@property (nonatomic,assign) ZOrganizationLessonType type;
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@end

NS_ASSUME_NONNULL_END
