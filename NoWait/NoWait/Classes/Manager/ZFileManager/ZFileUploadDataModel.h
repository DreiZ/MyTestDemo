//
//  ZFileUploadDataModel.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    /** 等待状态*/
    ZUploadStateWaiting = 1,
    /** 正在上传状态*/
    ZUploadStateOnGoing = 2,
    /** 暂停状态*/
    ZUploadStatePaused = 3,
    /** 上传错误状态*/
    ZUploadStateError = 4,
    /** 完成状态*/
    ZUploadStateFinished = 5,
    /** 正在压缩状态*/
    ZUploadStateZiping = 6,
} ZUploadState;


typedef enum : NSUInteger {
    /** image */
    ZUploadTypeImage = 1,
    /** video */
    ZUploadTypeVideo = 2,
} ZUploadType;


@interface ZFileUploadDataModel : NSObject
@property (nonatomic, strong) void(^progressBlock)(int64_t, int64_t);
@property (nonatomic, strong) void(^errorBlock)(NSError *);
@property (nonatomic, strong) void(^completeBlock)(id);

@property (nonatomic,strong) UIImage *image;

//上传后url
@property (nonatomic,strong) NSString *image_url;

//上传后url
@property (nonatomic,strong) NSString *video_url;
/**
 任务id
 */
@property (copy,nonatomic)NSString *taskId;
/**
 任务名字
 */
@property (copy,nonatomic)NSString *taskName;
/**
 任务类型
 */
@property (assign,nonatomic)ZUploadType taskType;
/**
 文件地址
 */
@property (copy,nonatomic)NSString *filePath;
/**
 asset
 */
@property (copy,nonatomic)PHAsset *asset;
/**
 文件名
 */
@property (copy,nonatomic)NSString *fileName;
/**
 描述信息
 */
@property (copy,nonatomic)NSString *desc;
/**
 创建时间 时间戳
 */
@property (assign,nonatomic)NSTimeInterval createTime;
/**
 更新时间 时间戳
 */
@property (assign,nonatomic)NSTimeInterval updateTime;

/**
 任务的状态
 */
@property (assign,nonatomic)ZUploadState taskState;

-(void)getFilePath:(void(^)(NSString *))success;
@end

