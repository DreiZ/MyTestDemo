//
//  ZTeacherViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZTeacherViewModel : ZBaseViewModel

+ (void)getStoresInfo:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
