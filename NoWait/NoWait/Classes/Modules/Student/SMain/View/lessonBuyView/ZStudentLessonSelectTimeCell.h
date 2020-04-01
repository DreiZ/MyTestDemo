//
//  ZStudentLessonSelectTimeCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentDetailModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZStudentLessonSelectTimeCell : ZBaseCell
@property (nonatomic,strong) ZStudentDetailLessonTimeModel *model;
@property (nonatomic,strong) ZOriganizationLessonExperienceTimeModel *timeModel;

@end

