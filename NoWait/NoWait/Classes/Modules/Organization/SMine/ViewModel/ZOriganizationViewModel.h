//
//  ZOriganizationViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseViewModel.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationViewModel : ZBaseViewModel
+ (void)getSchoolList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getSchoolDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)updateSchoolDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;

//校区统计相关
+ (void)getStoresStatistical:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getMerchantsAccount:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock ;


+ (void)getMerchantsAccountList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getMerchantsAccountDetailList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
