//
//  ZOriganizationOrderViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseViewModel.h"
#import "ZOrderModel.h"


@interface ZOriganizationOrderViewModel : ZBaseViewModel

+ (void)addOrder:(NSDictionary *)params
   completeBlock:(resultDataBlock)completeBlock;


+ (void)getOrderDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getOrderList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)evaOrder:(NSDictionary *)params
   completeBlock:(resultDataBlock)completeBlock;


+ (void)getMerchantsCommentListList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getTeacherCommentListList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

+ (void)getEvaDetail:(NSDictionary *)params
       completeBlock:(resultDataBlock)completeBlock ;


+ (void)replyEvaOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

#pragma mark - order handle
+ (void)cancleOrder:(NSDictionary *)params
      completeBlock:(resultDataBlock)completeBlock;


+ (void)deleteOrder:(NSDictionary *)params
      completeBlock:(resultDataBlock)completeBlock;



#pragma mark - handle index
+ (void)handleOrderWithIndex:(NSInteger)index data:(id)data completeBlock:(resultDataBlock)completeBlock;

@end

