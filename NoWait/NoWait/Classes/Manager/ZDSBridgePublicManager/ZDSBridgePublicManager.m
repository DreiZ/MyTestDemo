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
#import "ZAlertView.h"
#import "DWKWebView.h"
#import "dsbridge.h"
#import "ZUMengShareManager.h"
#import "ZShareView.h"
#import "ZPayManager.h"

#import "AppDelegate+AppService.h"
#import <SDWebImageDownloader.h>

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
- (NSString *)testSyn:(NSString *)args {
    NSLog(@"testSyn arts %@",args);
    return [(NSString *)[args valueForKey:@"msg"] stringByAppendingString:@"[ syn call]"];

}

- (NSString *)testAsyn:(NSDictionary *)args :(void (^)( NSString* _Nullable result))completionHandler {
    NSLog(@"testAsyn arts %@",args);
    completionHandler([JSBUtil objToJsonString:@{@"iso":@"zzz"}]);
    return nil;
}


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

- (NSString *)go:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    DLog(@"桥接-go %@", args);
    if (args && [args isKindOfClass:[NSDictionary class]] && [args objectForKey:@"path"]) {
        id data = nil;
        if ([args objectForKey:@"data"]) {
            data = args[@"data"];
        }
        
        if ([args[@"path"] isEqualToString:@"controller/main/studentList"]) {
            NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithDictionary:data];
            [dataDict setObject:@"0" forKey:@"type"];
            routePushVC(ZRoute_main_starStudentList, data, nil);
            
        }else if([args[@"path"] isEqualToString:@"controller/main/teacherList"]){
            NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithDictionary:data];
            [dataDict setObject:@"1" forKey:@"type"];
            routePushVC(ZRoute_main_starStudentList, data, nil);
        }else{
            routePushVC(args[@"path"], data, nil);
        }
    }
    
    completionHandler(@{@"code":@"0", @"type":@"ios"});
    return nil;
}

- (NSString *)share:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    DLog(@"桥接-share %@", args);
    if (args && [args isKindOfClass:[NSDictionary class]]) {
        id title = nil;
        if ([args objectForKey:@"title"]) {
            title = args[@"title"];
        }
        
        id detail = nil;
        if ([args objectForKey:@"detail"]) {
            detail = args[@"detail"];
        }
        
        id url = nil;
        if ([args objectForKey:@"url"]) {
            url = args[@"url"];
        }
        
        id image = nil;
        if ([args objectForKey:@"image"]) {
            image = args[@"image"];
        }
        if (title && detail && url && image) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:image options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *simage, NSData *data, NSError *error, BOOL finished) {
                if (simage) {
                    [ZShareView setPre_title:@"分享" reduce_weight:title after_title:@"到微信" handlerBlock:^(NSInteger index) {
                        [[ZUMengShareManager sharedManager] shareUIWithType:0 Title:title detail:detail image:simage url:url vc:[[AppDelegate shareAppDelegate] getCurrentVC]];
                    }];
                }
            }];
        }
        
    }
    
    completionHandler(@{@"code":@"0"});
    return nil;
}

- (NSString *)alert:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    if (args && [args isKindOfClass:[NSDictionary class]]) {
        id title = @"提示";
        if ([args objectForKey:@"title"]) {
            title = args[@"title"];
        }
        
        id detail = @"";
        if ([args objectForKey:@"detail"]) {
            detail = args[@"detail"];
        }
        
        id left = nil;
        if ([args objectForKey:@"left"]) {
            left = args[@"left"];
        }
        
        id right = nil;
        if ([args objectForKey:@"right"]) {
            right = args[@"right"];
        }
        if (left && right) {
            [ZAlertView setAlertWithTitle:title subTitle:detail leftBtnTitle:left rightBtnTitle:right handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    completionHandler(@{@"code":@"0"});
                }else{
                    completionHandler(@{@"code":@"1"});
                }
            }];
        }else{
            [ZAlertView setAlertWithTitle:title subTitle:detail btnTitle:left handlerBlock:^(NSInteger index) {
                completionHandler(@{@"code":@"0"});
            }];
        }
    }
    
    return nil;
}

