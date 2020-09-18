//
//  ZOriganizationClassViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/5.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationClassViewModel : ZBaseViewModel
//班级列表
+ (void)getClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;


+ (void)getTeacherClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getMyClassSignList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getMyClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

//搜素班级
+ (void)searchClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

//删除
+ (void)deleteClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;
//开课
+ (void)openClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

//班级详情
+ (void)getClassDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

//编辑班级
+ (void)editClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

//班级学员列表
+ (void)getClassStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;


+ (void)getQrcodeStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
//班级添加学员
+ (void)addClassStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

//删除班级学员
+ (void)delClassStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;


+ (void)getSignQrcode:(NSDictionary *)params
        completeBlock:(resultDataBlock)completeBlock ;


+ (void)getClassQrcode:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)setQrcodeStudentProgress:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)upLessonImageStr:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getMyClassSignReportList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getMyClassSignInfoList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
