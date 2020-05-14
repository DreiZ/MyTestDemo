//
//  ZStudentCollectionViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentCollectionViewModel.h"

@implementation ZStudentCollectionViewModel


+ (void)getCollectionOrganizationList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_message_v1_collectionStoreList params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZStoresListNetModel *model = [ZStoresListNetModel mj_objectWithKeyValues:dataModel.data];
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



+ (void)getCollectionLessonList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_message_v1_collectionCourseList params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationLessonListNetModel *model = [ZOriganizationLessonListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)collectionLesson:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_message_v1_collectionCourse params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           if (data) {
               ZBaseNetworkBackModel *dataModel = data;
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


+ (void)collectionStore:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_message_v1_collectionStore params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           if (data) {
               ZBaseNetworkBackModel *dataModel = data;
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
@end
