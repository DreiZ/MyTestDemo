//
//  ZOrganizationTeacherLessonSelectVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZOrganizationTeacherLessonSelectVC : ZTableViewViewController
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@property (nonatomic,strong) void (^handleBlock)(NSMutableArray <ZOriganizationLessonListModel *>*, BOOL);
@end

