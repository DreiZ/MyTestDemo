//
//  ZStudentMainModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainModel.h"


@implementation ZMainClassifyTwoModel

@end

@implementation ZMainClassifyOneModel

@end

@implementation ZMainClassifyModel


@end

@implementation ZStudentPhotoWallItemModel


@end

@implementation ZStudentEnteryItemModel


@end

@implementation ZStudentBannerModel


@end

@implementation ZStudentOrganizationListModel

@end

@implementation ZStudentLessonListModel


@end


@implementation ZComplaintModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"complaintId" : @"id",
    };
}
@end

@implementation ZComplaintNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZComplaintModel"
             };
}
@end

@implementation ZStudentMainModel

@end
