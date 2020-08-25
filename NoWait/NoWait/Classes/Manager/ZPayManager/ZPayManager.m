//
//  ZPayManager.m
//  ZBigHealth
//
//  Created by zzz on 2018/12/30.
//  Copyright © 2018 zzz. All rights reserved.
//

#import "ZPayManager.h"
#import "ZNetworking.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>
#import "ZOrderModel.h"
#import "ZOriganizationOrderViewModel.h"

static ZPayManager *sharedManager;
@interface ZPayManager ()<WXApiDelegate>
// 缓存回调
@property (nonatomic,copy) PayCompleteCallBack callBack;
@property (nonatomic,strong) NSDictionary *payInfo;

@end

@implementation ZPayManager

+ (ZPayManager *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZPayManager alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (void)setPayValue:(NSDictionary *)payDict {
    _payInfo = payDict;
}

- (void)wxPayRefisterApp {
    [WXApi registerApp:kAppKey_Wechat universalLink:@"https://www.xiangcenter.com"];
}

#pragma mark - 支付信息
- (void)getAliPayInfo:(NSDictionary *)param complete:(resultBlock)complete{
    
    [ZOriganizationOrderViewModel payOrder:param completeBlock:^(BOOL isSuccess, id backModel) {
        if (isSuccess) {
            ZMineOrderPayBackModel *pay = backModel;
            [self aliPay:pay.pay_code];
        }else{
            [TLUIUtility showErrorHint:backModel];
        }
           
        
        complete(NO,@"");
    }];
}

- (void)getWechatPayInfo:(NSDictionary *)param complete:(resultBlock)complete{
    if (![WXApi isWXAppInstalled]) {
        complete(NO,@"");
        [TLUIUtility showAlertWithTitle:@"此设备没有安装微信"];
    }else{
        [ZOriganizationOrderViewModel payOrder:param completeBlock:^(BOOL isSuccess, id backModel) {
            if (isSuccess) {
                ZMineOrderPayBackModel *pay = backModel;
                [self wechatPay:pay];
            }else{
                [TLUIUtility showErrorHint:backModel];
            }
               
            
            complete(NO,@"");
        }];
    }

}


- (void)getRefundAliPayInfo:(NSDictionary *)param complete:(resultBlock)complete{
    
    [ZOriganizationOrderViewModel refundPayOrder:param completeBlock:^(BOOL isSuccess, id backModel) {
        if (isSuccess) {
            ZMineOrderPayBackModel *pay = backModel;
            [self aliPay:pay.pay_code];
        }else{
            [TLUIUtility showErrorHint:backModel];
        }
           
        
        complete(NO,@"");
    }];
}

- (void)getRefundWechatPayInfo:(NSDictionary *)param complete:(resultBlock)complete{
    if (![WXApi isWXAppInstalled]) {
        complete(NO,@"");
        [TLUIUtility showAlertWithTitle:@"此设备没有安装微信"];
    }else{
        [ZOriganizationOrderViewModel refundPayOrder:param completeBlock:^(BOOL isSuccess, id backModel) {
            if (isSuccess) {
                ZMineOrderPayBackModel *pay = backModel;
                [self wechatPay:pay];
            }else{
                [TLUIUtility showErrorHint:backModel];
            }
               
            
            complete(NO,@"");
        }];
    }

}


#pragma mark - 支付
//阿里支付
- (void)aliPay:(NSString *)orderMessage {
//    orderMessage = [NSString stringWithFormat:@"%@%@",orderMessage,@"2"];
    [[AlipaySDK defaultService] payOrder:orderMessage fromScheme:@"cxhuanqing" callback:^(NSDictionary *resultDic){
        NSString *resultStatus = @"";
        if ([resultDic objectForKey:@"resultStatus"]) {
            resultStatus = resultDic[@"resultStatus"];
        }
        
        NSString *errStr = @"";
        if ([resultDic objectForKey:@"memo"]) {
            errStr = resultDic[@"memo"];
        }
        
        ZPayErrCode errorCode = ZPayErrCodeSuccess;
        switch (resultStatus.integerValue) {
            case 9000:// 成功
            {
                errorCode = ZPayErrCodeSuccess;
                if (self.payInfo && [self.payInfo objectForKey:@"order_money"]) {
//                    [MobClick event:@"orderPay" attributes:self.payInfo counter:[self.payInfo[@"order_money"] intValue]];
                }
                break;
            }
            case 6001:// 取消
            {
                errorCode = ZPayErrCodeCancel;
                break;
            }
            case 4000:// 账单异常
            {
                errorCode = ZPayErrCodeAbnormal;
//                errStr = @"系统繁忙，请稍后再试";
                break;
            }
            default:
                errorCode = ZPayErrCodeFailure;
                break;
        }
        if (errStr) {
            NSDictionary *backDict = @{@"payState":@(errorCode), @"msg":errStr};
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationPayBack object:backDict];
        }
        
        //回掉
        if ([ZPayManager sharedManager].callBack) {
            [ZPayManager sharedManager].callBack(errorCode,errStr);
        }
    }];
}


