//
//  ZAlertImageView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
//购买课程流程
typedef NS_ENUM(NSInteger, ZAlertType) {
    ZAlertTypeSubscribeFail,  //预约失败
    ZAlertTypeRepealSubscribe,  //撤销预约
    ZAlertTypeRepealSubscribeSuccess,  //撤销预约成功
    ZAlertTypeRepealSubscribeFail,  //撤销预约失败
};

@interface ZAlertImageView : UIView
+ (ZAlertImageView *)sharedManager ;

+ (void)setAlertWithTitle:(NSString *)title  subTitle:(NSString *)subTitle image:(UIImage *)image leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock ;

+ (void)setAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image btnTitle:(NSString *)btnTitle handlerBlock:(void(^)(NSInteger))handleBlock;
@end

