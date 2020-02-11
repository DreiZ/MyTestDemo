//
//  ZLoginModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLoginModel.h"

@implementation ZRegisterModel

@end

@implementation ZLoginModel

@end


@implementation ZImageCodeBackModel

@end

@implementation ZLoginUserBackModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userID" : @"id"};
}
@end
