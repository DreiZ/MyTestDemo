//
//  ZMessgeModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseNetworkBackModel.h"


typedef NS_ENUM(NSInteger,ZCustomNoticeType){
    ZCustomNoticeTypeSettledIn  = 1,                        //  机构入驻通知
    ZCustomNoticeTypeCourseAudit  = 2,                    //  课程审核通知
    ZCustomNoticeTypePayment  = 3,                       //  支付交易通知
    ZCustomNoticeTypeRefund  = 4,                          //  退款通知
    ZCustomNoticeTypeMoneyBack  = 5,                      //  回款通知
    ZCustomNoticeTypeRegister  = 6,                        //  注册通知
    ZCustomNoticeTypeAppointment  = 7,                     //  预约通知
    ZCustomNoticeTypeCourseBegins  = 8,                   //  开课通知
    ZCustomNoticeTypeCourseEnd  = 9,                      //  结课通知
    ZCustomNoticeTypeCourseSign  = 10,                     //  签课通知
    ZCustomNoticeTypeEvaluate  = 11,                        //  评价通知
    ZCustomNoticeTypeCustom  = 12,
    ZCustomNoticeTypeNotice  = 13,                        //机构老师通知
};

typedef NS_ENUM(NSInteger,ZCustomChannleType){
    ZCustomChannleTypeInteract  =  1,         //  互动消息
    ZCustomChannleTypeSystem   =  2,           //  系统消息
    ZCustomChannleTypeStore   =  3,           //  校区消息
    ZCustomChannleTypeTeacher   =  4,           //  老师消息
    ZCustomChannleTypeStudent   =  5,           //  学员消息
    ZCustomChannleTypeCustom   =  6,           //  自定义消息
};


typedef NS_ENUM(NSInteger,ZCustomTerminalType){
    ZCustomTerminalTypeMechanism =  1,   //  机构端
    ZCustomTerminalTypeStore =  2,    //  校区端
    ZCustomTerminalTypeStudent =  3,   //  学员端
    ZCustomTerminalTypeTeacher =  4,    //  教师端
    ZCustomTerminalTypePlatform =  4,    //  平台
};



@interface ZMessageAccountModel : NSObject
@property (nonatomic,strong) NSString *nick_name;
@property (nonatomic,strong) NSString *image;
@end


@interface ZMessageExtraModel : NSObject
@property (nonatomic,strong) NSString *account_total;
@property (nonatomic,strong) NSString *store_id;
@property (nonatomic,strong) NSString *store_name;
@property (nonatomic,strong) NSString *teacher;
@property (nonatomic,strong) NSString *teacher_image;
@property (nonatomic,strong) NSString *order_id;

@end

@interface ZMessageInfoModel : NSObject
@property (nonatomic,strong) NSString *terminal;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *notice;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) ZMessageExtraModel *extra;
@property (nonatomic,strong) NSString *message_id;
@property (nonatomic,strong) NSString *teacher;
@property (nonatomic,strong) NSString *teacher_image;
@property (nonatomic,strong) NSString *store_name;
@property (nonatomic,strong) NSString *store_id;

@property (nonatomic,strong) NSArray <ZMessageAccountModel *>*account;
@end

@interface ZMessgeModel : NSObject
@property (nonatomic,strong) NSString *terminal;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *notice;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) ZMessageExtraModel *extra;
@property (nonatomic,strong) NSString *message_id;
@end

@interface ZMessageNetModel : NSObject
@property (nonatomic,strong) NSArray <ZMessgeModel *>*list;
@property (nonatomic,strong) NSString *total;

@end
