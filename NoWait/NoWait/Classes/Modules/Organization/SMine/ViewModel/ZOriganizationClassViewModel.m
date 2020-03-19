//
//  ZOriganizationClassViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/5.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationClassViewModel.h"
#import "NSString+Message.h"
#import "ZBaseUnitModel.h"

@implementation ZOriganizationClassViewModel


+ (void)getClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_get_courses_class_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationClassListNetModel *model = [ZOriganizationClassListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)searchClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_search_courses_class params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationClassListNetModel *model = [ZOriganizationClassListNetModel mj_objectWithKeyValues:dataModel.data];
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
//删除
+ (void)deleteClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeOrganization url:URL_merchants_v1_del_courses_class params:params completionHandler:^(id data, NSError *error) {
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

+ (void)openClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeOrganization url:URL_merchants_v1_courses_class_start params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getClassDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_get_courses_class_info params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOriganizationClassDetailModel *model = [ZOriganizationClassDetailModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, model);
                
                if (ValidDict(model.classes_date)) {
                    id tempDict1 = model.classes_date;
                    if (ValidDict(tempDict1)) {
                        NSArray *allKey = [tempDict1 allKeys];
                        for (int i = 0; i < allKey.count; i++) {
                            
                            if ([allKey[i] intValue] <=7 && [allKey[i] intValue] > 0) {
                                ZBaseMenuModel *menuModel = [[ZBaseMenuModel alloc] init];
                                menuModel.name =  SafeStr([allKey[i] indexToWeek]);
                                menuModel.uid = allKey[i];
                                
                                NSMutableArray *unit = @[].mutableCopy;
                                if (ValidStr(tempDict1[allKey[i]])) {
                                    NSArray*timeArr = [tempDict1[allKey[i]] JSONValue];
                                    if (ValidArray(timeArr)) {
                                        NSArray *dataArr = timeArr;
                                        for (int k = 0; k < dataArr.count; k++) {
                                            if (ValidStr(dataArr[k])) {
                                                NSString *str = dataArr[k];
                                                ZBaseUnitModel *umodel = [[ZBaseUnitModel alloc] init];
                                                umodel.name = SafeStr(str);
                                                [unit addObject:umodel];
                                            }
                                        }
                                    }
                                }
                                
                                
                                menuModel.units = unit;
                                [model.classes_dateArr addObject:menuModel];
                            }
                        }
                    }
                }
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



+ (void)editClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeOrganization url:URL_merchants_v1_edit_courses_class params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getClassStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_get_courses_class_students_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationStudentListModel *model = [ZOriganizationStudentListModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)addClassStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeOrganization url:URL_merchants_v1_add_courses_class_students params:params completionHandler:^(id data, NSError *error) {
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


+ (void)delClassStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postImageServerType:ZServerTypeOrganization url:URL_merchants_v1_del_courses_class_students params:params completionHandler:^(id data, NSError *error) {
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
