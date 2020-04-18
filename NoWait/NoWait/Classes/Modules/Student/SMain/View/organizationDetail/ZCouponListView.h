//
//  ZCouponListView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCouponListView.h"


@interface ZCouponListView : UIView

+ (ZCouponListView *)sharedManager ;

- (void)refreshData;
+ (void)setAlertWithTitle:(NSString *)title type:(NSString *)type stores_id:(NSString *)stores_id course_id:(NSString *)course_id teacher_id:(NSString *)teacher_id handlerBlock:(void (^)(ZOriganizationCardListModel *))handleBlock;

@end

