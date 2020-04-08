//
//  ZPayAlertTypeView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPayAlertTypeView : UIView
+ (void)showWithHandlerBlock:(void(^)(NSInteger))handleBlock ;
@end

NS_ASSUME_NONNULL_END
