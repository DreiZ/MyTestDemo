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
        RAC(self, isLoginEnable)= [[RACSignal combineLatest:@[RACObserve(self, self.loginModel.tel),RACObserve(self, self.loginModel.pwd),
                                                             RACObserve(self, self.loginModel.code)]]
        map:^id(id value) {
        RACTupleUnpack(NSString *tel, NSString *pwd, NSString *code) = value;
            return @(tel && tel.length == 11 && pwd && pwd.length >= 6 && code && code.length == 4);
        }];
        
        RAC(self, isRegisterEnable)= [[RACSignal combineLatest:@[RACObserve(self, self.registerModel.tel),
                                                                 
                                                                 RACObserve(self, self.registerModel.pwd),
                                                                 RACObserve(self, self.registerModel.messageCode),
                                                                    
                                                                 RACObserve(self, self.registerModel.code)]]
               map:^id(id value) {
               RACTupleUnpack(NSString *tel, NSString *pwd,NSString *messageCode, NSString *code) = value;
                   return @(tel && tel.length == 11 && pwd && pwd.length >= 6 && messageCode && messageCode.length == 6 && code && code.length == 4);
               }];
    }
    return self;
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
        if ([dataModel.code intValue] == 0 && dataModel.data && [dataModel.data isKindOfClass:[NSDictionary class]]) {
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
            block(YES,dataModel.code);
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
