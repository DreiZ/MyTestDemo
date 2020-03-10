//
//  ZOriganizationViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationViewModel.h"

@implementation ZOriganizationViewModel

+ (void)getSchoolList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_stores_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
         ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationSchoolListNetModel *model = [ZOriganizationSchoolListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getSchoolDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_stores_info params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
           ZOriganizationSchoolDetailModel *model = [ZOriganizationSchoolDetailModel mj_objectWithKeyValues:dataModel.data];
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
