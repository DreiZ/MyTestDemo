//
//  ZOriganizationTeacherViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/12.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseViewModel.h"
#import "ZOriganizationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationTeacherViewModel : ZBaseViewModel

+ (void)getTeacherList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
