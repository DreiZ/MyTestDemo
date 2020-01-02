//
//  ZPhoneAlertView.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/12.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZPhoneAlertView : UIView
+ (void)setAlertName:(NSString *)title detail:(NSString *)detail headImage:(NSString *)headImage tel:(NSString *)tel handlerBlock:(void(^)(NSInteger))handleBlock ;
@end

