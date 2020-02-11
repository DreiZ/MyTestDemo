//
//  ZLoginModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRegisterModel : NSObject
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *pwd;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *messageCode;
@property (nonatomic,copy) NSString *ckey;
@end

@interface ZLoginModel : NSObject
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *pwd;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *ckey;
@end


@interface ZImageCodeBackModel : NSObject
@property (nonatomic,copy) NSString *sensitive;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *ckey;
@end

@interface ZLoginUserBackModel : NSObject
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *is_new;
@property (nonatomic,strong) NSString *nick_name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *type;
@end

