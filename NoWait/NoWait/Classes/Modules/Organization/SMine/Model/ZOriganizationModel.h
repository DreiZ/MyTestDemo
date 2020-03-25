//
//  ZOriganizationModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseModel.h"
#import "ZBaseNetworkBackModel.h"


@interface ZOriganizationModel : ZBaseModel

@end


@interface ZOriganizationAddClassModel : NSObject
@property (nonatomic,strong) NSMutableArray *lessonTimeArr;
@property (nonatomic,strong) NSArray *lessonOrderArr;
@property (nonatomic,strong) NSString *class_Name;
@property (nonatomic,assign) NSString *singleTime;
@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherID;
@end


#pragma mark - 班级管理
@interface ZOriganizationClassListModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSString *courses_name;
@property (nonatomic,strong) NSString *classID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *nums;
@property (nonatomic,strong) NSString *status;// 0：全部 1：待开课 2：已开课 3：已结课
@property (nonatomic,strong) NSString *teacher_id;
@property (nonatomic,strong) NSString *teacher_image;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *type;

@end

@interface ZOriganizationClassListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationClassListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end

@interface ZOriganizationClassDetailModel : NSObject
@property (nonatomic,strong) NSString *courses_name;
@property (nonatomic,strong) NSString *classID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *nums;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *teacher_id;
@property (nonatomic,strong) NSString *teacher_image;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *stores_courses_name;

@property (nonatomic,strong) NSString *account_id;
@property (nonatomic,strong) NSDictionary *classes_date;
@property (nonatomic,strong) NSMutableArray *classes_dateArr;
@property (nonatomic,strong) NSString *courses_id;
@property (nonatomic,strong) NSString *create_at;
@property (nonatomic,strong) NSString *end_time;
@property (nonatomic,strong) NSString *schedule;
@property (nonatomic,strong) NSString *start_time;
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *stores_name;
@property (nonatomic,strong) NSString *update_at;
@end

#pragma mark - 校区管理
@interface ZOriganizationSchoolListModel : NSObject
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *schoolID;
@property (nonatomic,strong) NSString *name;
@end

@interface ZOriganizationSchoolListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationSchoolListModel *>*list;

@end

@interface ZOriganizationSchoolDetailModel : NSObject
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *brief_address;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *county;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *hash_update_address;
@property (nonatomic,strong) NSString *hash_update_name;
@property (nonatomic,strong) NSString *hash_update_store_type_id;
@property (nonatomic,strong) NSString *schoolID;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *landmark;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *merchants_id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *opend_end;
@property (nonatomic,strong) NSString *opend_start;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *place;
@property (nonatomic,strong) NSString *regional_id;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *store_type_id;

@property (nonatomic,strong) NSMutableArray *months;
@property (nonatomic,strong) NSMutableArray *stores_info;
@property (nonatomic,strong) NSMutableArray *week_days;
@property (nonatomic,strong) NSMutableArray *merchant_stores_tags;
@end


#pragma mark - 学员管理
@interface ZOriganizationStudentListModel : ZBaseModel
@property (nonatomic,strong) NSString *studentID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *status;//0:全部 1：待排课 2：待开课 3：已开课 4：已结课 5：待补课 6：已过期
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *teacher_image;
@property (nonatomic,strong) NSString *courses_name;
@property (nonatomic,strong) NSString *total_progress;
@property (nonatomic,strong) NSString *now_progress;
@property (nonatomic,strong) NSString *stores_coach_id;
@property (nonatomic,strong) NSString *stores_courses_class_id;
@property (nonatomic,strong) NSString *coach_img;
@property (nonatomic,strong) NSString *teacher_id;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL isEdit;
@end


@interface ZOriganizationStudentAddModel : ZBaseModel
@property (nonatomic,strong) NSString *studentID;
@property (nonatomic,strong) NSString *stores_id; //门店id
@property (nonatomic,strong) NSString *stores_name;

