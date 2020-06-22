//
//  ZFileUploadTask.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFileUploadDataModel.h"

@interface ZFileUploadTask : NSObject

/**
 数据库中的Model数据
 */
@property (strong,nonatomic) ZFileUploadDataModel *model;
/**
 进度
 */
@property (assign,nonatomic) CGFloat progress;
/**
 速度
 */
@property (assign,nonatomic) CGFloat speed;

/**
 session 由manager传过来
 */
@property (strong,nonatomic) NSURLSession *session;
/**
 自己懒加载创建
 */
@property (strong,nonatomic) NSURLSessionTask *uploadTask;

/**
 当前下载的字节数 用于计算速度
 */
@property (assign,nonatomic) int64_t courrentBytes;


@end

