//
//  XLPaymentErrorHUD.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLPaymentErrorHUD : UIView<CAAnimationDelegate>

-(void)start;

-(void)hide;

+(XLPaymentErrorHUD*)showIn:(UIView*)view;

+(XLPaymentErrorHUD*)hideIn:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
