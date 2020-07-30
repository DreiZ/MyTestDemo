//
//  YYCache+BuyCard.h
//  hntx
//
//  Created by zzz on 2018/6/15.
//  Copyright © 2018年 LaKa. All rights reserved.
//

#import "YYCache.h"

@interface ZBuyCardCache : YYCache
/**
 获取购物车的缓存对象
 */
+ (instancetype)shareInstance;


+ (void)handleDBMigration;

@end
