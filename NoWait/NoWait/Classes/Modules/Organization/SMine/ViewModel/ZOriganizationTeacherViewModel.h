//
//  ZOriganizationTeacherViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/12.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZOriganizationModel.h"


@interface ZOriganizationTeacherViewModel : ZBaseViewModel
@property (nonatomic,strong) ZOriganizationTeacherAddModel *addModel;

+ (void)getTeacherList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getLessonTeacherList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

+ (void)getTeacherDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getStTeacherDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

+ (void)addTeacher:(NSDictionary *)params isEdit:(BOOL)isEdit completeBlock:(resultDataBlock)completeBlock;


+ (void)editTeacher:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

//删除课程
+ (void)deleteTeacher:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

