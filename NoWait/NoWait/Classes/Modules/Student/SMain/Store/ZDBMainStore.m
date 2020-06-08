//
//  ZDBMainStore.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZDBMainStore.h"
#import "ZDBMainStoreSQL.h"
#import "ZOriganizationModel.h"
#import "ZStudentMainModel.h"
#import "ZHistoryModel.h"

@implementation ZDBMainStore

+ (ZDBMainStore *)shareManager
{
    static ZDBMainStore *helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[ZDBMainStore alloc] init];
    });
    return helper;
}


- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [ZDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            DLog(@"DB: banner表创建失败");
        }
        
        BOOL ok_placeholder = [self createPlaceholderTable];
        if (!ok_placeholder) {
            DLog(@"DB: placeholder表创建失败");
        }
        
        BOOL ok_classify = [self createClassifyTable];
        if (!ok_classify) {
            DLog(@"DB: classify表创建失败");
        }
        
        BOOL ok_classify_one = [self createClassifyOneTable];
        if (!ok_classify_one) {
            DLog(@"DB: classify_one表创建失败");
        }
        
        BOOL ok_classify_two = [self createClassifyTwoTable];
        if (!ok_classify_two) {
            DLog(@"DB: classify_two表创建失败");
        }
        
        BOOL ok_search_history = [self createSearchHistoryTable];
        if (!ok_search_history) {
            DLog(@"DB: search_history表创建失败");
        }
    }
    return self;
}

#pragma mark - banner tableview
- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_MAINBANNER_TABLE, MAIN_TABLE_BANNER];
    return [self createTable:MAIN_TABLE_BANNER withSQL:sqlString];
}

- (BOOL)updateMainBanner:(ZAdverListModel *)banner
{
    if (!banner || banner.ad_id.length == 0) {
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_MAINBANNER, MAIN_TABLE_BANNER];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(banner.ad_id),
                        TLNoNilString(banner.ad_image),
                        TLNoNilString(banner.ad_url),
                        TLNoNilString(banner.ad_type),
                        TLNoNilString([banner.ad_type_content tranModelToJSON]),
                        TLNoNilString(banner.name),
                        @"", @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}


/**
 *  更新banners信息
 */
- (BOOL)updateMainBanners:(NSArray <ZAdverListModel *>*)banners{
    [self cleanBannder];
    __block NSInteger index = 0;
    [banners enumerateObjectsUsingBlock:^(ZAdverListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL update_ok = [self updateMainBanner:obj];
        if (!update_ok) {
            index++;
        }
    }];
    if (index > 0) {
        return NO;
    }
    return YES;
}


- (ZAdverListModel *)mainBannerByID:(NSString *)ad_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_MAINBANNER_BY_ID, MAIN_TABLE_BANNER, ad_id];
    __block ZAdverListModel * banner;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            banner = [self p_createBannerByFMResultSet:retSet];
        }
        [retSet close];
    }];
    return banner;
}

- (NSArray <ZAdverListModel *>*)mainBannerData
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_MAINBANNERS, MAIN_TABLE_BANNER];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZAdverListModel *banner = [self p_createBannerByFMResultSet:retSet];
            [data addObject:banner];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deleteBannderByAdId:(NSString *)ad_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_MAINBANNER, MAIN_TABLE_BANNER, ad_id];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

- (BOOL)cleanBannder {
    NSString *sqlString = [NSString stringWithFormat:SQL_CLEAN_MAINBANNER, MAIN_TABLE_BANNER];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

// Private Methods
- (ZAdverListModel *)p_createBannerByFMResultSet:(FMResultSet *)retSet
{
    ZAdverListModel *banner = [[ZAdverListModel alloc] init];
    banner.ad_id = [retSet stringForColumn:@"ad_id"];
    banner.ad_image = [retSet stringForColumn:@"ad_image"];
    banner.ad_url = [retSet stringForColumn:@"ad_url"];
    banner.ad_type = [retSet stringForColumn:@"ad_type"];
    banner.name = [retSet stringForColumn:@"name"];
    banner.ad_type_content = [ZAdverListContentModel getModelFromStr:[retSet stringForColumn:@"ad_type_content"]];

    return banner;
}

#pragma mark - placeholder tableview
- (BOOL)createPlaceholderTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_PLACEHOLDER_TABLE, MAIN_TABLE_PLACEHOLDER];
    return [self createTable:MAIN_TABLE_PLACEHOLDER withSQL:sqlString];
}

