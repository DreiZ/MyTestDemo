//
//  ZUser.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZUser : NSObject
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *userCodeID;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *is_new;
@property (nonatomic,strong) NSString *nikeName;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *type;//（1：学员 2：老师 3：校长 4：机构管理）
@property (nonatomic,strong) NSString *token;

@property (nonatomic,strong) NSDictionary *content;
@end
