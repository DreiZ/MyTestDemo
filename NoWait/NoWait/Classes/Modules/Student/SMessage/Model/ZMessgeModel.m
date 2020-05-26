//
//  ZMessgeModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessgeModel.h"


@implementation ZMessageAccountModel

@end


@implementation ZMessageExtraModel

@end

@implementation ZMessageInfoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"account" : @"ZMessageAccountModel"};
}
@end

@implementation ZMessgeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"message_id" : @"id",
    };
}
@end


@implementation ZMessageNetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"ZMessgeModel"};
}
@end