- (NSString *)getUserInfo:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    DLog(@"桥接-getUserInfo %@", args);
    if ([ZUserHelper sharedHelper].user.userID && [ZUserHelper sharedHelper].user.token) {
        NSMutableDictionary *userInfoDict = @{}.mutableCopy;
        [userInfoDict setObject:@"0" forKey:@"code"];
        [userInfoDict setObject:@"获取用户登录数据成功" forKey:@"info"];
        [userInfoDict setObject:@{@"user_id":[ZUserHelper sharedHelper].user.userID ,@"token":[ZUserHelper sharedHelper].user.token,@"name":[ZUserHelper sharedHelper].user.nikeName,@"phone":[ZUserHelper sharedHelper].user.phone,@"code_id":[ZUserHelper sharedHelper].user.userCodeID,@"type":[ZUserHelper sharedHelper].user.type,@"avatar":[ZUserHelper sharedHelper].user.avatar} forKey:@"data"];
        
        completionHandler(userInfoDict);
    }else{
        completionHandler(@{@"code":@"1"});
    }
    completionHandler(@{@"code":@"1"});
    return nil;
}

//alipay
- (NSString *)aliPay:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    if (ValidDict(args) && [args objectForKey:@"payInfo"]) {
        [[ZPayManager sharedManager] aliPay:args[@"payInfo"]];
        [[kNotificationCenter rac_addObserverForName:KNotificationPayBack object:nil] subscribeNext:^(NSNotification *notfication) {
            if (notfication.object && [notfication.object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *backDict = notfication.object;
                if (backDict && [backDict objectForKey:@"payState"]) {
                    
                    if ([backDict[@"payState"] intValue]  == 0) {
                        completionHandler(@{@"code":@"0"});
                    }else{
                        completionHandler(@{@"code":@"1"});
                    }
                    
                }else{
                    completionHandler(@{@"code":@"1"});
                }
            }else{
                completionHandler(@{@"code":@"1"});
            }
        }];
        completionHandler(@{@"code":@"1"});
    }else{
        completionHandler(@{@"code":@"1"});
    }
    return nil;
}

//alipay
- (NSString *)wechatPay:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    if (ValidDict(args) && [args objectForKey:@"payInfo"]) {
        [[ZPayManager sharedManager] wechatPayWithData:args[@"payInfo"]];
        
        [[kNotificationCenter rac_addObserverForName:KNotificationPayBack object:nil] subscribeNext:^(NSNotification *notfication) {
            if (notfication.object && [notfication.object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *backDict = notfication.object;
                if (backDict && [backDict objectForKey:@"payState"]) {
                    
                    if ([backDict[@"payState"] intValue]  == 0) {
                        completionHandler(@{@"code":@"0"});
                    }else {
                        completionHandler(@{@"code":@"1"});
                    }
                    
                }else{
                    completionHandler(@{@"code":@"1"});
                }
            }else{
                completionHandler(@{@"code":@"1"});
            }
        }];
        
    }else{
        completionHandler(@{@"code":@"1"});
    }
    return nil;
}


//下载图片
- (NSString *)saveImage:(NSDictionary *)args  :(void (^)( NSDictionary* _Nullable result))completionHandler {
    if (ValidDict(args) && [args objectForKey:@"url"]) {
        [self saveImageToNative:args[@"url"]];
        completionHandler(@{@"code":@"0"});
    }else{
        completionHandler(@{@"code":@"1"});
    }
    
    return nil;
}

- (void)saveImageToNative:(NSString *)urlString {
    [TLUIUtility showLoading:@""];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}


- (void)image:(UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    
    NSString *msg = nil ;
    [TLUIUtility hiddenLoading];
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    [TLUIUtility showInfoHint:msg];
}

//调试
- (void)callWebBack:(DWKWebView *)webview {
    [webview callHandler:@"toWeb"
                arguments:@[@{@"code":@"0", @"type":@"ios"}]
        completionHandler:^(NSString *  value){
            NSLog(@"webBack %@",value);
    }];
}


- (NSString *)toApp:(NSDictionary *)args :(void (^)( NSDictionary* _Nullable result))completionHandler {
    NSLog(@"桥接-toIOS %@",args);

//    [[[AppDelegate shareAppDelegate] getCurrentUIVC].navigationController popViewControllerAnimated:YES];
    completionHandler(@{@"code":@"0"});
    return nil;
}

@end
