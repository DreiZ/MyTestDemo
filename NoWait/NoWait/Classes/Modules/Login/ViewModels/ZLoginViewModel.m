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
        
        RAC(self, isRegisterEnable)= [[RACSignal combineLatest:@[RACObserve(self, self.registerModel.tel),RACObserve(self, self.registerModel.pwd),RACObserve(self, self.registerModel.messageCode),
                                                                    RACObserve(self, self.registerModel.code)]]
               map:^id(id value) {
               RACTupleUnpack(NSString *tel, NSString *pwd,NSString *messageCode, NSString *code) = value;
                   return @(tel && tel.length == 11 && pwd && pwd.length >= 6 && messageCode && messageCode.length == 6 && code && code.length == 4);
               }];
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(loginUserResultBlock)block {
    [[ZUserHelper sharedHelper] loginWithUsername:username password:password block:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            //进入主页
            [[ZLaunchManager sharedInstance] launchInWindow:nil];
            [[NSUserDefaults standardUserDefaults] setObject:@"hadLogin" forKey:@"hadLogin"];
            block(YES, message);
            return ;
        }else{
            block(NO, message);
        }
    }];
}

- (void)codeWithTel:(NSString *)tel block:(loginUserResultBlock)block {
    
}

- (void)imageCodeWith:(NSString *)tel block:(codeResultBlock)block  {
//    [ZNetworking getTServerType:ZServerTypeCode url:URL_sms_v1_captcha params:@{@"identifier":@"graphic"} completionHandler:^(id _Nonnulldata, NSError * error) {
//        
//    }];
//    return;
    [ZNetworkingManager postServerType:ZServerTypeCode url:URL_sms_v1_captcha params:@{@"identifier":@"graphic"} completionHandler:^(id data, NSError *error) {
        DLog(@"return login code %@", data);
        block(YES,data);
//        if (data && [data isKindOfClass:[NSDictionary class]]) {
//            ZLoginMsgBackModel *backModel = [ZLoginMsgBackModel mj_objectWithKeyValues:data];
//            if ([backModel.code integerValue] == 0) {
//                block(YES, backModel.msg);
//                if (backModel.test_code && backModel.test_code.length > 0) {
//                    [ZAlertView setAlertWithTitle:backModel.test_code  btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
//                        [[ZAlertView sharedManager] removeFromSuperview];
//                    }];
//                }
//
//                return ;
//            }else{
//                block(NO, backModel.msg);
//                return;
//            }
//        }
        if ([ZPublicTool getNetworkStatus]) {
            block(NO, @"获取验证码失败");
        }else{
            block(NO, @"天呐，您的网络好像出了点小问题...");
        }

    }];
}
@end