- (BOOL)updateMainPlaceholder:(ZAdverListModel *)banner
{
    if (!banner || banner.ad_id.length == 0) {
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_PLACEHOLDER, MAIN_TABLE_PLACEHOLDER];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(banner.ad_id),
                        TLNoNilString(banner.ad_image),
                        TLNoNilString(banner.ad_url),
                        TLNoNilString(banner.ad_type),
                        TLNoNilString([banner.ad_type_content tranModelToJSON]),
                        TLNoNilString(banner.name),
                        @"", @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

/**
 *  更新banners信息
 */
- (BOOL)updateMainPlaceholders:(NSArray <ZAdverListModel *>*)banners{
    [self cleanPlaceholder];
    __block NSInteger index = 0;
    [banners enumerateObjectsUsingBlock:^(ZAdverListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL update_ok = [self updateMainPlaceholder:obj];
        if (!update_ok) {
            index++;
        }
    }];
    if (index > 0) {
        return NO;
    }
    return YES;
}


- (ZAdverListModel *)mainPlaceholderByID:(NSString *)ad_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_PLACEHOLDER_BY_ID, MAIN_TABLE_PLACEHOLDER, ad_id];
    __block ZAdverListModel * banner;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            banner = [self p_createPlaceholderByFMResultSet:retSet];
        }
        [retSet close];
    }];
    return banner;
}

- (NSArray <ZAdverListModel *>*)mainPlaceholderData
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_PLACEHOLDERS, MAIN_TABLE_PLACEHOLDER];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZAdverListModel *banner = [self p_createPlaceholderByFMResultSet:retSet];
            [data addObject:banner];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deletePlaceholderByAdId:(NSString *)ad_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_PLACEHOLDER, MAIN_TABLE_PLACEHOLDER, ad_id];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

- (BOOL)cleanPlaceholder {
    NSString *sqlString = [NSString stringWithFormat:SQL_CLEAN_PLACEHOLDER, MAIN_TABLE_PLACEHOLDER];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

// Private Methods
- (ZAdverListModel *)p_createPlaceholderByFMResultSet:(FMResultSet *)retSet
{
    ZAdverListModel *banner = [[ZAdverListModel alloc] init];
    banner.ad_id = [retSet stringForColumn:@"ad_id"];
    banner.ad_image = [retSet stringForColumn:@"ad_image"];
    banner.ad_url = [retSet stringForColumn:@"ad_url"];
    banner.ad_type = [retSet stringForColumn:@"ad_type"];
    banner.name = [retSet stringForColumn:@"name"];
    banner.ad_type_content = [ZAdverListContentModel getModelFromStr:[retSet stringForColumn:@"ad_type_content"]];

    return banner;
}


#pragma mark - classify tableview
- (BOOL)createClassifyTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_CLASSIFY_TABLE, MAIN_TABLE_CLASSIFY];
    return [self createTable:MAIN_TABLE_CLASSIFY withSQL:sqlString];
}

- (BOOL)updateMainClassify:(ZMainClassifyOneModel *)classify
{
    if (!classify || classify.classify_id.length == 0) {
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_CLASSIFY, MAIN_TABLE_CLASSIFY];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(classify.classify_id),
                        TLNoNilString(classify.name),
                        TLNoNilString(classify.imageName),
                        @"", @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

/**
 *  更新classifys信息
 */
- (BOOL)updateMainClassifys:(NSArray <ZMainClassifyOneModel *>*)banners{
    [self cleanClassify];
    __block NSInteger index = 0;
    [banners enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL update_ok = [self updateMainClassify:obj];
        if (!update_ok) {
            index++;
        }
    }];
    if (index > 0) {
        return NO;
    }
    return YES;
}


- (ZMainClassifyOneModel *)mainClassifyByID:(NSString *)classify_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CLASSIFY_BY_ID, MAIN_TABLE_CLASSIFY, classify_id];
    __block ZMainClassifyOneModel * classify;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            classify = [self p_createClassifyByFMResultSet:retSet];
        }
        [retSet close];
    }];
    return classify;
}

- (NSArray *)mainClassifyData
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CLASSIFYS, MAIN_TABLE_CLASSIFY];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZMainClassifyOneModel *classify = [self p_createClassifyByFMResultSet:retSet];
            [data addObject:classify];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deleteClassifyByAdId:(NSString *)classify_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_CLASSIFY, MAIN_TABLE_CLASSIFY, classify_id];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