//微信支付
- (void)wechatPayWithData:(NSDictionary *)payDict {
    ZMineOrderPayBackModel *payModel = [ZMineOrderPayBackModel mj_objectWithKeyValues:payDict];
    [self wechatPay:payModel];
}

- (void)wechatPay:(ZMineOrderPayBackModel *)payModel {
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = payModel.mch_id;
    request.prepayId = payModel.prepay_id;
    request.package = @"Sign=WXPay";
    request.nonceStr = payModel.nonce_str;
    request.timeStamp = [payModel.timestamp intValue];
    request.sign = payModel.sign;
    [WXApi sendReq:request completion:^(BOOL success) {
//        success;
    }];
}

- (void)payWithOrderMessage:(id)orderMessage callBack:(PayCompleteCallBack)callBack {
    self.callBack = callBack;
    if ([orderMessage isKindOfClass:[NSString class]]) {
        [self aliPay:orderMessage];
    }
}

#pragma mark - 回调
- (BOOL)pay_handleUrl:(NSURL *)url{
    DLog(@"usl.host      %@ -- %@",url.host,url.absoluteString);
    if ([url.absoluteString hasPrefix:kAppKey_Wechat]) {// 微信
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.host isEqualToString:@"safepay"]) {// 支付宝
        // 支付跳转支付宝钱包进行支付，处理支付结果(在app被杀模式下，通过这个方法获取支付结果）
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSString *errStr = resultDic[@"memo"];
            
            
            ZPayErrCode errorCode = ZPayErrCodeSuccess;
            switch (resultStatus.integerValue) {
                case 9000:// 成功
                {
                    errorCode = ZPayErrCodeSuccess;
                    if (self.payInfo && [self.payInfo objectForKey:@"order_money"]) {
//                        [MobClick event:@"orderPay" attributes:self.payInfo counter:[self.payInfo[@"order_money"] intValue]];
                    }
                }
                    break;
                case 6001:// 取消
                    errorCode = ZPayErrCodeCancel;
                    break;
                default:
                    errorCode = ZPayErrCodeFailure;
                    break;
            }
            if (errStr) {
                NSDictionary *backDict = @{@"payState":@(errorCode), @"msg":errStr};
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationPayBack object:backDict];
            }
//            if ([ZPayManager sharedManager].callBack) {
//                [ZPayManager sharedManager].callBack(errorCode,errStr);
//            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            DLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            DLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    }
    else{
        return NO;
    }
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]) {
//        SendAuthResp *auth = (SendAuthResp *)resp;
//        DLog(@"zzz %@--\n %@--\n%@--\n%@",auth.code,auth.state,auth.country,auth.lang);
    }else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg = @"";
        ZPayErrCode errorCode = ZPayErrCodeSuccess;
        switch (resp.errCode) {
            case WXSuccess:
            {
                errorCode = ZPayErrCodeSuccess;
                strMsg = @"支付结果：成功！";
//                strMsg = @"支付结果：成功！";
//                DLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            }
                break;
            case WXErrCodeUserCancel:{
                errorCode = ZPayErrCodeCancel;
                strMsg = @"支付结果：取消！";
            }
                break;
            default:
            {
                errorCode = ZPayErrCodeFailure;
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                DLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            }
                break;
        }
        
        if (strMsg) {
            NSDictionary *backDict = @{@"payState":@(errorCode), @"msg":strMsg};
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationPayBack object:backDict];
        }
    }
}

- (void)onReq:(BaseReq *)req {
    
}
@end
