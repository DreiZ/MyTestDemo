//
//  ZOriganizationOrderViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseViewModel.h"


@interface ZOriganizationOrderViewModel : ZBaseViewModel
+ (void)addOrder:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getOrderList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;
@end

