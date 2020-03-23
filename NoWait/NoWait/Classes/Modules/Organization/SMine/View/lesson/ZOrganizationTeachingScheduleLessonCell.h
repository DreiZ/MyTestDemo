//
//  ZOrganizationTeachingScheduleLessonCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZOrganizationTeachingScheduleLessonCell : ZBaseCell
@property (nonatomic,strong) void (^handleBlock)(NSInteger,ZOriganizationLessonScheduleListModel *);
@property (nonatomic,strong) ZOriganizationLessonScheduleListModel *model;

@end


