//
//  ZSignViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSignViewModel.h"
#import "ZSignModel.h"

@implementation ZSignViewModel

+ (void)getSignDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_merchants_get_courses_info params:params completionHandler:^(id data, NSError *error) {
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZSignInfoModel *model = [ZSignInfoModel mj_objectWithKeyValues:dataModel.data];
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
