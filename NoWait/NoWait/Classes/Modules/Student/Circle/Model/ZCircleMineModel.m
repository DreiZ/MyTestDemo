//
//  ZCircleMineModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineModel.h"

@implementation ZCircleDynamicLessonModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"lesson_id" : @"id",
    };
}
@end

@implementation ZCircleDynamicEvaModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"eva_id" : @"id",
    };
}
@end

@implementation ZCircleDynamicEvaNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZCircleDynamicEvaModel"
             };
}
@end

@implementation ZCircleMinePersonModel

@end

@implementation ZCircleMinePersonNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZCircleMinePersonModel"
             };
}
@end


@implementation ZCircleMineDynamicPhotoModel

@end

@implementation ZCircleMineDynamicModel

@end

@implementation ZCircleMineDynamicNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZCircleMineDynamicModel",
             @"course" : @"ZCircleDynamicLessonModel"
             };
}
@end

@implementation ZCircleDynamicInfo

@end

@implementation ZCircleMineModel

@end

@implementation ZCircleMineDynamicLikeModel

@end


@implementation ZCircleMineDynamicLikeNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZCircleMineDynamicLikeModel",
             };
}
@end

@implementation ZCircleMineDynamicEvaModel
@end


@implementation ZCircleMineDynamicEvaNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZCircleMineDynamicEvaModel",
             };
}
@end
