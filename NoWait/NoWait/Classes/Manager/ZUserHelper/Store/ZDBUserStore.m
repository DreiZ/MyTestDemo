//
//  ZDBUserStore.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "ZDBUserStore.h"
#import "ZDBUserStoreSQL.h"
#import "ZUser.h"

@implementation ZDBUserStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [ZDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            DLog(@"DB: 用户表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_USER_TABLE, USER_TABLE_NAME];
    return [self createTable:USER_TABLE_NAME withSQL:sqlString];
}


- (BOOL)updateUser:(ZUser *)user
{
    if (!user || user.userCodeID.length == 0) {
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_USER, USER_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(user.userCodeID),
                        TLNoNilString(user.userID),
                        TLNoNilString(user.nikeName),
                        TLNoNilString(user.nikeName),
                        TLNoNilString(user.avatar),
                        TLNoNilString(user.sex),
                        TLNoNilString(user.token),
                        TLNoNilString(user.birthday),
                        TLNoNilString(user.phone),
                        @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (ZUser *)userByID:(NSString *)userCodeID
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_USER_BY_ID, USER_TABLE_NAME, userCodeID];
    __block ZUser * user;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            user = [self p_createUserByFMResultSet:retSet];
        }
        [retSet close];
    }];
    return user;
}

- (NSArray *)userData
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_USERS, USER_TABLE_NAME];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZUser *user = [self p_createUserByFMResultSet:retSet];
            [data addObject:user];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deleteUsersByUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_USER, USER_TABLE_NAME, uid];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

#pragma mark - # Private Methods
- (ZUser *)p_createUserByFMResultSet:(FMResultSet *)retSet
{
    ZUser *user = [[ZUser alloc] init];
    user.userID = [retSet stringForColumn:@"userID"];
    user.userCodeID = [retSet stringForColumn:@"uid"];
//    user.username = [retSet stringForColumn:@"username"];
    user.nikeName = [retSet stringForColumn:@"nikename"];
    user.avatar = [retSet stringForColumn:@"avatar"];
    user.sex = [retSet stringForColumn:@"remark"];
    user.token = [retSet stringForColumn:@"token"];
    user.birthday = [retSet stringForColumn:@"ext1"];
    user.phone = [retSet stringForColumn:@"ext2"];
//    uid, userID, username, nikename, avatar, remark, token, ext1, ext2, ext3, ext4, ext5)

    return user;
}

@end
