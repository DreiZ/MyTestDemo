//
//  ZOriganizationLessonModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseModel.h"
#import "ZBaseNetworkBackModel.h"

//课程管理 课程类别
typedef NS_ENUM(NSInteger, ZOrganizationLessonType) {
    ZOrganizationLessonTypeOpen  =   0,   //开放
    ZOrganizationLessonTypeClose,         //未开放
    ZOrganizationLessonTypeExamine,       //审核中
    ZOrganizationLessonTypeExamineFail,   //审核失败
    ZOrganizationLessonTypeAll,           //全部
};

@interface ZOriganizationLessonModel : ZBaseModel

@end

@interface ZOriganizationLessonListModel : ZBaseModel
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *sale;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *fail;
@property (nonatomic,assign) ZOrganizationLessonType type;

@end

@interface ZOriganizationLessonListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationLessonListModel *>*list;
@property (nonatomic,copy) NSString *pages;
@end

@interface ZOriganizationLessonAddModel : ZBaseModel
@property (nonatomic,strong) id coverImage;
@property (nonatomic,strong) NSString *lessonName;
@property (nonatomic,strong) NSString *lessonIntro;
@property (nonatomic,strong) NSMutableArray *lessonDetail;
@property (nonatomic,strong) NSString *lessonPrice;
@property (nonatomic,strong) NSMutableArray *lessonImages;
@property (nonatomic,strong) NSString *school;
@property (nonatomic,strong) NSString *level;
@property (nonatomic,strong) NSString *singleTime;
@property (nonatomic,strong) NSString *lessonNum;
@property (nonatomic,strong) NSString *lessonPeoples;
@property (nonatomic,assign) BOOL isOrder;//是否接受预约
@property (nonatomic,strong) NSString *orderPrice;//预约价格
@property (nonatomic,strong) NSString *orderMin;//预约时间
@property (nonatomic,strong) NSString *orderTimeBegin;//预约时间段
@property (nonatomic,strong) NSString *orderTimeEnd;//预约时间段结束

@property (nonatomic,strong) NSString *validity;//有效期
@property (nonatomic,strong) NSString *isGu;//0：固定时间 1:人满开课
@property (nonatomic,strong) NSMutableArray *guTimeArr;//固定时间
@end
