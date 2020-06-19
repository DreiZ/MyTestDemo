//
//  ZFileManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZFileManager : NSObject

+ (NSString*)getDocumentDirectory;

#pragma mark -获取沙盒Library的文件目录
+ (NSString*)getLibraryDirectory;

#pragma mark -获取沙盒Caches的文件目录
+ (NSString*)getCachesDirectory;

#pragma mark -获取沙盒Preference的文件目录
+ (NSString*)getPreferencePanesDirectory;

#pragma mark -获取沙盒tmp的文件目录
+ (NSString*)getTmpDirectory;

//删除文件
+ (BOOL)removeDocumentWithFilePath:(NSString*)filePath ;

//读取文件
+ (NSMutableArray *)readFileWithPath:(NSString *)path folder:(NSString *)docName;
@end

