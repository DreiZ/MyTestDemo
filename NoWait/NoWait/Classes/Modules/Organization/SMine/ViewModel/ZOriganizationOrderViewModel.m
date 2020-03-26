//
//  ZOriganizationOrderViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationOrderViewModel.h"
#import "ZOrderModel.h"

@implementation ZOriganizationOrderViewModel

+ (void)addOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_create_order params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (data) {
            if ([dataModel.code integerValue] == 0 ) {
                ZOrderAddNetModel *netModel = [ZOrderAddNetModel mj_objectWithKeyValues:dataModel.data];
                netModel.message = dataModel.message;
                completeBlock(YES, netModel);
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


+ (void)getOrderDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_get_order_info params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOrderDetailModel *model = [ZOrderDetailModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getOrderList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_order_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOrderListNetModel *model = [ZOrderListNetModel mj_objectWithKeyValues:dataModel.data];
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



+ (void)cancleOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_close_order params:params completionHandler:^(id data, NSError *error) {
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


+ (void)deleteOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_del_order params:params completionHandler:^(id data, NSError *error) {
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


+ (void)handleOrderWithIndex:(NSInteger)index data:(id)data completeBlock:(resultDataBlock)completeBlock {
    NSMutableDictionary *params = @{}.mutableCopy;
    if ([data isKindOfClass:[ZOrderListModel class]]) {
        ZOrderListModel *model = data;
        [params setObject:model.order_id forKey:@"order_id"];
        [params setObject:model.stores_id forKey:@"stores_id"];
    }else if ([data isKindOfClass:[ZOrderDetailModel class]]){
        ZOrderDetailModel *model = data;
        [params setObject:model.order_id forKey:@"order_id"];
        [params setObject:model.stores_id forKey:@"stores_id"];
        
    }
    switch (index) {
        case 0://支付
        {
            
        }
            break;
        case 1://取消
        {
            [ZOriganizationOrderViewModel cancleOrder:params completeBlock:completeBlock];
        }
            break;
        case 2://删除
        {
            [ZOriganizationOrderViewModel cancleOrder:params completeBlock:completeBlock];
        }
            break;
        case 3://评价
        {
            
        }
            break;
        case 4://同意退款
        {
            
        }
            break;
        case 5://接受预约
        {
            
        }
            break;
        case 6://电话
        {
            
        }
            break;
            
            
        default:
            break;
    }
}
@end
