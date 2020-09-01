//
//  LKCacheFactory.m
//  LKKit-a9bc1bde
//
//  Created by zzzon 2018/4/12.
//

#import "ZCacheFactory.h"
#import "NSString+YYAdd.h"

static NSMutableDictionary * _cacheManagers = nil;

@implementation ZCacheFactory

+ (YYCache *)defaultCache
{
    return [self cacheWithName:@"Default"];
}

+(void)removeObjectForKey:(NSString *)key {
    [ZDefaultCache() removeObjectForKey:key];
}

+ (YYCache *)currentUserCache
{
    NSString *userId = [ZUserHelper sharedHelper].user.userCodeID;
    return [self cacheWithName:[NSString stringWithFormat:@"user%@", userId]];
}

+ (YYCache *)cacheWithName:(NSString *)name;
{
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [cacheFolder stringByAppendingPathComponent:name];
    return [self cacheWithPath:path];
}

+ (YYCache *)cacheWithPath:(NSString *)path
{
    if (!ValidStr(path)) {
        return nil;
    }
    
    if(_cacheManagers == nil) {
        _cacheManagers = [NSMutableDictionary dictionary];
    }
    
    NSString *key = [path md5String];
    
    YYCache *cache = _cacheManagers[key];
    if (cache == nil) {
        cache = [[YYCache alloc] initWithPath:path];
        _cacheManagers[key] = cache;
    }
    return cache;
}

@end
