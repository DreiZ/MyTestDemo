//
//  ZOriganizationTeachingScheduleViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTeachingScheduleViewModel.h"

@implementation ZOriganizationTeachingScheduleViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _addModel = [[ZOriganizationAddClassModel alloc] init];
    }
    return self;
}

//添加排课
+ (void)addCourseClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeOrganization url:URL_merchants_v1_add_course_class params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (data) {
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, dataModel.message);
                return ;
            }else{
                completeBlock(NO, dataModel.message);
                return;
            }
        }else {
            completeBlock(NO, @"操作失败");
        }
    }];
}


@end
