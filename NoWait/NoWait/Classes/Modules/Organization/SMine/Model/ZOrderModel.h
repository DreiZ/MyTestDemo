//
//  ZOrderModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseModel.h"
#import "ZStudentMineModel.h"

@interface ZOrderListModel : ZBaseModel
@property (nonatomic,strong) NSString *account_image;
@property (nonatomic,strong) NSString *courses_image_url;
@property (nonatomic,strong) NSString *courses_name;
@property (nonatomic,strong) NSString *order_amount;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *order_no;
@property (nonatomic,strong) NSString *pay_amount;
@property (nonatomic,strong) NSString *pay_type;
@property (nonatomic,strong) NSString *statusStr;
@property (nonatomic,strong) NSString *orderType;//课程类型 1: 普通 2：预约
@property (nonatomic,strong) NSString *students_name;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *stores_id;


@property (nonatomic,strong) NSString *experience_duration;

@property (nonatomic,strong) NSString *status;//默认0 1:等待支付 2:支付成功 3:支付失败 4:待接受预约 5:已接受预约 6:订单超时 7:申请退款 8:确认退款 9:退款中 10:已退款 11:取消订单 12:订单已完成 13：订单已删除 14:拒绝预约
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,assign) BOOL isStudent;
@property (nonatomic,assign) ZStudentOrderType type;
@end

@interface ZOrderDetailModel : ZBaseModel
@property (nonatomic,assign) BOOL isStudent;
@property (nonatomic,assign) ZStudentOrderType type;
@property (nonatomic,strong) NSString * account_id;
@property (nonatomic,strong) NSString * account_phone;
@property (nonatomic,strong) NSString * students_name;
@property (nonatomic,strong) NSString * coupons_amount;
@property (nonatomic,strong) NSString * coupons_id;
@property (nonatomic,strong) NSString * course_id;
@property (nonatomic,strong) NSString * course_image_url;
@property (nonatomic,strong) NSString * course_min;
@property (nonatomic,strong) NSString * course_name;
@property (nonatomic,strong) NSString * course_number;
@property (nonatomic,strong) NSString * course_total_min;
@property (nonatomic,strong) NSString * create_at;
@property (nonatomic,strong) NSString * err_msg;
@property (nonatomic,strong) NSString * finish_time;
@property (nonatomic,strong) NSString * order_id;
@property (nonatomic,strong) NSString * order_amount;
@property (nonatomic,strong) NSString * order_no;
@property (nonatomic,strong) NSString * out_refund_no;
@property (nonatomic,strong) NSString * pay_amount;
@property (nonatomic,strong) NSString * pay_time;
@property (nonatomic,strong) NSString * pay_type;
@property (nonatomic,strong) NSString * refund_id;
@property (nonatomic,strong) NSString * refund_msg;
@property (nonatomic,strong) NSString * schedule_time;
@property (nonatomic,strong) NSString * status;
@property (nonatomic,strong) NSString * statusStr;
@property (nonatomic,strong) NSString * store_name;
@property (nonatomic,strong) NSString * stores_id;
@property (nonatomic,strong) NSString * teacher_id;;
@property (nonatomic,strong) NSString * teacher_name;
@property (nonatomic,strong) NSString * trade_no;
@property (nonatomic,strong) NSString * orderType;
@property (nonatomic,strong) NSString * update_at;
@property (nonatomic,strong) NSString * use_coupons;//是否使用优惠券 1：否 2：是
@property (nonatomic,strong) NSString * valid_at;
@end


@interface ZOrderDetailNetModel : ZBaseModel

@end


@interface ZOrderListNetModel :  ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOrderListModel *>*list;
@property (nonatomic,copy) NSString *total;

@end


@interface ZOrderAddNetModel : ZBaseModel
@property (nonatomic,strong) NSString *order_amount;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *order_no;
@property (nonatomic,strong) NSString *pay_amount;
@property (nonatomic,strong) NSString *message;

@end


@interface ZOrderEvaModel : ZBaseModel
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *stores_comment_score;
@property (nonatomic,strong) NSString *stores_comment_desc;
@property (nonatomic,strong) NSString *teahcer_comment_score;
@property (nonatomic,strong) NSString *teacher_comment_desc;
@property (nonatomic,strong) NSString *courses_comment_score;
@property (nonatomic,strong) NSString *courses_comment_desc;
@end

@interface ZOrderModel : ZBaseModel

@end


