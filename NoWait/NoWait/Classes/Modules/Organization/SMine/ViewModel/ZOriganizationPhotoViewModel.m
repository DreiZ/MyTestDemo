//
//  ZOriganizationPhotoViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationPhotoViewModel.h"

@implementation ZOriganizationPhotoViewModel

+ (void)getStoresImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_coupons_v1_get_stores_image_type_list  params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationPhotoListNetModel *model = [ZOriganizationPhotoListNetModel mj_objectWithKeyValues:dataModel.data];
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



+ (void)getStoresTypeImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_coupons_v1_get_stores_image_list_by_type params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOriganizationPhotoTypeListNetModel *model = [ZOriganizationPhotoTypeListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)addImage:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_coupons_v1_add_stores_image params:params completionHandler:^(id data, NSError *error) {
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

+ (void)delImage:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_coupons_v1_del_stores_image params:params completionHandler:^(id data, NSError *error) {
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
