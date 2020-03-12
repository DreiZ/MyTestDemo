//
//  ZOriganizationLessonViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZOriganizationLessonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationLessonViewModel : ZBaseViewModel
@property (nonatomic,strong) ZOriganizationLessonAddModel *addModel;
//课程列表
+ (void)getLessonList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
//课程详情
+ (void)getLessonDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
//关闭课程
+ (void)closeLesson:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;
//删除课程
+ (void)deleteLesson:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)uploadImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)deleteImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

//添加课程
+ (void)addLesson:(NSDictionary *)params isEdit:(BOOL)isEdit completeBlock:(resultDataBlock)completeBlock ;
@end

NS_ASSUME_NONNULL_END
