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
    }else{
        DLog(@"登录数据存库成功%@ ",user.userCodeID);
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setObject:user.userCodeID forKey:@"userCodeID"];
}

- (void)loginOutUser:(ZUser *)user
{
    _user = user;
    
    [self deleteUserStore:user.userCodeID];
    [ZUserHelper sharedHelper].user = nil;
    [ZUserHelper sharedHelper].school = nil;
    [ZUserHelper sharedHelper].stores = nil;
    [[ZDBManager sharedInstance] loginout];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userCodeID"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLoginStateChange object:nil];
//    [self logoutWithParams:@{} block:^(BOOL isSuccess, NSString *message) {
//        if (isSuccess) {
//            [TLUIUtility showSuccessHint:message];
//            [[ZLaunchManager sharedInstance] showLoginVC];
//        }else{
//            [TLUIUtility showErrorHint:message];
//        }
//    }];
}

- (void)deleteUserStore:(NSString *)userCodeID {
    ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
    if (![userStore deleteUsersByUid:userCodeID]) {
        DLog(@"登录数据存库失败");
    }
}


- (void)switchUser:(ZUser *)user {
    _user = user;
    [ZUserHelper sharedHelper].school = nil;
    [ZUserHelper sharedHelper].stores = nil;
    [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setObject:user.userCodeID forKey:@"userCodeID"];
}

- (ZUser *)user
{
    if (!_user) {
        if (self.user_id.length > 0) {
            ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
            _user = [userStore userByID:self.uuid];
            if (!_user) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userID"];
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userCodeID"];
            }
        }
    }
    return _user;
}

- (NSArray *)userList {
    ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
    NSArray *userList = [userStore userData];
    if (userList) {
        return userList;
    }
    return @[];
}

- (NSString *)user_id
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    return userID;
}


- (NSString *)uuid
{
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userCodeID"];
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

- (void)updateToken:(BOOL)isOpen {
    if ([ZUserHelper sharedHelper].push_token) {
        [[ZUserHelper sharedHelper] deviceTokenWithParams:@{@"device_token":SafeStr([ZUserHelper sharedHelper].push_token),@"status":isOpen?@"1":@"2"} block:^(BOOL isSuccess, NSString *message) {
            
        }];
    }
}

#pragma mark 更新用户数据
- (void)updateUserInfoWithCompleteBlock:(void(^)(BOOL))completeBlock {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_account_v1_refresh params:@{} completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            
            ZLoginUserBackModel *userModel = [ZLoginUserBackModel mj_objectWithKeyValues:dataModel.data];
            
            ZUser *user = [ZUserHelper sharedHelper].user;
            user.token = userModel.token? userModel.token:@"";
            user.avatar = userModel.image? userModel.image:@"";
            user.nikeName = userModel.nick_name? userModel.nick_name:@"";
            [[ZUserHelper sharedHelper] setUser:user];
            
            [[ZUserHelper sharedHelper] updateToken:YES];
            completeBlock(YES);
        }else{
            completeBlock(NO);
        }
    }];
}

//登录
- (void)loginWithParams:(NSDictionary *)params block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_account_v1_login params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            
            ZLoginUserBackModel *userModel = [ZLoginUserBackModel mj_objectWithKeyValues:dataModel.data];
            
            if (userModel && userModel.notice_msg && userModel.notice_msg.length > 0) {
                [ZAlertView setAlertWithTitle:userModel.notice_msg btnTitle:@"取消" handlerBlock:^(NSInteger index) {
                    
                }];
            }
            
            [ZUserHelper sharedHelper].school = nil;
            [ZUserHelper sharedHelper].stores = nil;
            ZUser *user = [[ZUser alloc] init];
            user.userID = userModel.userID? userModel.userID:@"";
            user.userCodeID = userModel.code_id? userModel.code_id:@"888888";
            user.avatar = userModel.image? userModel.image:@"";
            user.nikeName = userModel.nick_name? userModel.nick_name:@"";
            user.phone = userModel.phone? userModel.phone:@"";
            user.type = userModel.type? userModel.type:@"1";
            user.token = userModel.token ? userModel.token:@"";
            [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"userID"];
            [[NSUserDefaults standardUserDefaults] setObject:user.userCodeID forKey:@"userCodeID"];
            [[ZUserHelper sharedHelper] setUser:user];
            [[ZUserHelper sharedHelper] updateToken:YES];
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


//登录
- (void)loginPwdWithParams:(NSDictionary *)params block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_account_v1_loginPwd params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            
            ZLoginUserBackModel *userModel = [ZLoginUserBackModel mj_objectWithKeyValues:dataModel.data];
            
            if (userModel && userModel.notice_msg && userModel.notice_msg.length > 0) {
                [ZAlertView setAlertWithTitle:userModel.notice_msg btnTitle:@"取消" handlerBlock:^(NSInteger index) {
                    
                }];
            }
            [ZUserHelper sharedHelper].school = nil;
            [ZUserHelper sharedHelper].stores = nil;
            
            ZUser *user = [[ZUser alloc] init];
            user.userID = userModel.userID? userModel.userID:@"";
            user.userCodeID = userModel.code_id? userModel.code_id:@"888888";
            user.avatar = userModel.image? userModel.image:@"";
            user.nikeName = userModel.nick_name? userModel.nick_name:@"";
            user.phone = userModel.phone? userModel.phone:@"";
            user.type = userModel.type? userModel.type:@"1";
            user.token = userModel.token ? userModel.token:@"";
            [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"userID"];
            [[NSUserDefaults standardUserDefaults] setObject:user.userCodeID forKey:@"userCodeID"];
            [[ZUserHelper sharedHelper] setUser:user];
            [[ZUserHelper sharedHelper] updateToken:YES];
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


//device token
- (void)deviceTokenWithParams:(NSDictionary *)params block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_message_v1_add_device_token params:params completionHandler:^(id data, NSError *error) {
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


//device token
- (void)getDeviceTokenWithParams:(NSDictionary *)params block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_message_v1_get_device_token_info params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0) {
            if (dataModel.data) {
                ZUserTokenModel *model = [ZUserTokenModel mj_objectWithKeyValues:dataModel.data];
                block(YES,model.status);
            }else {
                block(NO,dataModel.message);
            }
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
