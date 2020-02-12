//
//  ZUserHelper.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUser.h"

typedef void (^loginUserResultBlock)(BOOL isSuccess, NSString *message);

@interface ZUserHelper : NSObject

@property (nonatomic, strong) ZUser *user;

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


//更新用户信息
- (void)updateUserInfoWithCompleteBlock:(void(^)(BOOL))completeBlock;

//登录
- (void)loginWithParams:(NSDictionary *)params block:(loginUserResultBlock)block;
@end

