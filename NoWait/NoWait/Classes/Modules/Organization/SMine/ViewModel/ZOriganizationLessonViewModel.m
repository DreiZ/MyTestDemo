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

@end
