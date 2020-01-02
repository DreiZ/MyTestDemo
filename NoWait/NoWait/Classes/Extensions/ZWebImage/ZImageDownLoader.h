//
//  ZImageDownLoader.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZImageDownLoader : NSObject
/// 是否按队列顺序执行回调（默认NO）
@property (nonatomic, assign) BOOL useQueue;
/// 是否正在下载
@property (nonatomic, assign) BOOL isDownloading;
/// 当前任务数量
@property (nonatomic, assign) NSInteger curTaskCount;

- (void)addDownloadTaskWithUrl:(NSString *)urlString completeAction:(void (^)(BOOL success, UIImage *image))completeAction;
- (void)startDownload;
- (void)cancelDownload;

@end

NS_ASSUME_NONNULL_END
