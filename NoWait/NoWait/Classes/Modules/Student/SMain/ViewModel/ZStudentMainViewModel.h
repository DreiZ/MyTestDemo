//
//  ZStudentMainViewModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBaseViewModel.h"
@class ZMainClassifyOneModel;
@class ZMainClassifyOneModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMainViewModel : ZBaseViewModel

+ (void)getCategoryList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;

+ (void)getIndexList:(NSDictionary *)params
       completeBlock:(resultDataBlock)completeBlock ;


+ (void)searchStoresList:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getAdverList:(NSDictionary *)params
       completeBlock:(resultDataBlock)completeBlock ;


+ (void)getStoresDetail:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)getComplaintType:(NSDictionary *)params completeBlock:(resultDataBlock)completeBlock;


+ (void)addComplaint:(NSDictionary *)params
       completeBlock:(resultDataBlock)completeBlock;


//头部
+ (BOOL)updateMainBanners:(NSArray <ZAdverListModel *>*)banners;

+ (BOOL)updateMainPlaceholders:(NSArray <ZAdverListModel *>*)banners;

+ (NSArray <ZAdverListModel *>*)mainBannerData;

+ (NSArray <ZAdverListModel *>*)mainPlaceholderData;


+ (BOOL)updateMainClassifysOne:(NSArray <ZMainClassifyOneModel *>*)banners;

+ (NSArray <ZMainClassifyOneModel *>*)mainClassifyOneData;

+ (NSArray <ZMainClassifyOneModel *>*)mainClassifyTwoData;


+ (BOOL)updateMainEntryClassifys:(NSArray <ZMainClassifyOneModel *>*)banners;

+ (NSArray <ZMainClassifyOneModel *>*)mainClassifyEntryData;
@end

NS_ASSUME_NONNULL_END
