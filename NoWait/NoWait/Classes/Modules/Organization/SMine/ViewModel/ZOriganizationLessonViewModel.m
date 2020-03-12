//
//  ZOriganizationLessonViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationLessonViewModel.h"
#import "NSString+Message.h"
#import "ZBaseUnitModel.h"

@implementation ZOriganizationLessonViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.addModel  = [[ZOriganizationLessonAddModel alloc] init];
    }
    return self;
}

+ (void)getLessonList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_get_courses_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationLessonListNetModel *model = [ZOriganizationLessonListNetModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, model);
                return ;
            }else{
                completeBlock(NO, dataModel);
                return;
            }
        }
        completeBlock(NO, @"操作失败");
    }];
}


+ (void)getLessonDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_get_courses_info params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationLessonAddModel *model = [ZOriganizationLessonAddModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                if (model.image_url) {
                    model.image_net_url = model.image_url;
                }
                
                if (model.images && [model.images isKindOfClass:[NSArray class]]) {
                    for (NSInteger i = 0; i < model.images.count; i++) {
                        [model.net_images addObject:model.images[i]];
                    }
                    for (NSInteger i = model.images.count; i < 9; i++) {
                        [model.images addObject:@""];
                        [model.net_images addObject:@""];
                    }
                }else {
                    model.images = @[].mutableCopy;
                    model.net_images = @[].mutableCopy;
                    for (NSInteger i = model.images.count; i < 9; i++) {
                        [model.images addObject:@""];
                        [model.net_images addObject:@""];
                    }
                }
                NSArray *weekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
//                ZBaseUnitModel
                if (ValidStr(model.fix_time_net)) {
                    id tempDict1 = [model.fix_time_net JSONValue];
                    if (ValidDict(tempDict1)) {
                        NSArray *allKey = [tempDict1 allKeys];
                        for (int i = 0; i < allKey.count; i++) {
                            
                            if ([allKey[i] intValue] <= weekArr.count && [allKey[i] intValue] > 0) {
                                ZBaseMenuModel *menuModel = [[ZBaseMenuModel alloc] init];
                                menuModel.name = weekArr[[allKey[i] intValue]-1];
                                menuModel.uid = allKey[i];
                                
                                NSMutableArray *unit = @[].mutableCopy;
                                
                                if (ValidArray(tempDict1[allKey[i]])) {
                                    NSArray *dataArr = tempDict1[allKey[i]];
                                    for (int k = 0; k < dataArr.count; k++) {
                                        if (ValidStr(dataArr[k])) {
                                            NSString *str = dataArr[k];
                                            NSArray *array = [str componentsSeparatedByString:@"~"];
                                            if (ValidArray(array) && array.count == 2) {
                                                NSString *hour = array[0];
                                                NSArray *hourArray = [hour componentsSeparatedByString:@":"];
                                                if (ValidArray(hourArray) && hourArray.count == 2) {
                                                    ZBaseUnitModel *umodel = [[ZBaseUnitModel alloc] init];
                                                    umodel.name = [NSString stringWithFormat:@"%d",[hourArray[0] intValue]];
                                                    umodel.subName = [NSString stringWithFormat:@"%d",[hourArray[1] intValue]];
                                                    [unit addObject:umodel];
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                menuModel.units = unit;
                                
                                [model.fix_time addObject:menuModel];
                            }
                        }
                    }
                }
                if (ValidStr(model.experience_time_net)) {
                    id tempDict1 = [model.experience_time_net JSONValue];
                    if (ValidDict(tempDict1)) {
                        NSArray *allKey = [tempDict1 allKeys];
                        for (int i = 0; i < allKey.count; i++) {
                            
                            if ([allKey[i] intValue] <= weekArr.count && [allKey[i] intValue] > 0) {
                                ZBaseMenuModel *menuModel = [[ZBaseMenuModel alloc] init];
                                menuModel.name = weekArr[[allKey[i] intValue]-1];
                                menuModel.uid = allKey[i];
                                
                                NSMutableArray *unit = @[].mutableCopy;
                                
                                if (ValidArray(tempDict1[allKey[i]])) {
                                    NSArray *dataArr = tempDict1[allKey[i]];
                                    for (int k = 0; k < dataArr.count; k++) {
                                        if (ValidStr(dataArr[k])) {
                                            NSString *str = dataArr[k];
                                            NSArray *array = [str componentsSeparatedByString:@"~"];
                                            if (ValidArray(array) && array.count == 2) {
                                                ZBaseUnitModel *umodel = [[ZBaseUnitModel alloc] init];
                                                umodel.name = array[0];
                                                umodel.subName = array[1];
                                                [unit addObject:umodel];
                                            }
                                        }
                                    }
                                }
                                
                                menuModel.units = unit;
                                [model.experience_time addObject:menuModel];
                            }
                        }
                    }
                }
                
                completeBlock(YES, model);
                return ;
            }else{
                completeBlock(NO, dataModel);
                return;
            }
        }
        completeBlock(NO, @"操作失败");
    }];
}

+ (void)closeLesson:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_close_courses params:params completionHandler:^(id data, NSError *error) {
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


+ (void)deleteLesson:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_del_courses params:params completionHandler:^(id data, NSError *error) {
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


+ (void)uploadImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeFile url:URL_file_v1_upload params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (ValidDict(dataModel.data)) {
            ZBaseNetworkImageBackModel *imageModel = [ZBaseNetworkImageBackModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, imageModel.url);
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

+ (void)deleteImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeFile url:URL_file_v1_upload params:params completionHandler:^(id data, NSError *error) {
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


+ (void)addLesson:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_add_courses params:params completionHandler:^(id data, NSError *error) {
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
