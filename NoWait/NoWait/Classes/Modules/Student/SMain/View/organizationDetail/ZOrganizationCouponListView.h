//
//  ZOrganizationCouponListView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationCouponListView : UIView
+ (ZOrganizationCouponListView *)sharedManager ;

+ (void)setAlertWithTitle:(NSString *)title ouponList:(NSArray *)couponList handlerBlock:(void (^)(ZOriganizationCardListModel *))handleBlock ;

@end

NS_ASSUME_NONNULL_END
