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
//教师签课
+ (void)teacherSign:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
//长效补课
+ (void)teacherBuSign:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
+ (void)getNoteSignDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
+ (void)checkSign:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
+ (void)noteSign:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

