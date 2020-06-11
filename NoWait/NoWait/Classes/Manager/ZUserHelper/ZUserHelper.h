//
//  ZUserHelper.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUser.h"
#import "ZOriganizationModel.h"

typedef void (^loginUserResultBlock)(BOOL isSuccess, NSString *message);
typedef void (^backResultBlock)(BOOL isSuccess, NSDictionary *data);

@interface ZUserHelper : NSObject

@property (nonatomic, strong) ZUser *user;
@property (nonatomic, strong) ZOriganizationSchoolListModel *school;
@property (nonatomic, strong) ZOriganizationDetailModel *stores;


@property (nonatomic, strong, readonly) NSString *user_id;

@property (nonatomic, strong, readonly) NSString *uuid;

@property (nonatomic, strong) NSString *push_token;

@property (nonatomic, assign, readonly) BOOL isLogin;

+ (ZUserHelper *)sharedHelper;
// 所有用户
- (NSArray *)userList;
//保存用户信息
- (void)setUser:(ZUser *)user;

//登出
- (void)loginOutUser:(ZUser *)user;

//切换用户
- (void)switchUser:(ZUser *)user;

- (void)checkLogin:(void (^)(void))login;

- (void)updateToken:(BOOL)isOpen;

- (void)deleteUserStore:(NSString *)userCodeID;

//更新用户信息
- (void)updateUserInfoWithCompleteBlock:(void(^)(BOOL))completeBlock;

//登录
- (void)loginWithParams:(NSDictionary *)params block:(loginUserResultBlock)block;

//登录
- (void)loginPwdWithParams:(NSDictionary *)params block:(loginUserResultBlock)block;

//device token
- (void)deviceTokenWithParams:(NSDictionary *)params block:(loginUserResultBlock)block;


- (void)updateVersionWithParams:(NSDictionary *)params block:(backResultBlock)block;

- (void)getDeviceTokenWithParams:(NSDictionary *)params block:(loginUserResultBlock)block;
@end

