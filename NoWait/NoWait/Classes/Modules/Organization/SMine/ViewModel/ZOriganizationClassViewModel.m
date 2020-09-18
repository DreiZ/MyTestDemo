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


+ (void)getMyClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_get_my_courses_class_list params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getMyClassSignList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_class_num_sign_info params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationSignListNetModel *model = [ZOriganizationSignListNetModel mj_objectWithKeyValues:dataModel.data];
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

+ (void)getMyClassSignInfoList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_sign_info params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationStudentSignDetailListNetModel *model = [ZOriganizationStudentSignDetailListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getTeacherClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_get_teacher_courses_class_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationClassListNetModel *model = [ZOriganizationClassListNetModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, model);
                return ;
            }else{
                completeBlock(NO, nil);
                return;
            }
        }
        completeBlock(NO, nil);
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
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_del_courses_class params:params completionHandler:^(id data, NSError *error) {
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
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_add_class_sign params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (data) {
            if ([dataModel.code integerValue] == 0 ) {
                ZTeacherSignNetModel *model = [ZTeacherSignNetModel mj_objectWithKeyValues:dataModel.data];
                if (!model || [model.code intValue] != 1) {
                    model = [[ZTeacherSignNetModel alloc] init];
                    model.notice_msg = dataModel.message;
                }
                
                if ([model.code intValue] == 1) {
                    completeBlock(YES, model);
                }else{
                    completeBlock(YES, model);
                }
                
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
                if (ValidStr(model.classes_date)) {
                    id tempDict1 = [model.classes_date zz_JSONValue];
                    if (ValidDict(tempDict1)) {
                        NSArray *allKey = [ZOriganizationClassViewModel sortArrayFunction:[tempDict1 allKeys]];
                        for (int i = 0; i < allKey.count; i++) {
                            
                            if ([allKey[i] intValue] <=7 && [allKey[i] intValue] > 0) {
                                ZBaseMenuModel *menuModel = [[ZBaseMenuModel alloc] init];
                                menuModel.name =  SafeStr([allKey[i] zz_indexToWeek]);
                                menuModel.uid = allKey[i];
                                menuModel.isSelected = YES;
                                NSMutableArray *unit = @[].mutableCopy;
                                if (ValidArray(tempDict1[allKey[i]])) {
                                    NSArray*timeArr = tempDict1[allKey[i]];
                                    if (ValidArray(timeArr)) {
                                        NSArray *dataArr = timeArr;
//                                        for (int k = 0; k < dataArr.count; k++) {
//                                            if (ValidStr(dataArr[k])) {
//                                                NSString *str = dataArr[k];
//                                                ZBaseUnitModel *umodel = [[ZBaseUnitModel alloc] init];说点
//                                                umodel.data = SafeStr(str);
//                                                [unit addObject:umodel];
//                                            }
//                                        }
                                        for (int k = 0; k < dataArr.count; k++) {
                                            if (ValidStr(dataArr[k])) {
                                                NSString *str = dataArr[k];
                                                NSArray *array = [str componentsSeparatedByString:@"~"];
                                                if (ValidArray(array) && array.count == 2) {
                                                    NSString *hour = array[0];
                                                    NSArray *hourArray = [hour componentsSeparatedByString:@":"];
                                                    if (ValidArray(hourArray) && hourArray.count == 2) {
                                                        ZBaseUnitModel *umodel = [[ZBaseUnitModel alloc] init];
                                                        umodel.data = str;
                                                        umodel.name = [NSString stringWithFormat:@"%d",[hourArray[0] intValue]];
                                                        umodel.subName = [NSString stringWithFormat:@"%d",[hourArray[1] intValue]];
                                                        [unit addObject:umodel];
                                                    }
                                                }
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

+ (NSMutableArray *)sortArrayFunction:(NSArray *)allKey {
    int count  = 0;
    int forcount  = 0;
    NSMutableArray * arr = allKey.mutableCopy;
    
    for (int i = 0; i < arr.count; i++) {
        forcount++;
        // 依次定位左边的
        for (int j = (int)arr.count-2; j >= i; j--) {
            count++;
            if ([arr[j] intValue]> [arr[j+1] intValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    return arr;
}

+ (void)editClass:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_edit_courses_class params:params completionHandler:^(id data, NSError *error) {
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
               ZOriganizationStudentListNetModel *model = [ZOriganizationStudentListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getQrcodeStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_qrcode_student_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationStudentListNetModel *model = [ZOriganizationStudentListNetModel mj_objectWithKeyValues:dataModel.data];
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

+ (void)setQrcodeStudentProgress:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_set_qrcode_progress params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0) {;
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, dataModel.message);
                return ;
            }else{
                completeBlock(NO, dataModel.message);
                return;
            }
        }
        completeBlock(NO, @"操作失败");
    }];
}


+ (void)addClassStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_add_courses_class_students params:params completionHandler:^(id data, NSError *error) {
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
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_del_courses_class_students params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getSignQrcode:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_sign_qrcode params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationStudentCodeAddModel *model = [ZOriganizationStudentCodeAddModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, model);
                return ;
            }else{
                completeBlock(NO, dataModel.message);
                return;
            }
        }
        completeBlock(NO, @"操作失败");
    }];
}


+ (void)getClassQrcode:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_new_class_qrcode params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZBaseNetworkImageBackModel *model = [ZBaseNetworkImageBackModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, model.img);
                return ;
            }else{
                completeBlock(NO, dataModel.message);
                return;
            }
        }
        completeBlock(NO, @"操作失败");
    }];
}


+ (void)upLessonImageStr:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_upload_sign_image params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0) {;
            if ([dataModel.code integerValue] == 0 ) {
                completeBlock(YES, dataModel.message);
                return ;
            }else{
                completeBlock(NO, dataModel.message);
                return;
            }
        }
        completeBlock(NO, @"操作失败");
    }];
}


+ (void)getMyClassSignReportList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_sign_report params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return report %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationReportListNetModel *model = [ZOriganizationReportListNetModel mj_objectWithKeyValues:dataModel.data];
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

@end
