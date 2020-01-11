//
//  ZStudentDetailModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//购买课程流程
typedef NS_ENUM(NSInteger, lessonBuyType) {
    lessonBuyTypeSubscribeInitial,  //从机构开始预约
    lessonBuyTypeSubscribeBeginLesson,  //从课程开始选择预约
    lessonBuyTypeBuyInitial,  //从机构开始购买
    lessonBuyTypeBuyBeginLesson,  //从课程开始购买
};

@interface ZStudentDetailLessonOrderCoachModel : NSObject
@property (nonatomic,strong) NSString *coachName;
@property (nonatomic,strong) NSString *coachImage;
@property (nonatomic,strong) NSString *auth;
@property (nonatomic,strong) NSString *desStr;
@property (nonatomic,strong) NSArray *labelArr;
@property (nonatomic,strong) NSArray *adeptArr;
@end

@interface ZStudentDetailOrderSubmitListModel : NSObject
@property (nonatomic,strong) NSString *leftImage;
@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,strong) NSString *rightTitle;
@property (nonatomic,strong) NSString *rightImage;
@property (nonatomic,strong) NSString *cellTitle;
@property (nonatomic,strong) UIColor *leftColor;
@property (nonatomic,strong) UIColor *rightColor;


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

@interface ZStudentDetailEvaListModel : NSObject
@property (nonatomic,strong) NSString *userImage;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *star;
@property (nonatomic,strong) NSString *evaDes;
@end

@interface ZStudentDetailDesListModel : NSObject
@property (nonatomic,strong) NSString *desTitle;
@property (nonatomic,strong) NSString *desSub;

@end

@interface ZStudentDetailDesModel : NSObject

@end

@interface ZStudentDetailNoticeModel : NSObject

@end

@interface ZStudentDetailEvaModel : NSObject

@end

@interface ZStudentDetailSectionModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *right;
@property (nonatomic,assign) BOOL isShowRight;
@end

@interface ZStudentDetailContentListModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image;

@end

@interface ZStudentDetailBannerModel : NSObject

@end

@interface ZStudentDetailPersonnelModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *skill;

@end

@interface ZStudentDetailModel : NSObject

@end

