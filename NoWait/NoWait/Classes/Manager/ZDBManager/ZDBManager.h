//
//  ZDBManager.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZDBManager : NSObject

/**
 *  DB队列（除IM相关）
 */
@property (nonatomic, strong) FMDatabaseQueue *commonQueue;

/**
 *  与IM相关的DB队列
 */
@property (nonatomic, strong) FMDatabaseQueue *messageQueue;

+ (ZDBManager *)sharedInstance;

- (void)loginout;
@end

NS_ASSUME_NONNULL_END
