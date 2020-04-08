//
//  ZStudentMainViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMainViewModel : ZBaseViewModel

+ (void)getIndexList:(NSDictionary *)params
       completeBlock:(resultDataBlock)completeBlock ;

+ (void)getAdverList:(NSDictionary *)params
       completeBlock:(resultDataBlock)completeBlock ;


+ (void)getStoresDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getComplaintType:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)addComplaint:(NSDictionary *)params
       completeBlock:(resultDataBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
