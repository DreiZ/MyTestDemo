//
//  ZStudentMainOrganizationExperienceCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

@interface ZStudentMainOrganizationExperienceCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZOriganizationLessonListModel *>*appointment_courses;
@property (nonatomic,strong) void (^lessonBlock)(ZOriganizationLessonListModel *);
@end

