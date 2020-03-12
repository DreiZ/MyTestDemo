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
NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationModel : ZBaseModel

@end

@interface ZOriganizationLessonOrderListModel : ZBaseModel
@property (nonatomic,copy) NSString *lessonName;
@property (nonatomic,copy) NSString *lessonDes;
@property (nonatomic,copy) NSString *lessonNum;
@property (nonatomic,copy) NSString *lessonHadNum;
@property (nonatomic,copy) NSString *teacherName;
@property (nonatomic,copy) NSString *lessonImage;
@property (nonatomic,copy) NSString *validity;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL isEdit;
@end

@interface ZOriganizationAddClassModel : NSObject
@property (nonatomic,strong) NSMutableArray *lessonTimeArr;
@property (nonatomic,strong) NSMutableArray *lessonOrderArr;
@property (nonatomic,strong) NSString *className;
@property (nonatomic,assign) NSString *singleTime;
@end

@interface ZOriganizationLessonOrderListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationLessonOrderListModel *>*list;
@property (nonatomic,copy) NSString *pages;
@end

#pragma mark - 班级管理
@interface ZOriganizationClassListModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *isu;
@property (nonatomic,strong) NSString *className;
@property (nonatomic,strong) NSString *classDes;
@property (nonatomic,strong) NSString *teacherName;
@property (nonatomic,strong) NSString *teacherImage;
@property (nonatomic,strong) NSString *num;
@end

@interface ZOriganizationClassListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationClassListModel *>*list;
@property (nonatomic,copy) NSString *pages;
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
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *teacher_name;
@property (nonatomic,strong) NSString *courses_name;
@property (nonatomic,strong) NSString *total_progress;
@property (nonatomic,strong) NSString *now_progress;
@property (nonatomic,strong) NSString *stores_coach_id;
@property (nonatomic,strong) NSString *stores_courses_class_id;
@end

@interface ZOriganizationStudentAddModel : ZBaseModel
@property (nonatomic,strong) NSString *studentID;
@property (nonatomic,strong) NSString *stores_id; //门店id
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
@property (nonatomic,strong) NSString *stores_courses_class;//课程id
@property (nonatomic,strong) NSString *source;// 来源渠道
@property (nonatomic,strong) NSString *teacher_id;//教师id
@property (nonatomic,strong) NSString *teacher;//教师id
@property (nonatomic,strong) NSString *wechat;// 微信号
@property (nonatomic,strong) NSString *referees;//推荐人
@property (nonatomic,strong) NSString *emergency_name;//紧急联系人名称
@property (nonatomic,strong) NSString *emergency_phone;//紧急联系人电话
@property (nonatomic,strong) NSString *emergency_contact;//与紧急联系人的关系
@property (nonatomic,strong) NSString *remark;// 备注  
@end


@interface ZOriganizationStudentListNetModel : ZBaseNetworkBackDataModel
@property (nonatomic,strong) NSArray <ZOriganizationStudentListModel *>*list;
@property (nonatomic,copy) NSString *total;
@end

NS_ASSUME_NONNULL_END
