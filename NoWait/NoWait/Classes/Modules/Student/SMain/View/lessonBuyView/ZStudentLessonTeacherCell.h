//
//  ZStudentLessonTeacherCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"

@interface ZStudentLessonTeacherCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZOriganizationLessonTeacherModel *>*teacher_list;
@property (nonatomic,strong) void (^handleBlock)(ZOriganizationLessonTeacherModel *);
@end


