//
//  ZFileManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZFileManager.h"

static ZFileManager *fileManager;

@interface ZFileManager ()

@end

@implementation ZFileManager

+ (ZFileManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        fileManager = [[ZFileManager alloc] init];
    });
    return fileManager;
}

#pragma mark -获取沙盒Document的文件目录
+ (NSString*)getDocumentDirectory{
    return[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject];

}

#pragma mark -获取沙盒Library的文件目录
+ (NSString*)getLibraryDirectory{
    return[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)lastObject];

}

#pragma mark -获取沙盒Caches的文件目录
+ (NSString*)getCachesDirectory{
    return[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)lastObject];

}

#pragma mark -获取沙盒Preference的文件目录
+ (NSString*)getPreferencePanesDirectory{
    return[NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory,NSUserDomainMask,YES)lastObject];

}

#pragma mark -获取沙盒tmp的文件目录
+ (NSString*)getTmpDirectory {
    return NSTemporaryDirectory();
}

+ (BOOL)removeDocumentWithFilePath:(NSString*)filePath {
    BOOL isRemove = false;

    NSFileManager* fileManager=[NSFileManager defaultManager];

    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        isRemove = [fileManager removeItemAtPath:filePath error:nil];
    }
    
    return isRemove;
}


//读取文件
+ (NSMutableArray *)readFileWithPath:(NSString *)path folder:(NSString *)docName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *document = path;
    NSString *folder = document;
    
    if (ValidStr(docName)) {
        folder = [document stringByAppendingPathComponent:docName];
    }
    
    NSArray *fileList ;
    fileList = [fileManager contentsOfDirectoryAtPath:folder error:NULL];
    
    NSMutableArray *fileArr = @[].mutableCopy;
    for (NSString *file in fileList) {
        NSString *path = [folder stringByAppendingPathComponent:file];
        [fileArr addObject:@{@"path":SafeStr(path),@"file_name":SafeStr(file)}];
        DLog(@"file=%@",file);
        DLog(@"得到的路径=%@",path);
    }
    return fileArr;
}

+ (void)writeFileWithStr:(NSString *)content {
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);

    NSString *docDir = [paths objectAtIndex:0];
    if(!docDir) {
        NSLog(@"Documents 目录未找到");
    }

    NSArray *array = [[NSArray alloc]initWithObjects:content,@"content",nil];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"textFile.txt"];

    [array writeToFile:filePath atomically:YES];
}
@end
