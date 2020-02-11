//
//  ZUser.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZUser.h"

@implementation ZUser
- (id)init
{
    if (self = [super init]) {
        self.birthday = @"";
        self.userID = @"";
        self.avatar = @"";
        self.is_new = @"";
        self.nikeName = @"";
        self.phone = @"";
        self.sex = @"";
        self.status = @"";
        self.type = @"";
        self.token = @"";
        
        [ZUser mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"userID":@"id"};
        }];
    }
    return self;
}

@end
