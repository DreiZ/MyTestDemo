//
//  ZOrganizationSearchTeachingScheduleVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSearchClickVC.h"

#import "ZOriganizationLessonModel.h"
#import "ZOriganizationModel.h"


@interface ZOrganizationSearchTeachingScheduleVC : ZSearchClickVC
@property (nonatomic,strong) NSString *stores_courses_id;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) ZOriganizationLessonScheduleListModel *lessonModel;

@end

