//
//  ZCircleReleaseModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseModel.h"

@implementation ZCircleReleaseSchoolModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"store_id" : @"id",
    };
}
@end

@implementation ZCircleReleaseSchoolNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZCircleReleaseSchoolModel"
             };
}
@end

@implementation ZCircleReleaseTagModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"tag_id" : @"id",
    };
}
@end

@implementation ZCircleReleaseTagNetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"ZCircleReleaseTagModel"
             };
}
@end

@implementation ZCircleReleaseModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _tags = @[].mutableCopy;
        _imageArr = @[].mutableCopy;
    }
    return self;
}
@end
