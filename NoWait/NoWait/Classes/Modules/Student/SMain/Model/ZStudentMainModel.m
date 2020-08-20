//
//  ZStudentMainModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainModel.h"

@implementation ZMainClassifyOneModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"classify_id" : @"id",
             @"name" : @"title",
             @"imageName" : @"image",
             @"secondary" : @"children",
    };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"secondary" : @"ZMainClassifyOneModel"
             };
}
@end

@implementation ZMainClassifyNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZMainClassifyOneModel"
             };
}
@end

@implementation ZStudentPhotoWallItemModel


@end

@implementation ZStudentEnteryItemModel


@end

@implementation ZStudentBannerModel

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

@implementation ZRegionLatLngModel

@end

@implementation ZRegionDataModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"re_id" : @"id",
             @"num" :@"count"
    };
}
@end


@implementation ZRegionNetModel 
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"region" : @"ZRegionDataModel",
             @"schools" : @"ZRegionDataModel"
             };
}
@end

@implementation ZStudentMainModel

@end
