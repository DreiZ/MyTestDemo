//
//  ZAlertView.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/29.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZAlertView : UIView
+ (ZAlertView *)sharedManager ;

+ (void)setAlertWithTitle:(NSString *)title btnTitle:(NSString *)btnTitle handlerBlock:(void(^)(NSInteger))handleBlock;

+ (void)setAlertWithTitle:(NSString *)title leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock ;

+ (void)setAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle btnTitle:(NSString *)btnTitle  handlerBlock:(void(^)(NSInteger))handleBlock;

+ (void)setAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock ;
@end

