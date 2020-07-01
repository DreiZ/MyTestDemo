//
//  ZStudentMineModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//购买课程流程
typedef NS_ENUM(NSInteger, ZLessonOrderHandleType) {
    ZLessonOrderHandleTypePay                       =  0,  //支付
    ZLessonOrderHandleTypeCancel                    =  1,  //取消
    ZLessonOrderHandleTypeDelete                    =  2,  //删除
    ZLessonOrderHandleTypeEva                       =  3,  //评价
    ZLessonOrderHandleTypeOrderReceive              =  4,  //接受预约
    ZLessonOrderHandleTypeOrderNOReceive            =  40,  //拒绝预约
    ZLessonOrderHandleTypeRefund                    =  5,  //退款
    ZLessonOrderHandleTypeSRefund                   =  50,  //同意退款
    ZLessonOrderHandleTypeSRefundReject             =  6,  //拒绝校区提议退款
    ZLessonOrderHandleTypeSRefundCancle             =  7,  //取消退款
    ZLessonOrderHandleTypeORefund                   =  8,  //同意退款（校区）
    ZLessonOrderHandleTypeORefundReject             =  9,  //拒绝退款重新协商（校区）
    ZLessonOrderHandleTypeRefundPay                 =  10, //支付退款（校区）
    ZLessonOrderHandleTypeTel                       =  101,  //电话
    ZLessonOrderHandleTypeDetail                    =  102,  //详情
    ZLessonOrderHandleTypeClub                      =  103,  //校区详情
    ZLessonOrderHandleTypeLesson                    =  104,  //校区详情
};
  

//默认0 1:等待支付 2:支付成功 3:支付失败 4:待接受预约 5:已接受预约 6:订单超时  11:取消订单 12:订单已完成 13：订单已删除 14:拒绝预约
//订单状态
typedef NS_ENUM(NSInteger, ZStudentOrderType) {
    ZStudentOrderTypeForPay  =   0,         //待付款（去支付，取消）
    ZStudentOrderTypeHadPay,                //已付款（评价，退款，删除）
    ZStudentOrderTypeHadEva,                //完成已评价(删除)
    ZStudentOrderTypeOutTime,               //超时(删除)
    ZStudentOrderTypeCancel,                //已取消(删除)
    
    ZStudentOrderTypeOrderForPay,           //预约待付款（去支付，取消）
    ZStudentOrderTypeOrderForReceived,      //待接收（预约）
    ZStudentOrderTypeOrderComplete,         //已完成（预约，删除）
    ZStudentOrderTypeOrderRefuse,           //已拒绝（预约）
    ZStudentOrderTypeOrderOutTime,          //超时(删除)
    
    ZStudentOrderTypeAll,                    //全部
    
    ZOrganizationOrderTypeForPay,                //待付款
    ZOrganizationOrderTypeHadPay,                //已付款
    ZOrganizationOrderTypeHadEva,                //完成已评价(删除)
    ZOrganizationOrderTypeOutTime,               //超时(删除)
    ZOrganizationOrderTypeCancel,                //已取消(删除)
    
    ZOrganizationOrderTypeOrderForPay,           //待付款（去支付，取消）
    ZOrganizationOrderTypeOrderForReceived,      //待接收（预约）
    ZOrganizationOrderTypeOrderComplete,         //已完成（预约，删除）
    ZOrganizationOrderTypeOrderRefuse,           //已拒绝（预约）
    ZOrganizationOrderTypeOrderOutTime,          //超时(删除)
    
    ZOrganizationOrderTypeAll,                   //全部
};

//1：学员申请 2：校区拒绝 3：学员拒绝 4：学员同意 5：校区同意 6:学员取消 7：校区支付成功
typedef NS_ENUM(NSInteger, ZRefundOrderType) {
    ZRefundOrderTypeRefund  =   1,
    ZRefundOrderTypeOrganizationReject,
    ZRefundOrderTypeStudentReject,
    ZRefundOrderTypeStudentAgree,
    ZRefundOrderTypeOrganizationAgree,
    ZRefundOrderTypeStudentCancle,
    ZRefundOrderTypeOrganizationPay,
};

@interface ZStudentMineModel : NSObject

@end

