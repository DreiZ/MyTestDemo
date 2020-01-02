//
//  ZUserHelper.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "ZUserHelper.h"
//#import "ZDBUserStore.h"
//#import "ZNetworking.h"
//#import "ZLoginModel.h"
//#import "ZDBManager.h"
//
//#import "ZIMServerManager.h"
//#import "ZMessageSocketManager.h"
//#import "ZMessageManager.h"
//#import "ZLaunchManager.h"
//#import "ZAlertView.h"


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
//
//- (void)setUser:(ZUser *)user
//{
//    _user = user;
//    ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
//    if (![userStore updateUser:user]) {
//        DLog(@"登录数据存库失败");
//    }
//    
//    [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"loginUserID"];
//    [[NSUserDefaults standardUserDefaults] setObject:user.client_uid forKey:@"loginClientID"];
//    [[NSUserDefaults standardUserDefaults] setObject:user.uuid forKey:@"uuid"];
//}
//
//- (void)loginOutUser:(ZUser *)user
//{
//    _user = user;
//    ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
//    if (![userStore deleteUsersByUid:user.userID]) {
//        DLog(@"登录数据存库失败");
//    }
//    [ZUserHelper sharedHelper].user = nil;
//    [[ZDBManager sharedInstance] loginout];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginUserID"];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginClientID"];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"uuid"];
//    [[ZMessageSocketManager shareInstance] executeDiscounnectServer];
//    [[ZMessageManager sharedInstance] logout];
//}
//
//
//- (ZUser *)user
//{
//    if (!_user) {
//        if (self.user_id.length > 0) {
//            ZDBUserStore *userStore = [[ZDBUserStore alloc] init];
//            _user = [userStore userByID:self.user_id];
//            _user.detailInfo.momentsWallURL = @"http://pic1.win4000.com/wallpaper/c/5791e49b37a5c.jpg";
//            if (!_user) {
//                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginUserID"];
//                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginClientID"];
//                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"uuid"];
//            }
//        }
//    }
//    return _user;
//}
//
//- (NSString *)user_id
//{
//    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginUserID"];
//    return userID;
//}
//
//- (NSString *)client_id
//{
//    NSString *client_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginClientID"];
//    return client_id;
//}
//
//- (NSString *)uuid
//{
//    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
//    return uuid;
//}
//
//- (BOOL)isLogin
//{
//    return self.user_id.length > 0;
//}
//
//- (void)checkLogin:(void (^)(void))login {
//    if (!self.isLogin) {
//        [ZAlertView setAlertWithTitle:@"你所在的用户组（游客）无法进行此操作，去登录获取更多功能？" leftBtnTitle:@"取消" rightBtnTitle:@"登录" handlerBlock:^(NSInteger index) {
//            if(index == 1){
//                [[ZLaunchManager sharedInstance] showLoginVC];
//            }
//        }];
//    }else{
//        if (login) {
//            login();
//        }
//    }
//}
//
//#pragma mark 更新用户数据
//- (void)updateUserInfoWithCompleteBlock:(void(^)(BOOL))completeBlock {
//    [ZNetworking postServerType:ZServerTypeApi url:URL_V1_userData_getUserInfo params:@{} completionHandler:^(id data, NSError * error) {
//        DLog(@"updateUserInfo return %@", data);
//        if (data) {
//            ZUserInfoBackModel *infoModel = [ZUserInfoBackModel mj_objectWithKeyValues:data];
//            if (infoModel.user_info ) {
//                [ZUserHelper sharedHelper].user.username = infoModel.user_info.username;
//                [ZUserHelper sharedHelper].user.birth = infoModel.user_info.birth;
//                [ZUserHelper sharedHelper].user.height = infoModel.user_info.stature;
//                [ZUserHelper sharedHelper].user.gender = infoModel.user_info.gender;
////                [ZUserHelper sharedHelper].user.weight = infoModel.user_info.weight;
//                [ZUserHelper sharedHelper].user.avatarURL = infoModel.user_info.avatar;
//                [kNotificationCenter postNotificationName:KNotificationUserRefreshData object:nil];
//            }
//            
//            if ([infoModel.code integerValue] == 0) {
//                completeBlock(YES);
//                return ;
//            }else{
//                completeBlock(NO);
//                return;
//            }
//        }
//        completeBlock(YES);
//    }];
//}
//
////登录
//- (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(loginUserResultBlock)block {
//    NSMutableDictionary *params = @{@"phone":username, @"code":password}.mutableCopy ;
//    if ([ZUserHelper sharedHelper].push_token) {
//        [params setObject:[ZUserHelper sharedHelper].push_token forKey:@"deviceToken"];
//    }
//    [ZNetworking postServerType:ZServerTypeApi url:URL_account_login_smg params:params completionHandler:^(id data, NSError *error) {
//        DLog(@"login back return %@", data);
//        if (data && [data isKindOfClass:[NSDictionary class]]) {
//            ZLoginNetBackModel *backModel = [ZLoginNetBackModel mj_objectWithKeyValues:data];
//            if ([backModel.code integerValue] == 0) {
//                //账号统计
//                [MobClick profileSignInWithPUID:backModel.user_info.user_id];
//                //保存用户信息
//                ZUser *user = [[ZUser alloc] init];
//                user.userID = backModel.user_info.user_id;
//                user.token = backModel.user_info.token;
//                user.uuid = backModel.user_info.uuid;
//                user.client_uid = backModel.user_info.uid;
//                [[NSUserDefaults standardUserDefaults] setObject:user.client_uid forKey:@"loginClientID"];
//                
//                [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"loginUserID"];
//                [[NSUserDefaults standardUserDefaults] setObject:user.uuid forKey:@"uuid"];
//                [[ZUserHelper sharedHelper] setUser:user];
//                [kNotificationCenter postNotificationName:KNotificationUserRefreshData object:nil];
//                if ([ZUserHelper sharedHelper].client_id && [ZUserHelper sharedHelper].client_id.length > 0) {
//                    [[ZLaunchManager sharedInstance].serverVC  updateConversationData];
//                    [[ZLaunchManager sharedInstance].serverVC  uploadOfflineMessage];
//                }else {
//                    [[ZIMServerManager sharedManager] getClientIDWith:@{@"user_id":user.userID, @"token":user.token} complete:^(BOOL isSuccess,NSString *client_id) {
//                        if (isSuccess && client_id) {
//                            user.client_uid = client_id;
//                            [[NSUserDefaults standardUserDefaults] setObject:user.client_uid forKey:@"loginClientID"];
//                            [[ZUserHelper sharedHelper] setUser:user];
//                            if ([ZUserHelper sharedHelper].client_id && [ZUserHelper sharedHelper].client_id.length > 0) {
//                                [[ZLaunchManager sharedInstance].serverVC  updateConversationData];
//                                [[ZLaunchManager sharedInstance].serverVC  uploadOfflineMessage];
//                            }
//    
//                        }
//                    }];
//                }
//
//                
//                block(YES, backModel.msg);
//                return ;
//            }else {
//                block(NO, backModel.msg);
//                return;
//            }
//        }
//        block(NO, @"登录失败");
//        DLog(@"return %@", data);
//    }];
//}

@end
