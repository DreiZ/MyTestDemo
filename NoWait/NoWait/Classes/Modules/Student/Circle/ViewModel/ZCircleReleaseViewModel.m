//
//  ZCircleReleaseViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseViewModel.h"
#import "ZCircleReleaseModel.h"

@implementation ZCircleReleaseViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[ZCircleReleaseModel alloc] init];
    }
    return self;
}

+ (void)releaseDynamics:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_release_dynamics params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getDynamicTagList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_recommend_dynamic_tags params:params completionHandler:^(id data, NSError *error) {
           DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZCircleReleaseTagNetModel *model = [ZCircleReleaseTagNetModel mj_objectWithKeyValues:dataModel.data];
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


//
//+ (void)getLessonDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
//       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_get_courses_info params:params completionHandler:^(id data, NSError *error) {
//             DLog(@"return login code %@", data);
//           ZBaseNetworkBackModel *dataModel = data;
//           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
//               ZOriganizationLessonDetailModel *model = [ZOriganizationLessonDetailModel mj_objectWithKeyValues:dataModel.data];
//            if ([dataModel.code integerValue] == 0 ) {
//                if (model.image_url) {
//                    model.image_net_url = model.image_url;
//                }
//
//                completeBlock(YES, model);
//                return ;
//            }else{
//                completeBlock(NO, dataModel);
//                return;
//            }
//        }
//        completeBlock(NO, @"操作失败");
//    }];
//}
@end
