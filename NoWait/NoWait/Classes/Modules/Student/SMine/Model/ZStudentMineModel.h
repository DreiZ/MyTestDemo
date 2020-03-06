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
    ZLessonOrderHandleTypePay,  //支付
    ZLessonOrderHandleTypeCancel,  //取消
    ZLessonOrderHandleTypeTel,  //电话
    ZLessonOrderHandleTypeDetail,  //详情
};


//课程管理 课程类别
typedef NS_ENUM(NSInteger, ZStudentOrderType) {
    ZStudentOrderTypeForPay  =   0,   //待付款（去支付，取消）
    ZStudentOrderTypeHadPay,          //已付款（评价，退款，删除）
    ZStudentOrderTypeHadEva,          //完成已评价(删除)
    ZStudentOrderTypeOutTime,         //超时(删除)
    ZStudentOrderTypeCancel,          //已取消(删除)
    ZStudentOrderTypeForReceived,     //待接收（预约）
    ZStudentOrderTypeComplete,        //已完成（预约，删除）
    ZStudentOrderTypeRefuse,          //已拒绝（预约）
    ZStudentOrderTypeAll,             //全部
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

@property (nonatomic,assign) ZStudentOrderType type;

@end

