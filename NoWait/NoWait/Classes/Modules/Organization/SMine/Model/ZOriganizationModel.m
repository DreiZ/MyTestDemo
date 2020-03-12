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

@implementation ZOriganizationLessonOrderListModel

@end

@implementation ZOriganizationAddClassModel 
- (instancetype)init {
    self = [super init];
    if (self) {
        _lessonTimeArr = @[].mutableCopy;
        _lessonOrderArr = @[].mutableCopy;
        _className = @"";
    }
    return self;
}
@end

@implementation ZOriganizationLessonOrderListNetModel

@end


@implementation ZOriganizationClassListModel

@end

@implementation ZOriganizationClassListNetModel

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
    return @{@"studentID" : @"id"};
}
@end


@implementation ZOriganizationStudentListNetModel
@end
