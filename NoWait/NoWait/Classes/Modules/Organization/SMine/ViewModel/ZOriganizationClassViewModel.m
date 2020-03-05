//
//  ZOriganizationClassViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/5.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationClassViewModel.h"

@implementation ZOriganizationClassViewModel

+ (void)getClassList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeApi url:URL_sms_v1_send_code params:params completionHandler:^(id data, NSError *error) {
        DLog(@"server-list %@",data);
        ZBaseNetworkBackModel *backModel = data;
        if (backModel.code == 0 && backModel.data) {
            ZOriganizationClassListNetModel  *backModel = [ZOriganizationClassListNetModel mj_objectWithKeyValues:data];
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
