//
//  ZServerCompleteAlertView.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2019/1/28.
//  Copyright © 2019 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZServerCompleteAlertView : UIView
+ (void)setAlertWithHandlerBlock:(void(^)(NSInteger))handleBlock;
@end

NS_ASSUME_NONNULL_END
