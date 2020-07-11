//
//  ZCircleMineViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"

@implementation ZCircleMineViewModel

+ (void)getCircleMineData:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_personal_center_info params:params completionHandler:^(id data, NSError *error) {
           DLog(@"return data %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZCircleMineModel *model = [ZCircleMineModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)updateUserAutograph:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_personal_edit_autograph params:params completionHandler:^(id data, NSError *error) {
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

+ (void)getDynamicsList:(NSDictionary *)params isLike:(BOOL)isLike completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:isLike ? URL_account_v1_enjoy_dynamics_list:URL_account_v1_dynamics_list params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZCircleMineDynamicNetModel *model = [ZCircleMineDynamicNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getFollowList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_follow_list params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZCircleMinePersonNetModel *model = [ZCircleMinePersonNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getFansList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_fans_list params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZCircleMinePersonNetModel *model = [ZCircleMinePersonNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)followUser:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_add_follow params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (data) {
            if ([dataModel.code integerValue] == 0 && ValidDict(dataModel.data)) {
                NSDictionary *tempDict = dataModel.data;
                if ([tempDict objectForKey:@"follow_status"]) {
                    completeBlock(YES, [NSString stringWithFormat:@"%@",tempDict[@"follow_status"]]);
                }else {
                    completeBlock(YES, @"1");
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


+ (void)cancleFollowUser:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_cancel_follow params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (data) {
            if ([dataModel.code integerValue] == 0 && ValidDict(dataModel.data)) {
                NSDictionary *tempDict = dataModel.data;
                if ([tempDict objectForKey:@"follow_status"]) {
                    completeBlock(YES, [NSString stringWithFormat:@"%@",tempDict[@"follow_status"]]);
                }else {
                    completeBlock(YES, @"1");
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


+ (void)getRecommondDynamicsList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_recommond_dynamics_list params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZCircleMineDynamicNetModel *model = [ZCircleMineDynamicNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getRecommondMyAttentionList:(NSDictionary *)params  completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_follow_account_dynamic_list params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZCircleMineDynamicNetModel *model = [ZCircleMineDynamicNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getCircleDynamicInfo:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
   [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_dynamics_info params:params completionHandler:^(id data, NSError *error) {
       DLog(@"return data %@", data);
       ZBaseNetworkBackModel *dataModel = data;
       if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZCircleDynamicInfo *model = [ZCircleDynamicInfo mj_objectWithKeyValues:dataModel.data];
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


@end
