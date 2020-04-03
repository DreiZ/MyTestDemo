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
@property (nonatomic,strong) NSString *type;//课程类型 1: 普通 2：预约
@property (nonatomic,strong) NSString *students_name;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *stores_id;


@property (nonatomic,strong) NSString *experience_duration;

@property (nonatomic,strong) NSString *status;//默认0 1:等待支付 2:支付成功 3:支付失败 4:待接受预约 5:已接受预约 6:订单超时 7:申请退款 8:确认退款 9:退款中 10:已退款 11:取消订单 12:订单已完成 13：订单已删除 14:拒绝预约
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,assign) BOOL isStudent;
@property (nonatomic,assign) ZStudentOrderType order_type;
@end

@interface ZOrderDetailModel : ZBaseModel
@property (nonatomic,assign) BOOL isStudent;
@property (nonatomic,assign) ZStudentOrderType order_type;
@property (nonatomic,strong) NSString * account_id;
@property (nonatomic,strong) NSString * account_phone;
@property (nonatomic,strong) NSString * students_name;
@property (nonatomic,strong) NSString * nick_name;
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
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * update_at;
@property (nonatomic,strong) NSString * use_coupons;//是否使用优惠券 1：否 2：是
@property (nonatomic,strong) NSString * valid_at;

@property (nonatomic,strong) NSString *emergency_name;
@property (nonatomic,strong) NSString *emergency_phone;
@property (nonatomic,strong) NSString *emergency_contact;

@property (nonatomic,strong) NSString *experience_price;
@property (nonatomic,strong) NSString *experience_duration;
@property (nonatomic,strong) NSString *experience_time;
@property (nonatomic,strong) NSString *count_down;

@property (nonatomic,strong) NSString *refund_status_msg;
@property (nonatomic,strong) NSString *refund_amount;
@property (nonatomic,strong) NSString *refund_status;//申请退款中的状态  状态：1：学员申请 2：商家拒绝 3：学员拒绝 4：学员同意 5：商家同意

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


@interface ZOrderEvaListModel : ZBaseModel
@property (nonatomic,strong) NSString *account_id;
@property (nonatomic,strong) NSString *comment_type;
@property (nonatomic,strong) NSString *create_at;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *eva_id;
@property (nonatomic,strong) NSString *is_reply;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *parent_id;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *stores_courses_id;
@property (nonatomic,strong) NSString *stores_courses_image;
@property (nonatomic,strong) NSString *stores_courses_name;
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,strong) NSString *teacher_id;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *type_id;
@property (nonatomic,strong) NSString *update_at;
@property (nonatomic,strong) NSString *student_name;
@property (nonatomic,strong) NSString *student_image;
@property (nonatomic,strong) NSString *pay_amount;
@property (nonatomic,strong) NSString *order_amount;
@property (nonatomic,strong) NSString *reply_desc;

@end


@interface ZOrderEvaDetailModel : ZBaseModel
@property (nonatomic,strong) NSString *course_id;
@property (nonatomic,strong) NSString *courses_comment_desc;
@property (nonatomic,strong) NSString *courses_comment_score;
@property (nonatomic,strong) NSString *courses_image_url;
@property (nonatomic,strong) NSString *courses_name;
@property (nonatomic,strong) NSString *order_amount;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *pay_amount;
@property (nonatomic,strong) NSString *stores_comment_desc;
@property (nonatomic,strong) NSString *stores_comment_score;
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,strong) NSString *teacher_comment_desc;
@property (nonatomic,strong) NSString *teacher_comment_score;
@property (nonatomic,strong) NSString *teacher_id;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *course_is_reply;
@property (nonatomic,strong) NSString *stores_is_reply;
@property (nonatomic,strong) NSString *teacher_is_reply;
@property (nonatomic,strong) NSString *stores_reply_desc;
@property (nonatomic,strong) NSString *courses_reply_desc;
@property (nonatomic,strong) NSString *teacher_reply_desc;
@property (nonatomic,strong) NSString *has_update;

@end

@interface ZOrderEvaListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOrderEvaListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end


@interface ZOrderAddModel : ZBaseModel
@property (nonatomic,strong) NSString *teacher_image;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *teacher_id;
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,strong) NSString *lesson_name;
@property (nonatomic,strong) NSString *lesson_id;
@property (nonatomic,strong) NSString *price;
@end



@interface ZMineOrderPayBackModel : ZBaseModel
@property (nonatomic,strong) NSString *pay_code;
@property (nonatomic,strong) NSString *appid;
@property (nonatomic,strong) NSString *mch_id;
@property (nonatomic,strong) NSString *nonce_str;
@property (nonatomic,strong) NSString *prepay_id;
@property (nonatomic,strong) NSString *result_code;
@property (nonatomic,strong) NSString *return_code;
@property (nonatomic,strong) NSString *return_msg;
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *trade_type;
@property (nonatomic,strong) NSString *timestamp;
@end

@interface ZOrderModel : ZBaseModel

@end


