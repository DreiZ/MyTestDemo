//
//  ZLoginViewModel.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLoginViewModel.h"
#import "ZNetworkingManager.h"
#import "ZBaseNetworkBackModel.h"
#import "ZUserHelper.h"
#import "ZAlertView.h"
#import "ZPublicTool.h"

@implementation ZLoginViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _loginModel = [[ZLoginModel alloc] init];
        _registerModel = [[ZRegisterModel alloc] init];
        RAC(self, isLoginEnable)= [[RACSignal combineLatest:@[RACObserve(self, self.loginModel.tel),
                                                             RACObserve(self, self.loginModel.messageCode)]]
        map:^id(id value) {
        RACTupleUnpack(NSString *tel, NSString *messageCode) = value;
            return @(tel && tel.length == 11 && messageCode && messageCode.length == 6);
        }];
        
        RAC(self, isLoginPwdEnable)= [[RACSignal combineLatest:@[RACObserve(self, self.registerModel.tel),
                                                                 
                                                                 RACObserve(self, self.registerModel.pwd)]]
               map:^id(id value) {
               RACTupleUnpack(NSString *tel, NSString *pwd) = value;
                   return @(tel && tel.length == 11 && pwd && pwd.length >= 8);
               }];
    }
    return self;
}


+ (void)codeWithParams:(NSDictionary *)params  block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeCode url:URL_sms_v1_send_code params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 ) {
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

+ (void)imageCodeWith:(NSString *)tel block:(codeResultBlock)block  {
    [ZNetworkingManager postServerType:ZServerTypeCode url:URL_sms_v1_captcha params:@{} completionHandler:^(id data, NSError *error) {
        DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZImageCodeBackModel *imageCodeModel = [ZImageCodeBackModel mj_objectWithKeyValues:dataModel.data];
            block(YES,imageCodeModel);
        }else {
            if ([ZPublicTool getNetworkStatus]) {
                block(NO, dataModel.message);
            }else{
                block(NO, @"天呐，您的网络好像出了点小问题...");
            }
        }
    }];
}


- (void)codeWithParams:(NSDictionary *)params  block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeCode url:URL_sms_v1_send_code params:params completionHandler:^(id data, NSError *error) {
            DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 ) {
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

- (void)imageCodeWith:(NSString *)tel block:(codeResultBlock)block  {
    [ZNetworkingManager postServerType:ZServerTypeCode url:URL_sms_v1_captcha params:@{} completionHandler:^(id data, NSError *error) {
        DLog(@"return login code %@", data);
        ZBaseNetworkBackModel *dataModel = data;
        if ([dataModel.code intValue] == 0 && ValidDict(dataModel.data)) {
            ZImageCodeBackModel *imageCodeModel = [ZImageCodeBackModel mj_objectWithKeyValues:dataModel.data];
            block(YES,imageCodeModel);
        }else {
            if ([ZPublicTool getNetworkStatus]) {
                block(NO, dataModel.message);
            }else{
                block(NO, @"天呐，您的网络好像出了点小问题...");
            }
        }
    }];
}


- (void)retrieveWithParams:(NSDictionary *)params block:(loginUserResultBlock)block {
    [ZNetworkingManager postServerType:ZServerTypeUser url:URL_account_v1_register params:params completionHandler:^(id data, NSError *error) {
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


- (void)loginWithParams:(NSDictionary *)params block:(loginUserResultBlock)block {
    [[ZUserHelper sharedHelper] loginWithParams:params block:^(BOOL isSuccess, NSString *message) {
        block(isSuccess, message);
    }];
}


@end
