//
//  ZVideoHandleManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZVideoHandleManager.h"
#import <AVFoundation/AVFoundation.h>

static ZVideoHandleManager *videoHandleManager;
@interface ZVideoHandleManager ()

@end

@implementation ZVideoHandleManager

+ (ZVideoHandleManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        videoHandleManager = [[ZVideoHandleManager alloc] init];
    });
    return videoHandleManager;
}

- (void)videoCompressWithSourceVideoPathString:(NSString *)sourceVideoPathString
                                  CompressType:(NSString *)compressType
                          CompressSuccessBlock:(SuccessBlock)compressSuccessBlock
                              CompressFailedBlock:(FailedBlock)compressFailedBlock
                          CompressNotSupportBlock:(NotSupportBlock)compressNotSupportBlock{
    DLog(@"视频压缩中...");
    [WYVideoCompressTools compressVideoWithSourceVideoPathString:sourceVideoPathString CompressType:compressType CompressSuccessBlock:^(NSString *compressVideoPathString) {
        compressSuccessBlock(compressVideoPathString);
        [[ZVideoPlayerManager sharedInstance] compressVideoWithUrl:sourceVideoPathString oldUrl:compressVideoPathString];
        DLog(@"视频压缩结束");
        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"视频压缩成功了!" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
//        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    } CompressFailedBlock:^{
        compressFailedBlock();
        DLog(@"视频压缩结束");
    } CompressNotSupportBlock:^{
        compressNotSupportBlock();
        DLog(@"视频压缩结束");
//        @"不支持当前压缩格式哦!"
    }];
    
}
@end
