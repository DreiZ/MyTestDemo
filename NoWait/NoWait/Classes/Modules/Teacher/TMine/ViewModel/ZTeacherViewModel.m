//
//  ZTeacherViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherViewModel.h"
#import "ZOriganizationModel.h"
@implementation ZTeacherViewModel


+ (void)getStoresInfo:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_get_store_info_by_teacher params:params completionHandler:^(id data, NSError *error) {
      DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOriganizationDetailModel *model = [ZOriganizationDetailModel mj_objectWithKeyValues:dataModel.data];
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


@end
