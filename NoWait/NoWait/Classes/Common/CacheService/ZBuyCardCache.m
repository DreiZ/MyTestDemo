//
//  YYCache+BuyCard.m
//  hntx
//
//  Created by zzzon 2018/6/15.
//  Copyright © 2018年 LaKa. All rights reserved.
//

#import "ZBuyCardCache.h"
#import "YYKVStorage.h"
#import "ZFileManager.h"
#if __has_include(<sqlite3.h>)
#import <sqlite3.h>
#else
#import "sqlite3.h"
#endif

static NSString *const HNBuyCardDBMigrationTag = @"HNBuyCardDBMigrationTag";

@interface ZBuyCardCache()
@property (nonatomic, strong) NSMutableArray<NSString *> *dbMigrationkeys;
@property (nonatomic, strong) NSMutableArray<NSString *> *removeKeys;

@end

@implementation ZBuyCardCache

+ (instancetype)shareInstance
{
    static ZBuyCardCache *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [cacheFolder stringByAppendingPathComponent:@"BuyCard"];
        _instance = [[self alloc] initWithPath:path];
        _instance.dbMigrationkeys = [NSMutableArray array];
        _instance.removeKeys = [NSMutableArray array];
    });
    return _instance;
}
//
//- (NSString *)keyForStoreId:(NSString *)storeId
//{
//    return [NSString stringWithFormat:@"BuyCard:%@_%@", storeId, [HNPublicManager shareInstance].user.userID];
//}
//
//- (void)setGoods:(NSArray<HNStoreGoods *>*)goods
//         forStoreId:(NSString *)storeId
//{
//    [self setObject:goods forKey:[self keyForStoreId:storeId]];
//}
//
//- (NSArray<HNStoreGoods *>*)goodsForStoreId:(NSString *)storeId
//{
//    id obj = [self objectForKey:[self keyForStoreId:storeId]];
//    return obj ?: @[];
//}
//
//- (void)removeAllForStoreId:(NSString *)storeId
//{
//    [self removeObjectForKey:[self keyForStoreId:storeId]];
//}
//
//#pragma mark - Item
//
//- (void)updateGoods:(HNStoreGoods *)goods forStoreId:(NSString *)storeId
//{
//    NSMutableArray<HNStoreGoods *> *goodsArray = [NSMutableArray arrayWithArray:[self goodsForStoreId:storeId]];
//
//    NSInteger index = [self indexForGoods:goods storeId:storeId];
//    if(index != NSNotFound) {
//        [goodsArray replaceObjectAtIndex:index withObject:goods];
//    }else {
//        [goodsArray insertObject:goods atIndex:0];
//    }
//
//    [self setGoods:goodsArray forStoreId:storeId];
//}
//
//- (void)removeGoods:(HNStoreGoods *)goods forStoreId:(NSString *)storeId
//{
//    NSMutableArray<HNStoreGoods *> *goodsArray = [NSMutableArray arrayWithArray:[self goodsForStoreId:storeId]];
//
//    NSInteger index = [self indexForGoods:goods storeId:storeId];
//    if(index != NSNotFound) {
//        [goodsArray removeObjectAtIndex:index];
//        [self setGoods:goodsArray forStoreId:storeId];
//    }
//}
//
//#pragma mark - Count
//
//- (void)addGoodsCount:(HNStoreGoods *)goods forStoreId:(NSString *)storeId
//{
//    NSMutableArray<HNStoreGoods *> *goodsArray = [NSMutableArray arrayWithArray:[self goodsForStoreId:storeId]];
//
//    NSInteger index = [self indexForGoods:goods storeId:storeId];
//    if(index != NSNotFound) {
//
//        HNStoreGoods *originGoods = goodsArray[index];
//        goods.count = (originGoods.count + 1);
//        [goodsArray replaceObjectAtIndex:index withObject:goods];
//
//    }else {
//        goods.count = 1;
//        [goodsArray insertObject:goods atIndex:0];
//    }
//    [self setGoods:goodsArray forStoreId:storeId];
//}
//
//- (void)subGoodsCount:(HNStoreGoods *)goods forStoreId:(NSString *)storeId
//{
//    NSMutableArray<HNStoreGoods *> *goodsArray = [NSMutableArray arrayWithArray:[self goodsForStoreId:storeId]];
//
//    NSInteger index = [self indexForGoods:goods storeId:storeId];
//    if(index != NSNotFound) {
//        HNStoreGoods *goods = goodsArray[index];
//        if(goods.count > 1) {
//            goods.count--;
//        }
//    }
//    [self setGoods:goodsArray forStoreId:storeId];
//}
//
//- (void)setGoods:(HNStoreGoods *)goods
//           count:(NSInteger)count
//      forStoreId:(NSString *)storeId
//{
//    NSMutableArray<HNStoreGoods *> *goodsArray = [NSMutableArray arrayWithArray:[self goodsForStoreId:storeId]];
//
//    NSInteger index = [self indexForGoods:goods storeId:storeId];
//    if(index != NSNotFound) {
//        HNStoreGoods *goods = goodsArray[index];
//        goods.count = count;
//    }else {
//        [goodsArray insertObject:goods atIndex:0];
//    }
//    [self setGoods:goodsArray forStoreId:storeId];
//}
//
//#pragma mark - Helper
//
//- (NSInteger)indexForGoods:(HNStoreGoods *)goods storeId:(NSString *)storeId
//{
//    __block NSInteger index = NSNotFound;
//    NSArray<HNStoreGoods *> *goodsArray = [self goodsForStoreId:storeId];
//
//    [goodsArray enumerateObjectsUsingBlock:^(HNStoreGoods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        if([obj.goodsId isEqualToString:goods.goodsId]) {
//            index = idx;
//            *stop = YES;
//        }
//    }];
//    return index;
//}

