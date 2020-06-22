//
//  ZFileUploadManager.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFileUploadTask.h"
#import "ZFileUploadDataModel.h"


@interface ZFileUploadManager : NSObject
@property (nonatomic, assign,getter=isUploading) BOOL uploading;

@property (nonatomic,strong) NSMutableArray *taskList;

@property (nonatomic,strong) NSMutableArray *taskModelList;

+ (ZFileUploadManager *)sharedInstance;

+ (void)addTaskToUploadWith:(ZFileUploadTask *)task;

+ (void)addTaskDataToUploadWith:(ZFileUploadDataModel *)taskData;

/**
异步串行
*/
- (void)asyncSerialUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray progress:(void(^)(CGFloat p, NSInteger index))progress completion:(void(^)(id obj))completion;

/**
异步并行上传多张图片（用常量监控上传）(添加)
*/
- (void)asyncConcurrentConstUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray uploading:(void (^)(CGFloat p, NSInteger index))uploading completion:(void (^)(id))completion;

/**
 异步并行
 上传图片-用dispatch_group监控所有上传完成动作-缺点是不能实时往group里添加任务
 */
- (void)asyncConcurrentGroupUpload:(NSMutableArray <ZFileUploadDataModel *>*)dataArray uploading:(void(^)(CGFloat p, NSInteger index))uploading completion:(void (^)(id))completion;
@end

