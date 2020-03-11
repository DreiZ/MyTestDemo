//
//  ZBaseNetworkBackModel.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/21.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZBaseNetworkBackModel.h"

@implementation ZBaseNetworkBannerModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"bannerId" : @"id"};
}
@end

@implementation ZBaseNetworkBackDataModel

@end

@implementation ZAgreementNetModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"des" : @"description"};
}
@end

@implementation ZShareNetModel

@end

@implementation ZBaseNetworkImageBackModel

@end

@implementation ZBaseNetworkBackModel

@end
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{
//             @"friendArr" : @"ZIMUserFriendModel",
//             @"group" : @"ZIMUserGroupModel",
//             };
//}
//
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{@"friendArr" : @"friend"};
//}
