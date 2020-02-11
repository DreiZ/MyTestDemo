//
//  ZDBUserStoreSQL.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/16.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#ifndef ZDBUserStoreSQL_h
#define ZDBUserStoreSQL_h


#define     USER_TABLE_NAME                 @"users"

#define     SQL_CREATE_USER_TABLE           @"CREATE TABLE IF NOT EXISTS %@(\
uid TEXT,\
userID TEXT,\
username TEXT,\
nikename TEXT, \
avatar TEXT,\
remark TEXT,\
token TEXT,\
ext1 TEXT,\
ext2 TEXT,\
ext3 TEXT,\
ext4 TEXT,\
ext5 TEXT,\
PRIMARY KEY(userID))"

#define     SQL_UPDATE_USER                 @"REPLACE INTO %@ ( uid, userID, username, nikename, avatar, remark, token, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

#define     SQL_SELECT_USER_BY_ID           @"SELECT * FROM %@ WHERE userID = %@"

#define     SQL_SELECT_USERS                @"SELECT * FROM %@"

#define     SQL_DELETE_USER                 @"DELETE FROM %@ WHERE userID = %@"



#endif /* ZDBUserStoreSQL_h */
