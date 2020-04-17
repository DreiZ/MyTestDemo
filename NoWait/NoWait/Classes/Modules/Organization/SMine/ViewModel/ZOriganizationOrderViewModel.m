//
//  ZOriganizationOrderViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationOrderViewModel.h"
#import "ZOrderModel.h"
#import "ZPayManager.h"
#import "ZPayAlertTypeView.h"
#import "ZAlertView.h"
@implementation ZOriganizationOrderViewModel

+ (void)payOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_pay_order params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (data) {
            if ([dataModel.code integerValue] == 0 ) {
                ZMineOrderPayBackModel *netModel = [ZMineOrderPayBackModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)refundPayOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_refund_order_pay params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if (data) {
            if ([dataModel.code integerValue] == 0 ) {
                ZMineOrderPayBackModel *netModel = [ZMineOrderPayBackModel mj_objectWithKeyValues:dataModel.data];
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

+ (void)addExpOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_create_appointment_oreder params:params completionHandler:^(id data, NSError *error) {
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

+ (void)getOrderRefundDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_get_refund_order_info params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getRefundOrderList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_refund_order_list params:params completionHandler:^(id data, NSError *error) {
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


+ (void)evaOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_add_comment params:params completionHandler:^(id data, NSError *error) {
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


+ (void)getMerchantsCommentListList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_merchants_comment_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOrderEvaListNetModel *model = [ZOrderEvaListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getAccountCommentListList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_account_comment_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOrderEvaListNetModel *model = [ZOrderEvaListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getLessonCommentListList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_courses_comment_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOrderEvaListNetModel *model = [ZOrderEvaListNetModel mj_objectWithKeyValues:dataModel.data];
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


+ (void)getTeacherCommentListList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
       [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_teacher_comment_list params:params completionHandler:^(id data, NSError *error) {
             DLog(@"return login code %@", data);
           ZBaseNetworkBackModel *dataModel = data;
           if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
               ZOrderEvaListNetModel *model = [ZOrderEvaListNetModel mj_objectWithKeyValues:dataModel.data];
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

+ (void)getEvaDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_get_comment_info params:params completionHandler:^(id data, NSError *error) {
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZOrderEvaDetailModel *model = [ZOrderEvaDetailModel mj_objectWithKeyValues:dataModel.data];
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

+ (void)replyEvaOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_account_v1_reply_commen params:params completionHandler:^(id data, NSError *error) {
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


+ (void)refundOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_refund_order params:params completionHandler:^(id data, NSError *error) {
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

//学员同意t商家退款或再商议
+ (void)refundOrderAgain:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_refund_order_again params:params completionHandler:^(id data, NSError *error) {
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


//商家退款或再商议
+ (void)ogriganizationRefundOrderAgain:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_refund_confirm params:params completionHandler:^(id data, NSError *error) {
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


//商家退款或再商议
+ (void)refundOrderCanle:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_refund_order_cancle params:params completionHandler:^(id data, NSError *error) {
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


+ (void)appointmentOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeOrganization url:URL_order_v1_update_appointment_order params:params completionHandler:^(id data, NSError *error) {
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
    }else if ([data isKindOfClass:[NSDictionary class]]){
        params = data;
    }
    
    switch (index) {
        case ZLessonOrderHandleTypePay://支付
        {
            [ZPayAlertTypeView showWithHandlerBlock:^(NSInteger index) {
                if (index == 0) {
                    [params setObject:@"1" forKey:@"pay_type"];
                    [[ZPayManager sharedManager] getWechatPayInfo:params complete:^(BOOL isSuccess, NSString *message) {
                        
                    }];
                }else{
                    [params setObject:@"2" forKey:@"pay_type"];
                    [[ZPayManager  sharedManager] getAliPayInfo:params complete:^(BOOL isSuccess, NSString *message) {
                        
                    }];
                }
            }];
        }
            break;
        case ZLessonOrderHandleTypeCancel://取消
        {
            [ZAlertView setAlertWithTitle:@"取消订单" subTitle:@"确定取消订单？" leftBtnTitle:@"不取消" rightBtnTitle:@"取消" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [ZOriganizationOrderViewModel cancleOrder:params completeBlock:completeBlock];
                }
            }];
        }
            break;
        case ZLessonOrderHandleTypeDelete://删除
        {
            [ZAlertView setAlertWithTitle:@"删除订单" subTitle:@"确定删除订单？订单删除后不可找回" leftBtnTitle:@"取消" rightBtnTitle:@"删除" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [ZOriganizationOrderViewModel deleteOrder:params completeBlock:completeBlock];
                }
            }];
        }
            break;
        case ZLessonOrderHandleTypeEva://评价
        {
            //外部做
        }
            break;
        case ZLessonOrderHandleTypeOrderReceive://接受预约
        {
            [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定接受预约？" leftBtnTitle:@"不取消" rightBtnTitle:@"接受" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [params setObject:@"1" forKey:@"operation_type"];
                   [ZOriganizationOrderViewModel appointmentOrder:params completeBlock:completeBlock];
                }
            }];
        }
            break;
        case ZLessonOrderHandleTypeOrderNOReceive://拒绝预约
        {
            [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定拒绝预约？" leftBtnTitle:@"取消" rightBtnTitle:@"拒绝" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [params setObject:@"2" forKey:@"operation_type"];
                    [ZOriganizationOrderViewModel appointmentOrder:params completeBlock:completeBlock];
                }
            }];
        }
            break;
        case ZLessonOrderHandleTypeRefund://申请退款
        {
            [ZOriganizationOrderViewModel refundOrder:params completeBlock:completeBlock];
        }
            break;
        case ZLessonOrderHandleTypeSRefund://申请退款
       {
           NSString *refunAmount = @"";
           [params setObject:@"2" forKey:@"refund_type"];
           if ([data isKindOfClass:[ZOrderListModel class]]) {
                ZOrderListModel *model = data;
               refunAmount = model.refund_amount;
               [params setObject:model.refund_amount forKey:@"refund_amount"];
          }else if ([data isKindOfClass:[ZOrderDetailModel class]]){
              ZOrderDetailModel *model = data;
              refunAmount = model.refund_amount;
              [params setObject:model.refund_amount forKey:@"refund_amount"];
          }
           [ZAlertView setAlertWithTitle:@"确定接受此退款金额？" subTitle:[NSString stringWithFormat:@"退款金额金额为%@,确定同意此金额后，商家将支付此退款金额给您",refunAmount] leftBtnTitle:@"取消" rightBtnTitle:@"接受退款" handlerBlock:^(NSInteger index) {
               if (index == 1) {
                   [params setObject:@"2" forKey:@"refund_type"];
                   [ZOriganizationOrderViewModel refundOrderAgain:params completeBlock:completeBlock];
               }
           }];
           
       }
           break;
        case ZLessonOrderHandleTypeSRefundReject://协商退款学员
        {
            [params setObject:@"1" forKey:@"refund_type"];
            NSString *refunAmount = @"";
            if ([data isKindOfClass:[ZOrderListModel class]]) {
               ZOrderListModel *model = data;
               [params setObject:model.refund_amount forKey:@"refund_amount"];
                refunAmount = model.refund_amount;
           }else if ([data isKindOfClass:[ZOrderDetailModel class]]){
               ZOrderDetailModel *model = data;
               refunAmount = model.refund_amount;
               [params setObject:model.refund_amount forKey:@"refund_amount"];
           }
           [ZAlertView setAlertWithTitle:@"确定重新协商此退款金额？" subTitle:[NSString stringWithFormat:@"您提议退款金额为%@,商家接受此金额后会支付相应退款金额给您",refunAmount] leftBtnTitle:@"取消" rightBtnTitle:@"提交协商金额" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [ZOriganizationOrderViewModel refundOrderAgain:params completeBlock:completeBlock];
                }
            }];
        }
            break;
        case ZLessonOrderHandleTypeSRefundCancle://取消退款
        {
            [ZOriganizationOrderViewModel refundOrderCanle:params completeBlock:completeBlock];
        }
            break;
        case ZLessonOrderHandleTypeORefund://同意退款
        {
            NSString *refunAmount = @"";
            if ([data isKindOfClass:[ZOrderListModel class]]) {
                ZOrderListModel *model = data;
                refunAmount = model.refund_amount;
            }else if ([data isKindOfClass:[ZOrderDetailModel class]]){
                ZOrderDetailModel *model = data;
                refunAmount = model.refund_amount;
            }
            [ZAlertView setAlertWithTitle:@"确定同意退款？" subTitle:[NSString stringWithFormat:@"退款金额金额为%@,同意后，需要支付此的退款金额给用户",refunAmount] leftBtnTitle:@"取消" rightBtnTitle:@"同意退款" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [params setObject:@"2" forKey:@"refund_type"];
                    [ZOriganizationOrderViewModel ogriganizationRefundOrderAgain:params completeBlock:completeBlock];
                }
            }];
            
        }
            break;
        case ZLessonOrderHandleTypeORefundReject://协商退款商家
        {
            NSString *refunAmount = @"";
            if ([data isKindOfClass:[ZOrderListModel class]]) {
                ZOrderListModel *model = data;
                refunAmount = model.refund_amount;
                [params setObject:model.refund_amount forKey:@"refund_amount"];
            }else if ([data isKindOfClass:[ZOrderDetailModel class]]){
                ZOrderDetailModel *model = data;
                refunAmount = model.refund_amount;
                [params setObject:model.refund_amount forKey:@"refund_amount"];
            }
            [ZAlertView setAlertWithTitle:@"确定重新协商此退款？" subTitle:[NSString stringWithFormat:@"您提议金额为%@,学员同意此金额后，商家需要支付此的退款金额给用户",refunAmount] leftBtnTitle:@"取消" rightBtnTitle:@"提交协商金额" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    [params setObject:@"1" forKey:@"refund_type"];
                    [ZOriganizationOrderViewModel ogriganizationRefundOrderAgain:params completeBlock:completeBlock];
                }
            }];
            
        }
            break;
        case ZLessonOrderHandleTypeRefundPay://支付退款
        {
            [ZPayAlertTypeView showWithHandlerBlock:^(NSInteger index) {
                if (index == 0) {
                    [params setObject:@"1" forKey:@"pay_type"];
                    if ([data isKindOfClass:[ZOrderListModel class]]) {
                        ZOrderListModel *model = data;
                        [params setObject:model.refund_amount forKey:@"pay_amount"];
                    }else if ([data isKindOfClass:[ZOrderDetailModel class]]){
                        ZOrderDetailModel *model = data;
                        [params setObject:model.refund_amount forKey:@"pay_amount"];
                    }
                    [[ZPayManager sharedManager] getRefundWechatPayInfo:params complete:^(BOOL isSuccess, NSString *message) {
                        
                    }];
                }else{
                    [params setObject:@"2" forKey:@"pay_type"];
                    if ([data isKindOfClass:[ZOrderListModel class]]) {
                        ZOrderListModel *model = data;
                        [params setObject:model.refund_amount forKey:@"pay_amount"];
                    }else if ([data isKindOfClass:[ZOrderDetailModel class]]){
                        ZOrderDetailModel *model = data;
                        [params setObject:model.refund_amount forKey:@"pay_amount"];
                    }
                    [[ZPayManager  sharedManager] getRefundAliPayInfo:params complete:^(BOOL isSuccess, NSString *message) {
                        
                    }];
                }
            }];
        }
            break;
        case ZLessonOrderHandleTypeClub://俱乐部
        {
            //外部做
        }
            break;
        case ZLessonOrderHandleTypeTel://电话
        {
            //外部做
        }
            break;
            
            
        default:
            break;
    }
}
@end
