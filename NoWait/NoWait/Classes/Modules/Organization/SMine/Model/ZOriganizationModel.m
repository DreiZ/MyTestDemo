//
//  ZOriganizationModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationModel.h"

@implementation ZOriganizationModel

@end


@implementation ZOriganizationAddClassModel 
- (instancetype)init {
    self = [super init];
    if (self) {
        _lessonTimeArr = @[].mutableCopy;
        _lessonOrderArr = @[];
        _class_Name = @"";
    }
    return self;
}
@end


@implementation ZOriganizationClassListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"classID" : @"id"};
}
@end

@implementation ZOriganizationClassListNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZOriganizationClassListModel"
             };
}

@end

@implementation ZOriganizationClassDetailModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _classes_dateArr = @[].mutableCopy;
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"classID" : @"id"};
}
@end

@implementation ZOriganizationSchoolListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"schoolID" : @"id"};
}
@end

@implementation ZOriganizationSchoolListNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZOriganizationSchoolListModel"
             };
}
@end

@implementation ZOriganizationSchoolDetailModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _brief_address = @"";
        _city = @"";
        _county = @"";
        _province = @"";
        _address = @"";
        _hash_update_address = @"";
        _hash_update_name = @"";
        _hash_update_store_type_id = @"";
        _schoolID = @"";
        _image = @"";
        _landmark = @"";
        _latitude = @"";
        _longitude = @"";
        _merchants_id = @"";
        _name = @"";
        _opend_end = @"";
        _opend_start = @"";
        _phone = @"";
        _place = @"";
        _regional_id = @"";
        _status = @"";
        _store_type_id = @"";

        _months = @[].mutableCopy;
        _stores_info = @[].mutableCopy;
        _week_days = @[].mutableCopy;
        _merchant_stores_tags = @[].mutableCopy;
    }
    return self;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"schoolID" : @"id"};
}
@end

@implementation ZOriganizationStudentListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"studentID" : @"id"};
}
@end

@implementation ZOriganizationStudentAddModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"studentID" : @"id",
             @"teacher" : @"teacher_name"
    };
}
@end


@implementation ZOriganizationStudentListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"ZOriganizationStudentListModel"
             };
}
@end


#pragma mark - 教师管理
@implementation ZOriganizationTeacherListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"teacherID" : @"id"};
}
@end

@implementation ZOriganizationTeacherListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZOriganizationTeacherListModel"
             };
}
@end


@implementation ZOriganizationTeacherAddModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _stores_id = @"";
        _real_name = @"";
        _nick_name = @"";
        _sex = @"";// 1：男 2：女
        _phone = @"";
        _id_card = @"";
        _c_level = @"";
        _position = @"";
        _class_ids_net = @[].mutableCopy;
        _class_ids = @[].mutableCopy;//{“courses_id”: “课程id”,”price”:”课程价格”}]
        _skills = @[].mutableCopy;
        _lessonList = @[].mutableCopy;
        _des = @"";
        _images_list = @[].mutableCopy;;
        _images_list_net = @[].mutableCopy;
    }
    return self;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"des" : @"description",
             @"teacherID" : @"id"
    };
}

@end

#pragma mark - 卡片管理
@implementation ZOriganizationCardListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"couponsID" : @"id"};
}
@end


@implementation ZOriganizationCardAddModel

@end


@implementation ZOriganizationCardListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZOriganizationCardListModel"
             };
}
@end
