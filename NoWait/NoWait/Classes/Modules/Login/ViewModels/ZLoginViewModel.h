//
//  ZLoginViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"

#import "ZBaseViewModel.h"
#import "ZLoginModel.h"
#import "ZLaunchManager.h"

typedef void (^loginUserResultBlock)(BOOL isSuccess, NSString *message);
typedef void (^codeResultBlock)(BOOL isSuccess, id message);
@interface ZLoginViewModel : ZBaseViewModel
/**
 判断是否可以登录
 */
@property (nonatomic, assign) BOOL isLoginEnable;
@property (nonatomic, assign) BOOL isRegisterEnable;
@property (nonatomic, strong) ZLoginModel *loginModel;
@property (nonatomic, strong) ZRegisterModel *registerModel;


/**
 验证码

 @param params 电话号码 ckey
 @param block 返回信息
 */
- (void)codeWithParams:(NSDictionary *)params
                 block:(loginUserResultBlock)block;


/**
 验证码图形

 @param tel 电话号码
 @param block 返回信息
 */
- (void)imageCodeWith:(NSString *)tel
              block:(codeResultBlock)block;

/**
 验证码

 @param params 电话号码 ckey
 @param block 返回信息
 */
+ (void)codeWithParams:(NSDictionary *)params
                 block:(loginUserResultBlock)block;


/**
 验证码图形

 @param tel 电话号码
 @param block 返回信息
 */
+ (void)imageCodeWith:(NSString *)tel
              block:(codeResultBlock)block;



/**
注册

@param params 注册信息
@param block 返回信息
*/
- (void)retrieveWithParams:(NSDictionary *)params
                     block:(loginUserResultBlock)block;

/**
登录信息

@param params 登录信息
@param block 返回信息
*/
- (void)loginWithParams:(NSDictionary *)params
                  block:(loginUserResultBlock)block;
@end
