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


//添加排课
+ (void)addCourseClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;


//班级列表
+ (void)getClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