- (BOOL)cleanClassify {
    NSString *sqlString = [NSString stringWithFormat:SQL_CLEAN_CLASSIFY, MAIN_TABLE_CLASSIFY];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

// Private Methods
- (ZMainClassifyOneModel *)p_createClassifyByFMResultSet:(FMResultSet *)retSet
{
    ZMainClassifyOneModel *classify = [[ZMainClassifyOneModel alloc] init];
    classify.classify_id = [retSet stringForColumn:@"classify_id"];
    classify.name = [retSet stringForColumn:@"name"];
    classify.imageName = [retSet stringForColumn:@"imageName"];
    
    return classify;
}


#pragma mark - classify one
- (BOOL)createClassifyOneTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_CLASSIFY_ONE_TABLE, MAIN_TABLE_CLASSIFY_ONE];
    return [self createTable:MAIN_TABLE_CLASSIFY_ONE withSQL:sqlString];
}

- (BOOL)updateMainClassifyOne:(ZMainClassifyOneModel *)classify
{
    if (!classify || classify.classify_id.length == 0) {
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_CLASSIFY_ONE, MAIN_TABLE_CLASSIFY_ONE];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(classify.classify_id),
                        TLNoNilString(classify.name),
                        TLNoNilString(classify.imageName),
                        TLNoNilString(classify.superClassify_id),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    if (ValidArray(classify.secondary)) {
        [self updateMainClassifysTwo:classify.secondary];
    }
    return ok;
}

/**
 *  更新classifys信息
 */
- (BOOL)updateMainClassifysOne:(NSArray <ZMainClassifyOneModel *>*)banners{
    __block NSInteger index = 0;
    [banners enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL update_ok = [self updateMainClassifyOne:obj];
        if (!update_ok) {
            index++;
        }
    }];
    if (index > 0) {
        return NO;
    }
    return YES;
}


- (ZMainClassifyOneModel *)mainClassifyOneByID:(NSString *)classify_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CLASSIFY_ONE_BY_ID, MAIN_TABLE_CLASSIFY_ONE, classify_id];
    __block ZMainClassifyOneModel * classify;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            classify = [self p_createClassifyOneByFMResultSet:retSet];
        }
        [retSet close];
    }];
    return classify;
}

- (NSMutableArray <ZMainClassifyOneModel *>*)mainClassifyOneData
{
    __block NSMutableArray <ZMainClassifyOneModel *>*data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CLASSIFYS_ONE, MAIN_TABLE_CLASSIFY_ONE];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZMainClassifyOneModel *classify = [self p_createClassifyOneByFMResultSet:retSet];
            [data addObject:classify];
        }
        [retSet close];
    }];
    [data enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.secondary = [self mainClassifyTwoBySpuerID:obj.classify_id];
    }];
    return data;
}

- (BOOL)deleteClassifyOneByClassifyId:(NSString *)classify_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_CLASSIFY_ONE, MAIN_TABLE_CLASSIFY_ONE, classify_id];
    BOOL ok = [self excuteSQL:sqlString, nil];
    [self deleteClassifyTwoBySuperId:classify_id];
    return ok;
}

- (BOOL)cleanClassifyOne {
    NSString *sqlString = [NSString stringWithFormat:SQL_CLEAN_CLASSIFY_ONE, MAIN_TABLE_CLASSIFY_ONE];
    BOOL ok = [self excuteSQL:sqlString, nil];
    [self cleanClassifyTwo];
    return ok;
}

// Private Methods
- (ZMainClassifyOneModel *)p_createClassifyOneByFMResultSet:(FMResultSet *)retSet
{
    ZMainClassifyOneModel *classify = [[ZMainClassifyOneModel alloc] init];
    classify.classify_id = [retSet stringForColumn:@"classify_id"];
    classify.name = [retSet stringForColumn:@"name"];
    classify.imageName = [retSet stringForColumn:@"imageName"];
    classify.superClassify_id = [retSet stringForColumn:@"ext0"];
    return classify;
}


#pragma mark - classify two
- (BOOL)createClassifyTwoTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_CLASSIFY_TWO_TABLE, MAIN_TABLE_CLASSIFY_TWO];
    return [self createTable:MAIN_TABLE_CLASSIFY_TWO withSQL:sqlString];
}

