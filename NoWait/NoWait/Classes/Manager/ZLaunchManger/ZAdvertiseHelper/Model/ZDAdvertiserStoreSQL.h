//
//  ZDAdvertiserStoreSQL.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/18.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#ifndef ZDAdvertiserStoreSQL_h
#define ZDAdvertiserStoreSQL_h


#define     ADVERTISER_TABLE_NAME              @"advertiser"


#define     SQL_CREATE_ADVERTISER_TABLE        @"CREATE TABLE IF NOT EXISTS %@(\
bannerId TEXT,\
type TEXT,\
name TEXT,\
title TEXT,\
image TEXT,\
url TEXT,\
content TEXT,\
status TEXT,\
drive TEXT,\
directive TEXT,\
parameter TEXT,\
ext1 TEXT,\
ext2 TEXT,\
ext3 TEXT,\
ext4 TEXT,\
ext5 TEXT,\
PRIMARY KEY(bannerId))"



#define     SQL_ADD_ADVERTISER                 @"REPLACE INTO %@ ( bannerId, type, name, title, image, url, content, status, drive, directive, parameter, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"


#define     SQL_SELECT_ADVERTISER              @"SELECT * FROM %@"


#define     SQL_DELETE_ADVERTISER              @"DELETE FROM %@ "
// @"DELETE FROM %@ WHERE bannerId = '%@'"
#endif /* ZDAdvertiserStoreSQL_h */
