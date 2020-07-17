//
//  ZStudentMainViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainViewModel.h"
#import "ZOriganizationModel.h"
#import "ZStudentMainModel.h"
#import "ZDBMainStore.h"

@implementation ZStudentMainViewModel

+ (void)getCategoryList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_get_category_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZMainClassifyNetModel *model = [ZMainClassifyNetModel mj_objectWithKeyValues:dataModel.data];
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

+ (void)getIndexList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_index params:params completionHandler:^(id data, NSError *error) {
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


+ (void)searchStoresList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_search_course params:params completionHandler:^(id data, NSError *error) {
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



+ (void)getAdverList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_get_ad_list params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZAdverListNetModel *model = [ZAdverListNetModel mj_objectWithKeyValues:dataModel.data];
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



+ (void)getStoresDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_v1_stores_deteail_info params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZStoresDetailModel *model = [ZStoresDetailModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getComplaintType:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_complaint_type params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZComplaintNetModel *model = [ZComplaintNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)addComplaint:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_account_v1_add_complaint params:params completionHandler:^(id data, NSError *error) {
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


+ (void)addDynamicComplaint:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url: URL_account_v1_complaint_dynamic params:params completionHandler:^(id data, NSError *error) {
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


+ (BOOL)updateMainBanners:(NSArray <ZAdverListModel *>*)banners {
    [[ZDBMainStore shareManager] cleanBannder];
    return [[ZDBMainStore shareManager] updateMainBanners:banners];
}

+ (BOOL)updateMainPlaceholders:(NSArray <ZAdverListModel *>*)banners {
    [[ZDBMainStore shareManager] cleanPlaceholder];
    return [[ZDBMainStore shareManager] updateMainPlaceholders:banners];
}

+ (NSArray <ZAdverListModel *>*)mainBannerData {
    return [[ZDBMainStore shareManager] mainBannerData];
}

+ (NSArray <ZAdverListModel *>*)mainPlaceholderData {
    return [[ZDBMainStore shareManager] mainPlaceholderData];
}


+ (BOOL)updateMainClassifysOne:(NSArray <ZMainClassifyOneModel *>*)banners {
    if (ValidArray(banners)) {
        [[ZDBMainStore shareManager] cleanClassifyOne];
        [[ZDBMainStore shareManager] cleanClassifyTwo];
        return [[ZDBMainStore shareManager] updateMainClassifysOne:banners];
    }
    return NO;
}

+ (NSArray <ZMainClassifyOneModel *>*)mainClassifyOneData {
    return [[ZDBMainStore shareManager] mainClassifyOneData];
}

+ (NSArray <ZMainClassifyOneModel *>*)mainClassifyTwoData {
    return [[ZDBMainStore shareManager] mainClassifyTwoData];
}


+ (BOOL)updateMainEntryClassifys:(NSArray <ZMainClassifyOneModel *>*)banners {
    [[ZDBMainStore shareManager] cleanClassify];
    return [[ZDBMainStore shareManager] updateMainClassifys:banners];
}

+ (NSArray <ZMainClassifyOneModel *>*)mainClassifyEntryData {
    return [[ZDBMainStore shareManager] mainClassifyData];
}

@end
