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
@property (nonatomic,copy) NSString *rePwd;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *ckey;
@property (nonatomic,copy) NSString *messageCode;
@end


@interface ZImageCodeBackModel : NSObject
@property (nonatomic,copy) NSString *sensitive;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *ckey;
@end

@interface ZLoginUserBackModel : NSObject
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *code_id;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *nick_name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *notice_msg;
@property (nonatomic,strong) NSString *type;
@end



@interface ZUserRolesListModel : NSObject
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *has_pwd;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *nick_name;
@end


@interface ZUserRolesListNetModel : ZBaseNetworkBackModel
@property (nonatomic,strong) NSArray <ZUserRolesListModel *>*list;
@end
