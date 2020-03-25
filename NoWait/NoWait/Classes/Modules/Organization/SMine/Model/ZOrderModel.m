//
//  ZOrderModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrderModel.h"

@implementation ZOrderListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"orderType" : @"type",
             @"statusStr" : @"status_msg"
    };
}

- (ZStudentOrderType)type {
    // 1:等待支付 2:支付成功 3:支付失败 4:待接受预约 5:已接受预约 6:订单超时 7:申请退款 8:确认退款 9:退款中 10:已退款 11:取消订单 12:订单已完成 13：订单已删除 14:拒绝预约
    if (self.isStudent) {
        switch ([SafeStr(self.status) intValue]) {
            case 1:
                if ([self.orderType intValue] == 1) {
                    return ZStudentOrderTypeForPay;//待付款（去支付，取消）
                }else{
                    return ZStudentOrderTypeOrderForPay;//预约待付款（去支付，取消）
                }
                break;
            case 2:
                return ZStudentOrderTypeHadPay; //已付款（评价，退款，删除）
                break;
            case 3:
                if ([self.orderType intValue] == 1) {
                    return ZStudentOrderTypeForPay;//待付款（去支付，取消）
                }else{
                    return ZStudentOrderTypeOrderForPay;//预约待付款（去支付，取消）
                }
                break;
            case 4:
                return ZStudentOrderTypeOrderForReceived;//待接收（预约）
                break;
            case 5:
                return ZStudentOrderTypeOrderComplete;//已完成（预约，删除）
                break;
            case 6:
                if ([self.orderType intValue] == 1) {
                    return ZStudentOrderTypeOutTime; //超时(删除)
                }else{
                    return ZStudentOrderTypeOrderOutTime;//超时(删除)
                }
                break;
            case 7:
                return ZStudentOrderTypeForRefuse;//待退款
                break;
            case 8:
                return ZStudentOrderTypeRefuseReceive;//确认退款
                break;
            case 9:
                return ZStudentOrderTypeRefuseing;//退款中
                break;
            case 10:
                return ZStudentOrderTypeForRefuseComplete;//完成退款
                break;
            case 11:
                return ZStudentOrderTypeCancel;//已取消(删除)
                break;
            case 12:
                return ZStudentOrderTypeHadEva;//完成已评价
                break;
            case 14:
                return ZStudentOrderTypeOrderRefuse;//拒绝预约
                break;
            default:
                return ZStudentOrderTypeAll;
                break;
        }
    }else{
        switch ([SafeStr(self.status) intValue]) {
            case 1:
                if ([self.orderType intValue] == 1) {
                    return ZOrganizationOrderTypeForPay;//待付款（去支付，取消）
                }else{
                    return ZOrganizationOrderTypeOrderForPay;//预约待付款（去支付，取消）
                }
                break;
            case 2:
                return ZOrganizationOrderTypeHadPay; //已付款（评价，退款，删除）
                break;
            case 3:
                if ([self.orderType intValue] == 1) {
                    return ZOrganizationOrderTypeForPay;//待付款（去支付，取消）
                }else{
                    return ZOrganizationOrderTypeOrderForPay;//预约待付款（去支付，取消）
                }
                break;
            case 4:
                return ZOrganizationOrderTypeOrderForReceived;//待接收（预约）
                break;
            case 5:
                return ZOrganizationOrderTypeOrderComplete;//已完成（预约，删除）
                break;
            case 6:
                if ([self.orderType intValue] == 1) {
                    return ZOrganizationOrderTypeOutTime; //超时(删除)
                }else{
                    return ZOrganizationOrderTypeOrderOutTime;//超时(删除)
                }
                break;
            case 7:
                return ZOrganizationOrderTypeForRefuse;//待退款
                break;
            case 8:
                return ZOrganizationOrderTypeRefuseReceive;//确认退款
                break;
            case 9:
                return ZOrganizationOrderTypeRefuseing;//退款中
                break;
            case 10:
                return ZOrganizationOrderTypeForRefuseComplete;//完成退款
                break;
            case 11:
                return ZOrganizationOrderTypeCancel;//已取消(删除)
                break;
            case 12:
                return ZOrganizationOrderTypeHadEva;//完成已评价
                break;
            case 14:
                return ZOrganizationOrderTypeOrderRefuse;//拒绝预约
                break;
            default:
                return ZStudentOrderTypeAll;
                break;
        }
    }
}
@end

@implementation ZOrderDetailModel

