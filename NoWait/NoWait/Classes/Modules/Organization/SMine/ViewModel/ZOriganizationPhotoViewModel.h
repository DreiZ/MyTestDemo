//
//  ZOriganizationPhotoViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseViewModel.h"


@interface ZOriganizationPhotoViewModel : ZBaseViewModel

+ (void)getStoresImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getStoresTypeImageList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)addImage:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)delImage:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;
@end


