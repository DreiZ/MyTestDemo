//
//  ZOrganizationTeacherSearchVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSearchVC.h"
#import "ZOriganizationLessonModel.h"
#import "ZOriganizationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationTeacherSearchVC : ZOrganizationSearchVC
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@end

NS_ASSUME_NONNULL_END
