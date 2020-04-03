//
//  ZSignViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"


@interface ZSignViewModel : ZBaseViewModel
+ (void)getSignDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

