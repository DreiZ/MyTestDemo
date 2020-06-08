//
//  ZDBMainStoreSQL.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#ifndef ZDBMainStoreSQL_h
#define ZDBMainStoreSQL_h

#pragma mark - banner
#define     MAIN_TABLE_BANNER                 @"mainBanner"

#define     SQL_CREATE_MAINBANNER_TABLE           @"CREATE TABLE IF NOT EXISTS %@(\
                                                    ad_id TEXT,\
                                                    ad_image TEXT,\
                                                    ad_url TEXT,\
                                                    ad_type TEXT, \
                                                    name TEXT,\
                                                    ad_type_content TEXT,\
                                                    ext0 TEXT,\
                                                    ext1 TEXT,\
                                                    ext2 TEXT,\
                                                    ext3 TEXT,\
                                                    ext4 TEXT,\
                                                    ext5 TEXT,\
                                                    PRIMARY KEY(ad_id))"

#define     SQL_UPDATE_MAINBANNER                 @"REPLACE INTO %@ ( ad_id, ad_image, ad_url, ad_type, name, ad_type_content, ext0, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_MAINBANNER_BY_ID           @"SELECT * FROM %@ WHERE ad_id = %@"

#define     SQL_SELECT_MAINBANNERS                @"SELECT * FROM %@"

#define     SQL_DELETE_MAINBANNER                 @"DELETE FROM %@ WHERE ad_id = %@"

#define     SQL_CLEAN_MAINBANNER                  @"DELETE FROM  %@"


#pragma mark - placeholder
#define     MAIN_TABLE_PLACEHOLDER                 @"placeholder"

#define     SQL_CREATE_PLACEHOLDER_TABLE           @"CREATE TABLE IF NOT EXISTS %@(\
                                                    ad_id TEXT,\
                                                    ad_image TEXT,\
                                                    ad_url TEXT,\
                                                    ad_type TEXT, \
                                                    name TEXT,\
                                                    ad_type_content TEXT,\
                                                    ext0 TEXT,\
                                                    ext1 TEXT,\
                                                    ext2 TEXT,\
                                                    ext3 TEXT,\
                                                    ext4 TEXT,\
                                                    ext5 TEXT,\
                                                    PRIMARY KEY(ad_id))"

#define     SQL_UPDATE_PLACEHOLDER                 @"REPLACE INTO %@ ( ad_id, ad_image, ad_url, ad_type, name, ad_type_content, ext0, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_PLACEHOLDER_BY_ID           @"SELECT * FROM %@ WHERE ad_id = %@"

#define     SQL_SELECT_PLACEHOLDERS                @"SELECT * FROM %@"

#define     SQL_DELETE_PLACEHOLDER                 @"DELETE FROM %@ WHERE ad_id = %@"

#define     SQL_CLEAN_PLACEHOLDER                  @"DELETE FROM %@"


#pragma mark - classify
#define     MAIN_TABLE_CLASSIFY                    @"classify"

#define     SQL_CREATE_CLASSIFY_TABLE              @"CREATE TABLE IF NOT EXISTS %@(\
                                                    classify_id TEXT,\
                                                    name TEXT,\
                                                    imageName TEXT,\
                                                    ext0 TEXT,\
                                                    ext1 TEXT,\
                                                    ext2 TEXT,\
                                                    ext3 TEXT,\
                                                    ext4 TEXT,\
                                                    ext5 TEXT,\
                                                    PRIMARY KEY(classify_id))"

#define     SQL_UPDATE_CLASSIFY                   @"REPLACE INTO %@ ( classify_id, name, imageName, ext0, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_CLASSIFY_BY_ID             @"SELECT * FROM %@ WHERE classify_id = %@"

#define     SQL_SELECT_CLASSIFYS                  @"SELECT * FROM %@"

#define     SQL_DELETE_CLASSIFY                   @"DELETE FROM %@ WHERE classify_id = %@"

