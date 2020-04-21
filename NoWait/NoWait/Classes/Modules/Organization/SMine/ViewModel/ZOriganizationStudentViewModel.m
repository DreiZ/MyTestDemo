//
//  ZOriganizationStudentViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/12.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationStudentViewModel.h"
#import "ZMineModel.h"

@implementation ZOriganizationStudentViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.addModel  = [[ZOriganizationStudentAddModel alloc] init];
    }
    return self;
}

- (ZOriganizationStudentCodeAddModel *)codeAddModel {
    if (!_codeAddModel) {
        _codeAddModel = [[ZOriganizationStudentCodeAddModel alloc] init];
    }
    return _codeAddModel;
}


+ (void)getStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_student_list params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getStarStudentList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_star_student_list params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getStudentDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_student_info params:params completionHandler:^(id data, NSError *error) {
      DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOriganizationStudentAddModel *model = [ZOriganizationStudentAddModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
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


+ (void)getStoresStudentDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_stores_student_info params:params completionHandler:^(id data, NSError *error) {
      DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOriganizationStudentAddModel *model = [ZOriganizationStudentAddModel mj_objectWithKeyValues:dataModel.data];
            if ([dataModel.code integerValue] == 0 ) {
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



+ (void)getStudentFromList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_source_list params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getStudentLessonFromList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_arrang_student_list params:params completionHandler:^(id data, NSError *error) {
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


+ (void)addStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_account_add_student params:params completionHandler:^(id data, NSError *error) {
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


+ (void)editStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_account_edit_student params:params completionHandler:^(id data, NSError *error) {
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


+ (void)starStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_account_add_star_student params:params completionHandler:^(id data, NSError *error) {
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
+ (void)deleteStudent:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_del_student params:params completionHandler:^(id data, NSError *error) {
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


+ (void)addStudentQrcode:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_add_student_qrcode params:params completionHandler:^(id data, NSError *error) {
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


//发送消息
+ (void)addMessage:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_message_v1_add_message params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getMessageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_message_v1_get_message params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZMineMessageNetModel *model = [ZMineMessageNetModel mj_objectWithKeyValues:dataModel.data];
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

+ (void)getSendsMessageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_message_v1_get_sended_message params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZMineMessageNetModel *model = [ZMineMessageNetModel mj_objectWithKeyValues:dataModel.data];
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
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_account_add_student_by_qrcode params:params completionHandler:^(id data, NSError *error) {
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
