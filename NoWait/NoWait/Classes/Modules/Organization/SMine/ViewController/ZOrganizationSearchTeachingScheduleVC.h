//
//  ZOrganizationSearchTeachingScheduleVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSearchVC.h"

#import "ZOriganizationLessonModel.h"
#import "ZOriganizationModel.h"


@interface ZOrganizationSearchTeachingScheduleVC : ZOrganizationSearchVC
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@property (nonatomic,assign) BOOL isBu;
@end

