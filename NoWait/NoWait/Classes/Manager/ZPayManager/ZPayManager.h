//
//  ZPayManager.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/12/30.
//  Copyright © 2018 承希-开发. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^resultBlock)(BOOL isSuccess, NSString *message);

typedef NS_ENUM(NSInteger,ZPayErrCode){
    ZPayErrCodeSuccess,// 成功
    ZPayErrCodeFailure,// 失败
    ZPayErrCodeCancel,// 取消
    ZPayErrCodeAbnormal//异常
};

typedef void(^PayCompleteCallBack)(ZPayErrCode errCode,NSString *errStr);

@interface ZPayManager : NSObject

+ (ZPayManager *)sharedManager;

//注册
- (void)wxPayRefisterApp;
//阿里支付
- (void)getAliPayInfo:(NSDictionary *)param complete:(resultBlock)complete;

//微信支付
- (void)getWechatPayInfo:(NSDictionary *)param complete:(resultBlock)complete;

/**
 *  @author gitKong
 *
 *  发起支付
 *
 * @param orderMessage 传入订单信息,如果是字符串，则对应是跳转支付宝支付；如果传入PayReq 对象，这跳转微信支付,注意，不能传入空字符串或者nil
 * @param callBack     回调，有返回状态信息
 */
- (void)payWithOrderMessage:(id)orderMessage callBack:(PayCompleteCallBack)callBack;


/**
 *  @author gitKong
 *
 *  处理跳转url，回到应用，需要在delegate中实现
 */
- (BOOL)pay_handleUrl:(NSURL *)url;


/**
 支付信息

 @param payDict {order_no： order_money: pay_type:}
 */
- (void)setPayValue:(NSDictionary *)payDict;
@end

