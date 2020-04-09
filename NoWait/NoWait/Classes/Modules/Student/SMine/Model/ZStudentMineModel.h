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
    ZLessonOrderHandleTypeSRefundReject             =  6,  //拒绝商家提议退款
    ZLessonOrderHandleTypeSRefundCancle             =  7,  //取消退款
    ZLessonOrderHandleTypeORefund                   =  8,  //同意退款（商家）
    ZLessonOrderHandleTypeORefundReject             =  9,  //拒绝退款重新协商（商家）
    ZLessonOrderHandleTypeRefundPay                 =  10, //支付退款（商家）
    ZLessonOrderHandleTypeTel                       =  101,  //电话
    ZLessonOrderHandleTypeDetail                    =  102,  //详情
    ZLessonOrderHandleTypeClub                      =  103,  //校区详情
};
  

// 1:等待支付 2:支付成功 3:支付失败 4:待接受预约 5:已接受预约 6:订单超时 7:申请退款 8:确认退款 9:退款中 10:已退款 11:取消订单 12:订单已完成 13：订单已删除
//课程管理 课程类别
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
    
    ZStudentOrderTypeForRefund,              //待退款
    ZStudentOrderTypeRefundReceive,          //确认退款
    ZStudentOrderTypeRefunding,              //退款中
    ZStudentOrderTypeForRefundComplete,      //退款
    ZStudentOrderTypeAll,                    //全部
    ZStudentOrderTypeRefundCancle,            //全部
    
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
    
    ZOrganizationOrderTypeForRefund,              //待退款
    ZOrganizationOrderTypeRefundReceive,          //确认退款
    ZOrganizationOrderTypeRefunding,              //退款中
    ZOrganizationOrderTypeForRefundComplete,      //退款完成
    ZOrganizationOrderTypeAll,                   //全部
    ZOrganizationOrderTypeRefundCancle,          //待退款
};


@interface ZStudentOrderEvaModel : NSObject
@property (nonatomic,strong) NSString *orderImage;
@property (nonatomic,strong) NSString *orderNum;
@property (nonatomic,strong) NSString *lessonTitle;
@property (nonatomic,strong) NSString *lessonTime;
@property (nonatomic,strong) NSString *lessonCoach;
@property (nonatomic,strong) NSString *lessonOrg;
@property (nonatomic,strong) NSString *coachStar;
@property (nonatomic,strong) NSString *coachEva;
@property (nonatomic,strong) NSArray *coachEvaImages;

@property (nonatomic,strong) NSString *orgStar;
@property (nonatomic,strong) NSString *orgEva;
@property (nonatomic,strong) NSArray *orgEvaImages;
@end

@interface ZStudentLessonModel : NSObject
@property (nonatomic,strong) NSString *lessonName;
@property (nonatomic,strong) NSString *allCount;

@end



@interface ZStudentMenuItemModel : NSObject
@property (nonatomic,copy) NSString *channel_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *imageName;
@end


@interface ZStudentMineModel : NSObject

@end


@interface ZStudentOrderListModel : NSObject
@property (nonatomic,strong) NSString *orderType;  //0预约 1正常
@property (nonatomic,strong) NSString *club;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *image;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *price;

@property (nonatomic,strong) NSString *tiTime;
@property (nonatomic,strong) NSString *teacher;
@property (nonatomic,strong) NSString *fail;

@property (nonatomic,strong) NSString *lessonNum;
@property (nonatomic,strong) NSString *lessonSignleTime;
@property (nonatomic,strong) NSString *lessonTime;
@property (nonatomic,strong) NSString *lessonValidity;
@property (nonatomic,strong) NSString *lessonFavourable;//优惠
@property (nonatomic,strong) NSString *lessonPrice;//
@property (nonatomic,assign) NSInteger payLimit;
@property (nonatomic,assign) BOOL isRefuse;
@property (nonatomic,assign) ZStudentOrderType type;

@end

