//
//  TLDownloadRequest.h
//  TLChat
//
//  Created by ZZZ on 2017/7/14.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import "TLBaseRequest.h"

@interface TLDownloadRequest : TLBaseRequest

/// 下载缓存路径
@property (nonatomic, strong) NSString *downloadPath;

/// 下载进度
@property (nonatomic, copy) TLRequestProgressBlock downloadProgressAction;

@end
