//
//  ZDBUserStore.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/16.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import "ZDBBaseStore.h"
@class ZUser;

NS_ASSUME_NONNULL_BEGIN

@interface ZDBUserStore : ZDBBaseStore

/**
 *  更新用户信息
 */
- (BOOL)updateUser:(ZUser *)user;

/**
 *  获取用户信息
 */
- (ZUser *)userByID:(NSString *)userID;

/**
 *  查询所有用户
 */
- (NSArray *)userData;

/**
 *  删除用户
 */
- (BOOL)deleteUsersByUid:(NSString *)uid;


@end

NS_ASSUME_NONNULL_END
