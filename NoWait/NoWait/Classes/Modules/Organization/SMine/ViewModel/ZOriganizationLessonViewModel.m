//
//  ZOriganizationLessonViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationLessonViewModel.h"

@implementation ZOriganizationLessonViewModel

+ (void)getLessonlist:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeApi url:URL_sms_v1_send_code params:params completionHandler:^(id data, NSError *error) {
        DLog(@"server-list %@",data);
        ZBaseNetworkBackModel *backModel = data;
        if (backModel.code == 0 && backModel.data) {
            ZOriganizationLessonListNetModel  *backModel = [ZOriganizationLessonListNetModel mj_objectWithKeyValues:data];
            if ([backModel.code integerValue] == 0 ) {
                completeBlock(YES, backModel);
                return ;
            }else{
                completeBlock(NO, backModel);
                return;
            }
        }
        completeBlock(NO, @"操作失败");
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
