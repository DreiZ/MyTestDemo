//
//  ZOriganizationTeachingScheduleViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationTeachingScheduleViewModel : ZBaseViewModel
@property (nonatomic,strong) ZOriganizationAddClassModel *addModel;
@property (nonatomic,strong) ZOriganizationAddStudentClassModel *addStudentModel;


//添加排课
+ (void)addCourseClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

//获取二维码
+ (void)addClassQrcode:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


//学员添加排课
+ (void)addStudentCourseClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

//学员删除排课
+ (void)delStudentCourseClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
