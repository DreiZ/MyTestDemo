//
//  ZStudentLessonSelectOrderTimeView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZStudentDetailModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZStudentLessonSelectOrderTimeView : UIView
@property (nonatomic,strong) NSArray <ZOriganizationLessonExperienceTimeModel *>*list;
@property (nonatomic,strong) void (^timeBlock)(ZOriganizationLessonExperienceTimeModel *);
@property (nonatomic,strong) void (^closeBlock)(void);
@property (nonatomic,strong) void (^bottomBlock)(void);
@property (nonatomic,strong) void (^lastStepBlock)(void);
@end

