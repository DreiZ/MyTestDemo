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
#import "ZStudentMainModel.h"

@interface ZStudentLessonSelectTimeCell : ZBaseCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) ZStudentDetailLessonTimeModel *model;
@property (nonatomic,strong) ZOriganizationLessonExperienceTimeModel *timeModel;
@property (nonatomic,strong) ZMainClassifyOneModel *classifyModel;

@end