- (ZStudentOrderType)type {
    // 1:等待支付 2:支付成功 3:支付失败 4:待接受预约 5:已接受预约 6:订单超时 7:申请退款 8:确认退款 9:退款中 10:已退款 11:取消订单 12:订单已完成 13：订单已删除 14:拒绝预约
    if (self.isStudent) {
        switch ([SafeStr(self.status) intValue]) {
            case 1:
                if ([self.orderType intValue] == 1) {
                    return ZStudentOrderTypeForPay;//待付款（去支付，取消）
                }else{
                    return ZStudentOrderTypeOrderForPay;//预约待付款（去支付，取消）
                }
                break;
            case 2:
                return ZStudentOrderTypeHadPay; //已付款（评价，退款，删除）
                break;
            case 3:
                if ([self.orderType intValue] == 1) {
                    return ZStudentOrderTypeForPay;//待付款（去支付，取消）
                }else{
                    return ZStudentOrderTypeOrderForPay;//预约待付款（去支付，取消）
                }
                break;
            case 4:
                return ZStudentOrderTypeOrderForReceived;//待接收（预约）
                break;
            case 5:
                return ZStudentOrderTypeOrderComplete;//已完成（预约，删除）
                break;
            case 6:
                if ([self.orderType intValue] == 1) {
                    return ZStudentOrderTypeOutTime; //超时(删除)
                }else{
                    return ZStudentOrderTypeOrderOutTime;//超时(删除)
                }
                break;
            case 7:
                return ZStudentOrderTypeForRefuse;//待退款
                break;
            case 8:
                return ZStudentOrderTypeRefuseReceive;//确认退款
                break;
            case 9:
                return ZStudentOrderTypeRefuseing;//退款中
                break;
            case 10:
                return ZStudentOrderTypeForRefuseComplete;//完成退款
                break;
            case 11:
                return ZStudentOrderTypeCancel;//已取消(删除)
                break;
            case 12:
                return ZStudentOrderTypeHadEva;//完成已评价
                break;
            case 14:
                return ZStudentOrderTypeOrderRefuse;//拒绝预约
                break;
            default:
                return ZStudentOrderTypeAll;
                break;
        }
    }else{
        switch ([SafeStr(self.status) intValue]) {
            case 1:
                if ([self.orderType intValue] == 1) {
                    return ZOrganizationOrderTypeForPay;//待付款（去支付，取消）
                }else{
                    return ZOrganizationOrderTypeOrderForPay;//预约待付款（去支付，取消）
                }
                break;
            case 2:
                return ZOrganizationOrderTypeHadPay; //已付款（评价，退款，删除）
                break;
            case 3:
                if ([self.orderType intValue] == 1) {
                    return ZOrganizationOrderTypeForPay;//待付款（去支付，取消）
                }else{
                    return ZOrganizationOrderTypeOrderForPay;//预约待付款（去支付，取消）
                }
                break;
            case 4:
                return ZOrganizationOrderTypeOrderForReceived;//待接收（预约）
                break;
            case 5:
                return ZOrganizationOrderTypeOrderComplete;//已完成（预约，删除）
                break;
            case 6:
                if ([self.orderType intValue] == 1) {
                    return ZOrganizationOrderTypeOutTime; //超时(删除)
                }else{
                    return ZOrganizationOrderTypeOrderOutTime;//超时(删除)
                }
                break;
            case 7:
                return ZOrganizationOrderTypeForRefuse;//待退款
                break;
            case 8:
                return ZOrganizationOrderTypeRefuseReceive;//确认退款
                break;
            case 9:
                return ZOrganizationOrderTypeRefuseing;//退款中
                break;
            case 10:
                return ZOrganizationOrderTypeForRefuseComplete;//完成退款
                break;
            case 11:
                return ZOrganizationOrderTypeCancel;//已取消(删除)
                break;
            case 12:
                return ZOrganizationOrderTypeHadEva;//完成已评价
                break;
            case 14:
                return ZOrganizationOrderTypeOrderRefuse;//拒绝预约
                break;
            default:
                return ZStudentOrderTypeAll;
                break;
        }
    }
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"orderType" : @"type",
             @"statusStr" : @"status_msg",
             @"order_id" : @"id"
    };
}
@end

@implementation ZOrderDetailNetModel

@end

@implementation ZOrderListNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZOrderListModel"
             };
}

@end

@implementation ZOrderAddNetModel

@end

@implementation ZOrderModel

@end
