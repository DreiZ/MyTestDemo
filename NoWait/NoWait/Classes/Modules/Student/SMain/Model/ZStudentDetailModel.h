//
//  ZStudentDetailModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//购买课程流程
typedef NS_ENUM(NSInteger, ZLessonBuyType) {
    ZLessonBuyTypeSubscribeInitial,  //从机构开始预约
    ZLessonBuyTypeSubscribeBeginLesson,  //从课程开始选择预约
    ZLessonBuyTypeBuyInitial,  //从机构开始购买
    ZLessonBuyTypeBuyBeginLesson,  //从课程开始购买
};

//购买课程流程
typedef NS_ENUM(NSInteger, ZLessonOrderType) {
    ZLessonOrderTypeWaitPay,  //待支付
    ZLessonOrderTypeHadPay,  //已支付
};

@interface ZStudentDetailOrderSubmitListModel : NSObject
@property (nonatomic,strong) NSString *leftImage;
@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,strong) NSString *rightTitle;
@property (nonatomic,strong) NSString *rightImage;
@property (nonatomic,strong) NSString *cellTitle;

@property (nonatomic,strong) UIColor *leftColor;
@property (nonatomic,strong) UIColor *rightColor;
@property (nonatomic,strong) UIFont *leftFont;
@property (nonatomic,strong) UIFont *rightFont;
@property (nonatomic,strong) id rightImageH;
@property (nonatomic,assign) BOOL isHiddenBottomLine;
@end

@interface ZStudentDetailLessonTimeSubModel : NSObject
@property (nonatomic,strong) NSString *subTime;
@property (nonatomic,assign) BOOL isSubTimeSelected;
@end

@interface ZStudentDetailLessonTimeModel : NSObject
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSArray <ZStudentDetailLessonTimeSubModel *>*subTimes;
@property (nonatomic,assign) BOOL isTimeSelected;
@end

@interface ZStudentDetailLessonCoachModel : NSObject
@property (nonatomic,strong) NSString *coachName;
@property (nonatomic,strong) NSString *coachImage;
@property (nonatomic,strong) NSString *coachPrice;
@property (nonatomic,assign) BOOL isCoachSelected;
@property (nonatomic,assign) BOOL isgold;
@end

@interface ZStudentDetailLessonListModel : NSObject
@property (nonatomic,strong) NSString *lessonTitle;
@property (nonatomic,strong) NSString *lessonNum;
@property (nonatomic,strong) NSString *lessonTime;
@property (nonatomic,strong) NSString *lessonStudentNum;
@property (nonatomic,strong) NSString *lessonPrice;
@property (nonatomic,assign) BOOL isLessonSelected;
@end

@interface ZStudentDetailPersonnelModel : NSObject
@property (nonatomic,strong) NSString *account_id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *skill;
@property (nonatomic,strong) id data;

@end

@interface ZStudentDetailModel : NSObject

@end