#define     SQL_CLEAN_CLASSIFY                    @"DELETE FROM  %@"


#pragma mark - screen one
#define     MAIN_TABLE_CLASSIFY_ONE               @"classify_one"

#define     SQL_CREATE_CLASSIFY_ONE_TABLE         @"CREATE TABLE IF NOT EXISTS %@(\
                                                    classify_id TEXT,\
                                                    name TEXT,\
                                                    imageName TEXT,\
                                                    ext0 TEXT,\
                                                    ext1 TEXT,\
                                                    ext2 TEXT,\
                                                    ext3 TEXT,\
                                                    ext4 TEXT,\
                                                    ext5 TEXT,\
                                                    PRIMARY KEY(classify_id))"

#define     SQL_UPDATE_CLASSIFY_ONE                @"REPLACE INTO %@ ( classify_id, name, imageName, ext0, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_CLASSIFY_ONE_BY_ID          @"SELECT * FROM %@ WHERE classify_id = %@"

#define     SQL_SELECT_CLASSIFYS_ONE               @"SELECT * FROM %@"

#define     SQL_DELETE_CLASSIFY_ONE                @"DELETE FROM %@ WHERE classify_id = %@"

#define     SQL_CLEAN_CLASSIFY_ONE                 @"DELETE FROM %@"



#pragma mark - screen two
#define     MAIN_TABLE_CLASSIFY_TWO               @"classify_two"

#define     SQL_CREATE_CLASSIFY_TWO_TABLE         @"CREATE TABLE IF NOT EXISTS %@(\
                                                    classify_id TEXT,\
                                                    name TEXT,\
                                                    imageName TEXT,\
                                                    superClassify_id TEXT,\
                                                    ext1 TEXT,\
                                                    ext2 TEXT,\
                                                    ext3 TEXT,\
                                                    ext4 TEXT,\
                                                    ext5 TEXT,\
                                                    PRIMARY KEY(classify_id, superClassify_id))"

#define     SQL_UPDATE_CLASSIFY_TWO                @"REPLACE INTO %@ ( classify_id, name, imageName, superClassify_id, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_CLASSIFY_TWO_BY_ID          @"SELECT * FROM %@ WHERE  superClassify_id = %@"

#define     SQL_SELECT_CLASSIFYS_TWO               @"SELECT * FROM %@"

#define     SQL_DELETE_CLASSIFY_TWO                @"DELETE FROM %@ WHERE  superClassify_id = %@"

#define     SQL_CLEAN_CLASSIFY_TWO                 @"DELETE FROM  %@"



#pragma mark - search history
#define     MAIN_TABLE_HISTORYSEARCH               @"historySearch"

#define     SQL_CREATE_HISTORYSEARCH_TABLE         @"CREATE TABLE IF NOT EXISTS %@(\
                                                    search_type TEXT,\
                                                    search_title TEXT,\
                                                    ext0 TEXT,\
                                                    ext1 TEXT,\
                                                    ext2 TEXT,\
                                                    ext3 TEXT,\
                                                    ext4 TEXT,\
                                                    ext5 TEXT,\
                                                    PRIMARY KEY(search_type,search_title))"

#define     SQL_UPDATE_HISTORYSEARCH                @"REPLACE INTO %@ ( search_type, search_title, ext0, ext1, ext2, ext3, ext4, ext5) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_HISTORYSEARCH_BY_ID           @"SELECT * FROM %@ WHERE search_type = %@"

#define     SQL_SELECT_HISTORYSEARCHS_BY_ID          @"SELECT * FROM %@ WHERE search_type = %@"

#define     SQL_SELECT_HISTORYSEARCHS                @"SELECT * FROM %@"

#define     SQL_DELETE_HISTORYSEARCH                 @"DELETE FROM %@ WHERE search_id = %@"

#define     SQL_CLEAN_HISTORYSEARCH                  @"DELETE FROM %@"


#endif /* ZDBMainStoreSQL_h */
