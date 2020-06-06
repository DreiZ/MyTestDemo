//
//  ZRewardAlertView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZRewardAlertView : UIView
+ (void)showRewardSeeBlock:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
