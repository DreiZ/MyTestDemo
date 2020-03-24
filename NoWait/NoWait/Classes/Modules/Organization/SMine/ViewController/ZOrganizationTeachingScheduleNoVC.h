//
//  ZOrganizationTeachingScheduleNoVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZOrganizationTeachingScheduleNoVC : ZTableViewViewController
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,strong) void (^editChangeBlock)(BOOL);
@property (nonatomic,strong) NSString *stores_courses_id;
@property (nonatomic,strong) ZOriganizationLessonScheduleListModel *lessonModel;
@end