- (BOOL)updateMainClassifyTwo:(ZMainClassifyOneModel *)classify
{
    if (!classify || classify.classify_id.length == 0) {
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_CLASSIFY_TWO, MAIN_TABLE_CLASSIFY_TWO];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(classify.classify_id),
                        TLNoNilString(classify.name),
                        TLNoNilString(classify.imageName),
                        TLNoNilString(classify.superClassify_id),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

/**
 *  更新classifys信息
 */
- (BOOL)updateMainClassifysTwo:(NSArray <ZMainClassifyOneModel *>*)classifysTwo{
    __block NSInteger index = 0;
    [classifysTwo enumerateObjectsUsingBlock:^(ZMainClassifyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL update_ok = [self updateMainClassifyTwo:obj];
        if (!update_ok) {
            index++;
        }
    }];
    if (index > 0) {
        return NO;
    }
    return YES;
}


- (NSMutableArray <ZMainClassifyOneModel *>*)mainClassifyTwoBySpuerID:(NSString *)superClassify_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CLASSIFY_TWO_BY_ID, MAIN_TABLE_CLASSIFY_TWO, superClassify_id];
    
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZMainClassifyOneModel *classify = [self p_createClassifyTwoByFMResultSet:retSet];
            [data addObject:classify];
        }
        [retSet close];
    }];
    return data;
}

- (NSArray <ZMainClassifyOneModel *>*)mainClassifyTwoData
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CLASSIFYS_TWO, MAIN_TABLE_CLASSIFY_TWO];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZMainClassifyOneModel *classify = [self p_createClassifyTwoByFMResultSet:retSet];
            [data addObject:classify];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deleteClassifyTwoBySuperId:(NSString *)superClassify_id
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_CLASSIFY_TWO, MAIN_TABLE_CLASSIFY_TWO,superClassify_id];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

- (BOOL)cleanClassifyTwo {
    NSString *sqlString = [NSString stringWithFormat:SQL_CLEAN_CLASSIFY_TWO, MAIN_TABLE_CLASSIFY_TWO];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

// Private Methods
- (ZMainClassifyOneModel *)p_createClassifyTwoByFMResultSet:(FMResultSet *)retSet
{
    ZMainClassifyOneModel *classify = [[ZMainClassifyOneModel alloc] init];
    classify.classify_id = [retSet stringForColumn:@"classify_id"];
    classify.name = [retSet stringForColumn:@"name"];
    classify.imageName = [retSet stringForColumn:@"imageName"];
    classify.superClassify_id = [retSet stringForColumn:@"superClassify_id"];
    
    return classify;
}



#pragma mark - search history
- (BOOL)createSearchHistoryTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_SEARCH_HISTORY_TABLE, MAIN_TABLE_SEARCH_HISTORY];
    return [self createTable:MAIN_TABLE_SEARCH_HISTORY withSQL:sqlString];
}


- (BOOL)updateMainSearchHistory:(ZHistoryModel *)history
{
    if (!history || history.search_title.length == 0) {
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_SEARCH_HISTORY, MAIN_TABLE_SEARCH_HISTORY];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(history.search_title),
                        TLNoNilString(history.search_type),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

/**
 *  更新history信息
 */
- (BOOL)updateMainSearchHistorys:(NSArray <ZHistoryModel *>*)historys{
    __block NSInteger index = 0;
    [historys enumerateObjectsUsingBlock:^(ZHistoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL update_ok = [self updateMainSearchHistory:obj];
        if (!update_ok) {
            index++;
        }
    }];
    if (index > 0) {
        return NO;
    }
    return YES;
}


- (NSArray <ZHistoryModel *>*)mainSearchHistoryBySpuerID:(NSString *)search_type
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_SEARCH_HISTORY_BY_ID, MAIN_TABLE_SEARCH_HISTORY, search_type];
    
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZHistoryModel *history = [self p_createSearchHistoryByFMResultSet:retSet];
            [data addObject:history];
        }
        [retSet close];
    }];
    return data;
}

- (NSArray <ZHistoryModel *>*)mainSearchHistoryData
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_SEARCH_HISTORY, MAIN_TABLE_SEARCH_HISTORY];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZHistoryModel *history = [self p_createSearchHistoryByFMResultSet:retSet];
            [data addObject:history];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deleteSearchHistoryBySuperId:(NSString *)search_type
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_SEARCH_HISTORY, MAIN_TABLE_SEARCH_HISTORY,search_type];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

- (BOOL)cleanSearchHistory {
    NSString *sqlString = [NSString stringWithFormat:SQL_CLEAN_SEARCH_HISTORY, MAIN_TABLE_SEARCH_HISTORY];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

// Private Methods
- (ZHistoryModel *)p_createSearchHistoryByFMResultSet:(FMResultSet *)retSet
{
    ZHistoryModel *history = [[ZHistoryModel alloc] init];
    history.search_type = [retSet stringForColumn:@"search_type"];
    history.search_title = [retSet stringForColumn:@"search_title"];
    
    return history;
}
@end
