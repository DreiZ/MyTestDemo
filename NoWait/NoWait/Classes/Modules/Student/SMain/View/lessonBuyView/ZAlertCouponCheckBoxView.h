//
//  ZAlertCouponCheckBoxView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZAlertDataCheckBoxBottomView.h"


@interface ZAlertCouponCheckBoxView : ZAlertDataCheckBoxBottomView
+ (void)setAlertName:(NSString *)title schoolID:(NSString *)schoolID handlerBlock:(void(^)(NSInteger,id))handleBlock ;
@end


