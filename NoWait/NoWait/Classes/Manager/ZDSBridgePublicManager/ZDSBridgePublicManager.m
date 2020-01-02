//
//  ZDSBridgePublicManager.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/3.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZDSBridgePublicManager.h"
#import "ZPublicTool.h"
#import "ZUserHelper.h"
#import "AppDelegate+AppService.h"

static ZDSBridgePublicManager *shareBridgeManager = NULL;


@implementation ZDSBridgePublicManager

+(instancetype)sharedManager {
    @synchronized (self) {
        if (shareBridgeManager == NULL) {
            shareBridgeManager = [[ZDSBridgePublicManager alloc] init];
        }
    }
    return shareBridgeManager;
}

+ (instancetype)shareDSBridgeManager {
    @synchronized (self) {
        if (shareBridgeManager == NULL) {
            shareBridgeManager = [[ZDSBridgePublicManager alloc] init];
        }
    }
    return shareBridgeManager;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    
}


//
//#pragma mark 回调
//- (NSString *)testSyn:(NSDictionary *)args {
//
//    return [(NSString *)[args valueForKey:@"msg"] stringByAppendingString:@"[ syn call]"];
//
//}
//
//- (NSString *)testAsyn:(NSDictionary *)args :(void (^)( NSString* _Nullable result))completionHandler {
//    completionHandler([JSBUtil objToJsonString:@{@"iso":@"zzz"}]);
//    return nil;
//}


//#pragma mark 调用web函数
//- (void)callWebBack:(DWKwebview *)webview {
//    [webview callHandler:@"back"
//               arguments:nil
//       completionHandler:^(NSString *  value){
//           DLog(@"%@",value);
//       }];
//}

#pragma mark 同步回调
- (NSString *)closeWebView:(NSDictionary *)args {
    DLog(@"同步-桥接-关闭webview");
    [[[AppDelegate shareAppDelegate] getCurrentUIVC].navigationController popViewControllerAnimated:YES];
    return nil;

}


#pragma mark 异步回调
- (NSString *)closeWebView:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    DLog(@"桥接-关闭webview");
    [[[AppDelegate shareAppDelegate] getCurrentUIVC].navigationController popViewControllerAnimated:YES];
    completionHandler(@{@"code":@"0"});
    return nil;
}


- (NSString *)telPhone:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    DLog(@"桥接-拨打电话 %@", args);
    if ([args objectForKey:@"number"]) {
        [ZPublicTool callTel:args[@"number"]];
        completionHandler(@{@"code":@"0"});
    }else{
        completionHandler(@{@"code":@"1"});
    }
    return nil;
}



- (NSString *)isAPP:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    DLog(@"桥接-isAPP %@", args);
    completionHandler(@{@"code":@"0", @"type":@"ios"});
    return nil;
}

@end
