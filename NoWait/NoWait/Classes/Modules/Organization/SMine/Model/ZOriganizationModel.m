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

@implementation ZOriganizationSchooleListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"schoolID" : @"id"};
}
@end

@implementation ZOriganizationSchoolListNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZOriganizationSchooleListModel"
             };
}

@end
