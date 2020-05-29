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

@implementation ZOriganizationDetailModel

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

        _category = @[].mutableCopy;
        _months = @[].mutableCopy;
        _stores_info = @[].mutableCopy;
        _week_days = @[].mutableCopy;
        _merchants_stores_tags = @[].mutableCopy;
    }
    return self;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"schoolID" : @"id",
             @"merchants_stores_tags" : @"merchant_stores_tags",
    };
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"category" : @"ZMainClassifyOneModel"
             };
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

@implementation ZOriganizationStudentCodeAddModel

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
        _images_list = @[].mutableCopy;
    }
    return self;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"des" : @"description",
             @"teacherID" : @"id"
    };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"class_ids" : @"ZOriganizationLessonListModel",
              @"comment_list" : @"ZOrderEvaListModel"
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



@implementation ZOriganizationPhotoListModel

@end

@implementation ZOriganizationPhotoListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZOriganizationPhotoListModel"
             };
}
@end



@implementation ZOriganizationPhotoTypeListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"imageID" : @"id"};
}
@end

@implementation ZOriganizationPhotoTypeListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZOriganizationPhotoTypeListModel"
             };
}
@end

@implementation ZStoresCourse
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"course_id" : @"id"};
}

@end


@implementation ZStoresListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"coupons" : @"ZOriganizationCardListModel",
              @"course" : @"ZStoresCourse"
             };
}
@end

@implementation ZStoresListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZStoresListModel"
             };
}
@end

@implementation ZAdverListContentModel

- (NSString *)tranModelToJSON {
    NSMutableDictionary *dict = @{}.mutableCopy;
    if (ValidStr(self.course)) {
        [dict setObject:self.course forKey:@"course"];
    }
    
    if (ValidStr(self.stores)) {
        [dict setObject:self.stores forKey:@"stores"];
    }

    if (ValidStr(self.url)) {
        [dict setObject:self.url forKey:@"url"];
    }
    
    if (ValidStr(self.fix_html)) {
        [dict setObject:self.fix_html forKey:@"fix_html"];
    }
    
    if (ValidStr(self.fix)) {
        [dict setObject:self.fix forKey:@"fix"];
    }
    
    return getJSONStr(dict);
}

+ (ZAdverListContentModel *)getModelFromStr:(NSString *)jsonStr {
    ZAdverListContentModel *model = [[ZAdverListContentModel alloc] init];
    NSDictionary *dict = [jsonStr zz_JSONValue];
    if (ValidDict(dict)) {
        if ([dict objectForKey:@"course"]) {
            model.course = dict[@"course"];
        }
        
        if ([dict objectForKey:@"stores"]) {
            model.stores = dict[@"stores"];
        }
        
        if ([dict objectForKey:@"url"]) {
            model.url = dict[@"url"];
        }
        
        if ([dict objectForKey:@"fix_html"]) {
            model.fix_html = dict[@"fix_html"];
        }
        
        if ([dict objectForKey:@"fix"]) {
            model.fix = dict[@"fix"];
        }
    }
    return model;
}
@end

@implementation ZAdverListModel : ZBaseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ad_id" : @"id"};
}

@end

@implementation ZAdverListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"shuffling" : @"ZAdverListModel",
              @"placeholder" : @"ZAdverListModel",
              @"category" : @"ZMainClassifyOneModel"
             };
}
@end

@implementation ZImagesModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"image_count" : @"count"};
}
@end



@implementation ZStoresDetailModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"coupons_list" : @"ZOriganizationCardListModel",
              @"images_list" : @"ZImagesModel",
              @"teacher_list" : @"ZOriganizationTeacherListModel",
              @"images_list" : @"ZImagesModel",
              @"courses_list" : @"ZOriganizationLessonListModel",
              @"star_students" : @"ZOriganizationTeacherListModel",
              
             };
}
@end


@implementation ZStoresStatisticalModel

@end


@implementation ZStoresAccountListModel

@end

@implementation ZStoresAccountModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list_stores" : @"ZStoresAccountListModel",
             };
}
@end

@implementation ZStoresAccountDetaliListLogModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"bill_id" : @"id"};
}
@end

@implementation ZStoresAccountDetaliListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"lid" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"logs" : @"ZStoresAccountDetaliListLogModel",
             };
}

@end


@implementation ZStoresAccountDetaliListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZStoresAccountDetaliListModel",
             };
}
@end


@implementation ZStoresAccountBillListModel

@end


@implementation ZStoresAccountBillListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZStoresAccountBillListModel",
             };
}
@end


@implementation ZOriganizationSignListStudentModel

@end

@implementation ZOriganizationSignListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZOriganizationSignListStudentModel",
             };
}

@end

@implementation ZOriganizationSignListImageNetModel


@end

@implementation ZOriganizationSignListNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZOriganizationSignListModel",
              @"image" : @"ZOriganizationSignListImageNetModel",
             };
}

@end

@implementation ZTeacherSignNetModel

@end
