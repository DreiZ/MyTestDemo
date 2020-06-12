//
//  ZDBMainStore.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDBBaseStore.h"
@class ZAdverListModel;
@class ZMainClassifyOneModel;
@class ZMainClassifyOneModel;
@class ZMainClassifyOneModel;
@class ZHistoryModel;

@interface ZDBMainStore : ZDBBaseStore

+ (ZDBMainStore *)shareManager;

#pragma mark - main_banner
/**
 *  更新banner信息
 */
- (BOOL)updateMainBanner:(ZAdverListModel *)banner;

/**
 *  更新banners信息
 */
- (BOOL)updateMainBanners:(NSArray <ZAdverListModel *>*)banners;

/**
 *  获取banner信息
 */
- (ZAdverListModel *)mainBannerByID:(NSString *)ad_id;

/**
 *  查询所有banner
 */
- (NSArray <ZAdverListModel *>*)mainBannerData;

/**
 *  删除banner
 */
- (BOOL)deleteBannderByAdId:(NSString *)ad_id;

/**
 *  删除all banner
 */
- (BOOL)cleanBannder;


#pragma mark - placeholder
/**
 *  更新Placeholder信息
*/
- (BOOL)updateMainPlaceholder:(ZAdverListModel *)banner;

/**
*  更新Placeholders信息
*/
- (BOOL)updateMainPlaceholders:(NSArray <ZAdverListModel *>*)banners;

/**
 *  获取Placeholder信息
*/
- (ZAdverListModel *)mainPlaceholderByID:(NSString *)ad_id;

/**
 *  查询所有Placeholder
 */
- (NSArray <ZAdverListModel *>*)mainPlaceholderData;

/**
 *  删除Placeholder
 */
- (BOOL)deletePlaceholderByAdId:(NSString *)ad_id;

/**
 *  删除all Placeholder
*/
- (BOOL)cleanPlaceholder;


#pragma mark - classify
/**
 *  更新Classify信息
*/
- (BOOL)updateMainClassify:(ZMainClassifyOneModel *)classify;

/**
 *  更新classifys信息
 */
- (BOOL)updateMainClassifys:(NSArray <ZMainClassifyOneModel *>*)banners;

/**
 *  获取Classify信息
*/
- (ZMainClassifyOneModel *)mainClassifyByID:(NSString *)classify_id;

/**
 *  获取Classify信息
*/
- (NSArray *)mainClassifyData;

/**
 *  删除Classify
 */
- (BOOL)deleteClassifyByAdId:(NSString *)classify_id;

/**
 *  删除Classify
 */
- (BOOL)cleanClassify;

#pragma mark - classify one
/**
 *  更新ClassifyOne信息
*/
- (BOOL)updateMainClassifyOne:(ZMainClassifyOneModel *)classify;
/**
 *  更新ClassifyOne信息
 */
- (BOOL)updateMainClassifysOne:(NSArray <ZMainClassifyOneModel *>*)banners;


/**
 *  获取ClassifyOne信息
*/
- (ZMainClassifyOneModel *)mainClassifyOneByID:(NSString *)classify_id;

/**
 *  获取ClassifyOne信息
*/
- (NSMutableArray <ZMainClassifyOneModel *>*)mainClassifyOneData;

/**
 *  删除ClassifyOne
 */
- (BOOL)deleteClassifyOneByClassifyId:(NSString *)classify_id;
/**
*  删除ClassifyOne
*/
- (BOOL)cleanClassifyOne;

#pragma mark - classify two
/**
 *  更新ClassifyTwo信息
*/
- (BOOL)updateMainClassifyTwo:(ZMainClassifyOneModel *)classify;

/**
 *  更新ClassifyTwo信息
 */
- (BOOL)updateMainClassifysTwo:(NSArray <ZMainClassifyOneModel *>*)classifysTwo;


/**
 *  获取ClassifyTwo信息
*/
- (NSMutableArray <ZMainClassifyOneModel *>*)mainClassifyTwoBySpuerID:(NSString *)superClassify_id;

/**
 *  获取ClassifyTwo信息
*/
- (NSMutableArray <ZMainClassifyOneModel *>*)mainClassifyTwoData;

/**
 *  删除ClassifyTwo
 */
- (BOOL)deleteClassifyTwoBySuperId:(NSString *)superClassify_id;

/**
 *  删除ClassifyTwo
 */
- (BOOL)cleanClassifyTwo;


#pragma mark - search history
/**
 *  更新search history信息
*/
- (BOOL)updateHistorySearch:(ZHistoryModel *)history;

/**
 *  更新search history信息
 */
- (BOOL)updateHistorySearchs:(NSArray <ZHistoryModel *>*)banners;

/**
 *  获取search history信息
*/
- (ZHistoryModel *)searchHistoryByID:(NSString *)search_id;

/**
 *  获取search historys信息
*/
- (NSMutableArray *)searchHistorysByID:(NSString *)search_type;

/**
 *  获取search history信息
*/
- (NSMutableArray <ZHistoryModel *>*)searchHistoryData;

/**
 *  删除search history
 */
- (BOOL)deleteSearchHistoryByAdId:(NSString *)search_id;

/**
 *  删除search history
 */
- (BOOL)cleanSearchHistory;

@end
