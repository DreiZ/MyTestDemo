//
//  ZAlertQRCodeView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZAlertQRCodeView : UIView
+ (ZAlertQRCodeView *)sharedManager ;

+ (void)setAlertWithTitle:(NSString *)title qrCode:(NSString *)qrCode handlerBlock:(void(^)(NSInteger))handleBlock;

@end

NS_ASSUME_NONNULL_END