#pragma mark - 修复数据库迁移问题
//
//+ (void)handleDBMigration
//{
//    BOOL hasMigration = [[NSUserDefaults standardUserDefaults] boolForKey:[self hasMegratedDBTagKey]];
//    if(hasMigration == NO) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [[HNBuyCardCache shareInstance].removeKeys removeAllObjects];
//            [[HNBuyCardCache shareInstance] handleDBMigration];
//        });
//    }
//}

+ (NSString *)hasMegratedDBTagKey
{
    return [NSString stringWithFormat:@"%@_%@", HNBuyCardDBMigrationTag, [ZUserHelper sharedHelper].user.userCodeID];
}
//
//
//- (void)handleDBMigration
//{
//    NSString * dbpath = [[[ZFileManager getDocumentDirectory] stringByAppendingPathComponent:@"BuyCard"] stringByAppendingPathComponent:@"manifest.sqlite"];
//    sqlite3 *db;
//    int result = sqlite3_open(dbpath.UTF8String, &db);
//    if (result != SQLITE_OK) {
//        return ;
//    }
//
//    char *error;
//    sqlite3_exec(db, @"select key from manifest".UTF8String, dbQueryResult, NULL, &error);
//    if (error) {
//        NSLog(@"%s line:%d sqlite exec error (%d): %s", __FUNCTION__, __LINE__, result, error);
//        sqlite3_free(error);
//    }else {
//        sqlite3_close(db);
//    }
//
//    // 这个是为了修复了5.0.0数据的迁移问题; 2000是根据服务器最多的店铺
//    // 这是因为5.0.0版本的时候，key做了md5的操作
//
//    NSMutableArray *goods = [NSMutableArray array];
//    [self.dbMigrationkeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.removeKeys addObject:obj];
//        NSArray<HNStoreGoods *> *storegoods = (NSArray *)[self objectForKey:obj];
//        [storegoods enumerateObjectsUsingBlock:^(HNStoreGoods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [goods addObject:obj];
//        }];
//    }];
//
//    // 上报以前的数据到服务器
//    NSMutableArray *parameters = [NSMutableArray array];
//    [goods enumerateObjectsUsingBlock:^(HNStoreGoods *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        HNAddToCartParameters *parameter = [[HNAddToCartParameters alloc] init];
//        parameter.goodsId = obj.goodsId;
//        parameter.goodsNum = obj.count;
//        [parameters addObject:parameter];
//    }];
//
//    if(parameters.count > 0) {
//        [HNDirectedPurchaseAPIManager addGoodsToCart:parameters success:^{
//            NSString *key = [[HNBuyCardCache class] hasMegratedDBTagKey];
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
//            [self.removeKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [self removeObjectForKey:obj];
//            }];
//        } failure:nil];
//    }
//}
//
////callback回调函数print_result_cb的编写，其中data为sqlite3_exec中的第四个参数
////第二个参数是栏的数目，第三个是栏的名字，第四个为查询得到的值得。
////这两个函数输出所有查询到的结果
////有多少列回调函数就会执行多少次。
//int dbQueryResult(void* data,int columns,char** values,char** names)
//{
//    for(int i = 0; i < columns; i ++) {
//        NSString * key = [NSString stringWithCString:values[i] encoding:NSUTF8StringEncoding];
//        if(key) {
//            [[HNBuyCardCache shareInstance].dbMigrationkeys addObject:key];
//        }
//    }
//    return 0;
//}
@end
