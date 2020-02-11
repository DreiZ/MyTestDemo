//
//  ZUserHelper.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "ZUserHelper.h"
#import "ZDBUserStore.h"
#import "ZNetworkingManager.h"
#import "ZLoginModel.h"
#import "ZDBManager.h"

#import "ZLaunchManager.h"
#import "ZAlertView.h"
#import "ZBaseNetworkBackModel.h"


@implementation ZUserHelper
@synthesize user = _user;

+ (ZUserHelper *)sharedHelper
{
    static ZUserHelper *helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[ZUserHelper alloc] init];
    });
    return helper;
}

- (void)setUser:(ZUser *)user
{
    _user = user;
    ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
    if (![userStore updateUser:user]) {
        DLog(@"登录数据存库失败");
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"userID"];
}

- (void)loginOutUser:(ZUser *)user
{
    _user = user;
    ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
    if (![userStore deleteUsersByUid:user.userID]) {
        DLog(@"登录数据存库失败");
    }
    [ZUserHelper sharedHelper].user = nil;
    [[ZDBManager sharedInstance] loginout];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userID"];
    
    [self logoutWithParams:@{} block:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [[ZLaunchManager sharedInstance] showLoginVC];
        }else{
            [TLUIUtility showErrorHint:message];
        }
    }];
}


- (ZUser *)user
{
    if (!_user) {
        if (self.user_id.length > 0) {
            ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
            _user = [userStore userByID:self.user_id];
            if (!_user) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userID"];
            }
        }
    }
    return _user;
}

- (NSString *)user_id
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    return userID;
}


- (NSString *)uuid
{
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    return uuid;
}


- (BOOL)isLogin
{
    return self.user_id.length > 0;
}

- (void)checkLogin:(void (^)(void))login {
    if (!self.isLogin) {
        [ZAlertView setAlertWithTitle:@"你所在的用户组（游客）无法进行此操作，去登录获取更多功能？" leftBtnTitle:@"取消" rightBtnTitle:@"登录" handlerBlock:^(NSInteger index) {
            if(index == 1){
                [[ZLaunchManager sharedInstance] showLoginVC];
            }
        }];
    }else{
        if (login) {
            login();
        }
    }
}

#pragma mark 更新用户数据
- (void)updateUserInfoWithCompleteBlock:(void(^)(BOOL))completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_account_v1_refresh params:@{} completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && dataModel.data && [dataModel.data isKindOfClass:[NSDictionary class]]) {
            
            ZLoginUserBackModel *userModel = [ZLoginUserBackModel mj_objectWithKeyValues:dataModel.data];
            
            ZUser *user = [[ZUser alloc] init];
            user.birthday = userModel.birthday? userModel.birthday:@"";
            user.userID = userModel.userID? userModel.userID:@"";
            user.avatar = userModel.image? userModel.image:@"";
            user.is_new = userModel.is_new? userModel.is_new:@"";
            user.nikeName = userModel.nick_name? userModel.nick_name:@"";
            user.phone = userModel.phone? userModel.phone:@"";
            user.sex = userModel.sex? userModel.sex:@"";
            user.status = userModel.status? userModel.status:@"";
            user.type = userModel.type? userModel.type:@"";
            [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"userID"];
            [[ZUserHelper sharedHelper] setUser:user];
        }
    }];
}

//登录
- (void)loginWithParams:(NSDictionary *)params block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_account_v1_login params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && dataModel.data && [dataModel.data isKindOfClass:[NSDictionary class]]) {
            
            ZLoginUserBackModel *userModel = [ZLoginUserBackModel mj_objectWithKeyValues:dataModel.data];
            
            ZUser *user = [[ZUser alloc] init];
            user.birthday = userModel.birthday? userModel.birthday:@"";
            user.userID = userModel.userID? userModel.userID:@"";
            user.avatar = userModel.image? userModel.image:@"";
            user.is_new = userModel.is_new? userModel.is_new:@"";
            user.nikeName = userModel.nick_name? userModel.nick_name:@"";
            user.phone = userModel.phone? userModel.phone:@"";
            user.sex = userModel.sex? userModel.sex:@"";
            user.status = userModel.status? userModel.status:@"";
            user.type = userModel.type? userModel.type:@"";
            [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"userID"];
            [[ZUserHelper sharedHelper] setUser:user];
            block(YES,dataModel.message);
        }else {
            if ([ZPublicTool getNetworkStatus]) {
                block(NO, dataModel.message);
            }else{
                block(NO, @"天呐，您的网络好像出了点小问题...");
            }
        }
    }];
}


//登出
- (void)logoutWithParams:(NSDictionary *)params block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_account_v1_logout params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0) {
            block(YES,dataModel.message);
        }else {
            if ([ZPublicTool getNetworkStatus]) {
                block(NO, dataModel.message);
            }else{
                block(NO, @"天呐，您的网络好像出了点小问题...");
            }
        }
    }];
}
@end