@property (nonatomic,strong) NSString *code_id; //用户code_id
@property (nonatomic,strong) NSString *name; //学员姓名
@property (nonatomic,strong) NSString *phone;//学员手机号
@property (nonatomic,strong) id image; //学员头像
@property (nonatomic,strong) NSString *birthday;//学员生日
@property (nonatomic,strong) NSString *card_type; // 证件类型   1：身份证 2：护照
@property (nonatomic,strong) NSString *id_card;//证件号
@property (nonatomic,strong) NSString *sex;//学员性别    1:nan 2:nv
@property (nonatomic,strong) NSString *work_place;// 工作单位
@property (nonatomic,strong) NSString *sign_up_at; //报名日期  如：2020-01-01
@property (nonatomic,strong) NSString *stores_courses_class_id;//课程id
@property (nonatomic,strong) NSString *courses_name;//课程id
@property (nonatomic,strong) NSString *source;// 来源渠道
@property (nonatomic,strong) NSString *teacher_id;//教师id
@property (nonatomic,strong) NSString *teacher;//教师id
@property (nonatomic,strong) NSString *wechat;// 微信号
@property (nonatomic,strong) NSString *referees;//推荐人
@property (nonatomic,strong) NSString *emergency_name;//紧急联系人名称
@property (nonatomic,strong) NSString *emergency_phone;//紧急联系人电话
@property (nonatomic,strong) NSString *emergency_contact;//与紧急联系人的关系
@property (nonatomic,strong) NSString *remark;// 备注

@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *total_progress;
@property (nonatomic,strong) NSString *now_progress;
@property (nonatomic,strong) NSString *stores_coach_id;
@property (nonatomic,strong) NSString *coach_img;

@property (nonatomic,strong) NSString * account_id;
@property (nonatomic,strong) NSString *coupons_id;
@property (nonatomic,strong) NSString *coupons_name;
@property (nonatomic,strong) NSString *create_at;
@property (nonatomic,strong) NSMutableArray *images_list;
@property (nonatomic,strong) NSString *is_local;
@property (nonatomic,strong) NSString *is_star;
@property (nonatomic,strong) NSString *p_information;
@property (nonatomic,strong) NSString *specialty_desc;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *update_at;
@end


@interface ZOriganizationStudentListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationStudentListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end


#pragma mark - 教师管理
@interface ZOriganizationTeacherListModel : ZBaseModel
@property (nonatomic,strong) NSString *account_id;
@property (nonatomic,strong) NSString *c_level;
@property (nonatomic,strong) NSString *teacherID;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *nick_name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *teacher_name;

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL isEdit;
@end

@interface ZOriganizationTeacherListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationTeacherListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end

@interface ZOriganizationTeacherAddModel : ZBaseModel
@property (nonatomic,strong) NSString *account_id;
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *school;
@property (nonatomic,strong) NSString *teacherID;
@property (nonatomic,strong) NSString *real_name;
@property (nonatomic,strong) id image;
@property (nonatomic,strong) NSString *nick_name;
@property (nonatomic,strong) NSString *sex;// 1：男 2：女
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *id_card;
@property (nonatomic,strong) id cardImageUp;
@property (nonatomic,strong) id cardImageDown;

@property (nonatomic,strong) NSString *c_level;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSMutableArray *class_ids_net;
@property (nonatomic,strong) NSMutableArray *class_ids;//{“courses_id”: “课程id”,”price”:”课程价格”}]
@property (nonatomic,strong) NSMutableArray *skills;
@property (nonatomic,strong) NSMutableArray *lessonList;

@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSArray *card_image;

@property (nonatomic,strong) NSMutableArray *images_list;
@property (nonatomic,strong) NSMutableArray *images_list_net;
@end


#pragma mark - 卡片管理
@interface ZOriganizationCardListModel : ZBaseModel
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *couponsID;
@property (nonatomic,strong) NSString *limit_end;
@property (nonatomic,strong) NSString *limit_start;
@property (nonatomic,strong) NSString *min_amount;
@property (nonatomic,strong) NSString *status;//0:全部 1：开启 2：关闭
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *unused_nums;
@property (nonatomic,strong) NSString *nums;

@end


@interface ZOriganizationCardAddModel : ZBaseModel
@property (nonatomic,strong) NSString *stores_id;
@property (nonatomic,strong) NSString *type;// 1: 通用型，2：指定课程
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *min_amount;
@property (nonatomic,strong) NSString *limit_start;
@property (nonatomic,strong) NSString *limit_end;
@property (nonatomic,strong) NSString *nums;
@property (nonatomic,strong) NSString *limit;
@property (nonatomic,strong) NSString *status;   // 1：开启 2：关闭
@property (nonatomic,strong) NSString *course_id;
@property (nonatomic,strong) NSArray *lessonList;

@property (nonatomic,assign) BOOL isAll;
@end


@interface ZOriganizationCardListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationCardListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end



#pragma mark - 图片管理
@interface ZOriganizationPhotoListModel : ZBaseModel
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image;
@end


@interface ZOriganizationPhotoListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationPhotoListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end


@interface ZOriganizationPhotoTypeListModel : ZBaseModel
@property (nonatomic,strong) NSString *imageID;
@property (nonatomic,strong) NSString *images_url;
@end

@interface ZOriganizationPhotoTypeListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationPhotoTypeListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end


