//
//  ZCacheFactory.h
//  LKKit-a9bc1bde
//
//  Created by zzzon 2018/4/12.
//

#import <Foundation/Foundation.h>
#import <YYKit/YYCache.h>

#define HN_Key(obj)      NSStringFromClass([obj class])
#define HN_ArrayKey(obj) [NSString stringWithFormat:@"%@_array",NSStringFromClass([obj class])]

@interface ZCacheFactory : NSObject

+ (YYCache *)defaultCache;

/**
当前用户缓存容器
 */
+ (YYCache *)currentUserCache;

/**
 根据名字获取缓存的对象，存在cache路径下

 @param name 缓存的名称
 @return 缓存对象
 */
+ (YYCache *)cacheWithName:(NSString *)name;

/**
 根据路径来获取缓存对象， 自定义路径

 @param path 保存的路径
 @return 缓存对象
 */
+ (YYCache *)cacheWithPath:(NSString *)path;

+(void)removeObjectForKey:(NSString *)key;

@end

static inline YYCache *ZDefaultCache(void) {
    return [ZCacheFactory defaultCache];
}

static inline YYCache *ZCurrentUserCache(void) {
    return [ZCacheFactory currentUserCache];
}

