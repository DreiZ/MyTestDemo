//
//  ZOriganizationTeacherViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/12.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTeacherViewModel.h"
#import "ZOriganizationLessonModel.h"
@implementation ZOriganizationTeacherViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.addModel  = [[ZOriganizationTeacherAddModel alloc] init];
    }
    return self;
}


+ (void)getTeacherList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_teacher_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationTeacherListNetModel *model = [ZOriganizationTeacherListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getLessonTeacherList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_teacher_by_courses params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationTeacherListNetModel *model = [ZOriganizationTeacherListNetModel mj_objectWithKeyValues:dataModel.data];
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



+ (void)getTeacherDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_teacher_info params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOriganizationTeacherAddModel *model = [ZOriganizationTeacherAddModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
//                if (model.images_list && [model.images_list isKindOfClass:[NSArray class]]) {
//                    for (NSInteger i = 0; i < model.images_list.count; i++) {
//                        [model.images_list_net addObject:model.images_list[i]];
//                    }
//                    for (NSInteger i = model.images_list.count; i < 9; i++) {
//                        [model.images_list addObject:@""];
//                        [model.images_list_net addObject:@""];
//                    }
//                }else {
//                    model.images_list = @[].mutableCopy;
//                    model.images_list_net = @[].mutableCopy;
//                    for (NSInteger i = model.images_list.count; i < 9; i++) {
//                        [model.images_list addObject:@""];
//                        [model.images_list_net addObject:@""];
//                    }
//                }
                if (ValidArray(model.card_image)) {
                    NSArray *tempArr = model.card_image;
                    if (tempArr.count == 2) {
                        model.cardImageUp = tempArr[0];
                        model.cardImageDown = tempArr[1];
                    }
                }
                if (ValidArray(model.class_ids)) {
                    for (id temp in model.class_ids) {
                        if (ValidDict(temp)) {
                            NSDictionary *tdict = temp;
                            if ([tdict objectForKey:@"courses_id"]) {
                                ZOriganizationLessonListModel *smodel = [[ZOriganizationLessonListModel alloc] init];
                                smodel.lessonID = tdict[@"courses_id"];
                                if ([tdict objectForKey:@"courses_price"]) {
                                    smodel.teacherPirce = tdict[@"courses_price"];
                                }
                                if ([tdict objectForKey:@"price"]) {
                                    smodel.price = tdict[@"price"];
                                    if (!ValidStr(smodel.teacherPirce)) {
                                        smodel.teacherPirce = smodel.price;
                                    }
                                }
                                if ([tdict objectForKey:@"courses_name"]) {
                                    smodel.name = tdict[@"courses_name"];
                                    smodel.short_name = smodel.name;
                                }
                                
                                [model.lessonList addObject:smodel];
                            }
                        }
                    }
                }
                
                completeBlock(YES, model);
                return ;
            }else {
                completeBlock(NO, dataModel.message);
                return ;
            }
        }else {
            completeBlock(NO, dataModel.message);
            return ;
        }
    }];
}


+ (void)getStoresTeacherDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_stores_teacher_info params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOriganizationTeacherAddModel *model = [ZOriganizationTeacherAddModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                if (ValidArray(model.card_image)) {
                    NSArray *tempArr = model.card_image;
                    if (tempArr.count == 2) {
                        model.cardImageUp = tempArr[0];
                        model.cardImageDown = tempArr[1];
                    }
                }
                
                if (ValidArray(model.class_ids)) {
                    for (id temp in model.class_ids) {
                        if ([temp isKindOfClass:[ZOriganizationLessonListModel class]]) {
                            ZOriganizationLessonListModel *lessonModel = temp;
                            lessonModel.name = lessonModel.courses_name;
                            lessonModel.short_name = lessonModel.courses_name;
                            lessonModel.lessonID = lessonModel.courses_id;
                            if (ValidStr(lessonModel.teacherPirce)) {
                                lessonModel.teacherPirce = lessonModel.price;
                            }
                            [model.lessonList addObject:lessonModel];
                        }
                    }
                }
                
                completeBlock(YES, model);
                return ;
            }else {
                completeBlock(NO, dataModel.message);
                return ;
            }
        }else {
            completeBlock(NO, dataModel.message);
            return ;
        }
    }];
}


+ (void)getStTeacherDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_teacher_info params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOriganizationTeacherAddModel *model = [ZOriganizationTeacherAddModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                if (ValidArray(model.card_image)) {
                    NSArray *tempArr = model.card_image;
                    if (tempArr.count == 2) {
                        model.cardImageUp = tempArr[0];
                        model.cardImageDown = tempArr[1];
                    }
                }
                if (ValidArray(model.class_ids)) {
                    for (id temp in model.class_ids) {
                        if (ValidDict(temp)) {
                            NSDictionary *tdict = temp;
                            if ([tdict objectForKey:@"courses_id"]) {
                                ZOriganizationLessonListModel *smodel = [[ZOriganizationLessonListModel alloc] init];
                                smodel.lessonID = tdict[@"courses_id"];
                                if ([tdict objectForKey:@"courses_price"]) {
                                    smodel.teacherPirce = tdict[@"courses_price"];
                                }
                                if ([tdict objectForKey:@"price"]) {
                                    smodel.price = tdict[@"price"];
                                    if (!ValidStr(smodel.teacherPirce)) {
                                        smodel.teacherPirce = smodel.price;
                                    }
                                }
                                if ([tdict objectForKey:@"courses_name"]) {
                                    smodel.name = tdict[@"courses_name"];
                                    smodel.short_name = smodel.name;
                                }
                                
                                [model.lessonList addObject:smodel];
                            }
                        }
                    }
                }
                
                completeBlock(YES, model);
                return ;
            }else {
                completeBlock(NO, dataModel.message);
                return ;
            }
        }else {
            completeBlock(NO, dataModel.message);
            return ;
        }
    }];
}


+ (void)addTeacher:(NSDictionary *)params isEdit:(BOOL)isEdit completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:isEdit ? URL_account_edit_teacher : URL_account_add_teacher params:params completionHandler:^(id data, NSError *error) {
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


+ (void)editTeacher:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_account_edit_teacher params:params completionHandler:^(id data, NSError *error) {
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

//删除课程
+ (void)deleteTeacher:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_del_teacher params:params completionHandler:^(id data, NSError *error) {
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
