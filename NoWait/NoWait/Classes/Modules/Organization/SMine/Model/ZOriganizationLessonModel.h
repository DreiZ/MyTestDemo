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
@class ZOriganizationCardListModel;

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


@interface ZOriganizationLessonExperienceTimeSubModel : ZBaseModel
@property (nonatomic,strong) NSString *time;
@property (nonatomic,assign) BOOL isSubTimeSelected;
@end

@interface ZOriganizationLessonExperienceTimeModel : ZBaseModel
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,assign) BOOL isTimeSelected;
@property (nonatomic,strong) NSArray *timeArr;
@end

@interface ZOriganizationLessonListModel : ZBaseModel
@property (nonatomic,strong) NSString *status;//（0：全部 1：开放 2：未开放 3：审核中 4：审核失败）
@property (nonatomic,strong) NSString *statusStr;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *short_name;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *pay_nums;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *image_url;
@property (nonatomic,strong) NSString *fail;
@property (nonatomic,assign) ZOrganizationLessonType type;
@property (nonatomic,strong) NSString *lessonID;
@property (nonatomic,strong) NSString *teacherPirce;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,strong) NSString *notice_msg;

@property (nonatomic,strong) NSString *courses_id;
@property (nonatomic,strong) NSString *courses_name;
@property (nonatomic,strong) NSString *courses_price;

@property (nonatomic,strong) NSString *total_course_min;

@property (nonatomic,strong) NSString *experience_duration;
@property (nonatomic,strong) NSString *experience_price;
@property (nonatomic,strong) NSArray <ZOriganizationLessonExperienceTimeModel *>*experience_time;

//课程表用
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *course_name;
@property (nonatomic,strong) NSString *course_id;
@property (nonatomic,strong) NSString *key;
@end


@interface ZOriganizationLessonAddModel : ZBaseModel
@property (nonatomic,strong) NSString *lessonID;
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) id image_url;
@property (nonatomic,strong) NSString *image_net_url;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *short_name;
@property (nonatomic,strong) NSString *info;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSString *school;
@property (nonatomic,strong) NSString *level;// 1: 初级，2：进阶 3：精英
@property (nonatomic,strong) NSString *course_min;
@property (nonatomic,strong) NSString *course_number;
@property (nonatomic,strong) NSString *course_class_number;
@property (nonatomic,strong) NSString *is_experience;//是否接受预约1: 是 2：否
@property (nonatomic,strong) NSString *experience_price;//预约价格
@property (nonatomic,strong) NSString *experience_duration;//预约时间
@property (nonatomic,strong) NSMutableArray *experience_time;
@property (nonatomic,strong) NSString *experience_time_net;
@property (nonatomic,strong) NSString *valid_at;//有效期
@property (nonatomic,strong) NSString *type;//1: 固定时间开课 2：人满开课
@property (nonatomic,strong) NSMutableArray *fix_time;//固定时间
@property (nonatomic,strong) NSString *fix_time_net;//固定时间
@property (nonatomic,strong) NSString *p_information;

@property (nonatomic,strong) NSString *status;//（0：全部 1：开放 2：未开放 3：审核中 4：审核失败）
@property (nonatomic,strong) NSString *statusStr;
@property (nonatomic,strong) NSString *pay_nums;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *fail;
@property (nonatomic,assign) ZOrganizationLessonType lessonType;
@end


@interface ZOriganizationLessonTeacherModel : ZBaseModel
@property (nonatomic,strong) NSString *teacher_id;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,assign) NSInteger isSelected;
@end

@interface ZOriganizationLessonDetailModel : ZOriganizationLessonAddModel
@property (nonatomic,strong) NSString *create_at;
@property (nonatomic,strong) NSString *notice_msg;
@property (nonatomic,strong) NSString *stores_courses_nums;
@property (nonatomic,strong) NSString *stores_image;
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,strong) NSArray <ZOriganizationLessonTeacherModel *>*teacher_list;
@property (nonatomic,strong) NSString *update_at;
@property (nonatomic,strong) NSArray <ZOriganizationCardListModel *>*coupons_list;;
@end

@interface ZOriganizationLessonListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationLessonListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end


@interface ZOriganizationLessonDayListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationLessonListModel *>*list;
@property (nonatomic,copy) NSString *day_date;
@end

@interface ZOriganizationLessonWeekListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationLessonDayListNetModel *>*list;
@property (nonatomic,copy) NSString *total;
@end


@interface ZOriganizationLessonScheduleListModel : ZBaseModel
@property (nonatomic,strong) NSString *lessonID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image_url;
@property (nonatomic,strong) NSString *course_class_number;

@property (nonatomic,strong) NSString *wait_students;
@property (nonatomic,strong) NSString *fill_students;
@property (nonatomic,strong) NSDictionary *fix_time;
@property (nonatomic,strong) NSMutableArray *fix_timeArr;

@property (nonatomic,strong) NSString *fixType;//类型 1: 固定时间开课 2：人满开课
@end

@interface ZOriganizationLessonScheduleListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationLessonListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end
