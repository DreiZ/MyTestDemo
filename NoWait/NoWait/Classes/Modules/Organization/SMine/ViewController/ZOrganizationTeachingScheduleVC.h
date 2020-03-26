//
//  ZOrganizationTeachingScheduleVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import <WMPageController.h>
#import "ZOriganizationModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZOrganizationTeachingScheduleVC : WMPageController
@property (nonatomic,strong) NSString *stores_courses_id;
@property (nonatomic,strong) ZOriganizationLessonScheduleListModel *lessonModel;
@end


