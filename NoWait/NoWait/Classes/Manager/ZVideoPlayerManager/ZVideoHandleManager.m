//
//  ZVideoHandleManager.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZVideoHandleManager.h"
#import <AVFoundation/AVFoundation.h>

@interface ZVideoHandleManager ()

@end

@implementation ZVideoHandleManager


- (void)videoCompressWithSourceVideoPathString:(NSString *)sourceVideoPathString
                                  CompressType:(NSString *)compressType
                          CompressSuccessBlock:(SuccessBlock)compressSuccessBlock
                              CompressFailedBlock:(FailedBlock)compressFailedBlock
                          CompressNotSupportBlock:(NotSupportBlock)compressNotSupportBlock{
    NSLog(@"视频压缩中...");
    
    [WYVideoCompressTools compressVideoWithSourceVideoPathString:sourceVideoPathString CompressType:compressType CompressSuccessBlock:^(NSString *compressVideoPathString) {
        compressSuccessBlock(compressVideoPathString);
        NSLog(@"视频压缩结束");
        
//
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"视频压缩成功了!" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
//        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//
//            // 播放效果对比
//            NSURL *sourceVideoUrl = [NSURL fileURLWithPath:self.sourceVideoPathString];
//            AVPlayer *videoPlayer1 = [AVPlayer playerWithURL:sourceVideoUrl];
//            AVPlayerLayer *playerLayer1 = [AVPlayerLayer playerLayerWithPlayer:videoPlayer1];
//            playerLayer1.backgroundColor = [UIColor redColor].CGColor;
//            playerLayer1.frame = CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 64) / 2.0);
//            [self.view.layer addSublayer:playerLayer1];
//            [videoPlayer1 play];
//
//            NSURL *compressVideoUrl = [NSURL fileURLWithPath:compressVideoPathString];
//            AVPlayer *videoPlayer2 = [AVPlayer playerWithURL:compressVideoUrl];
//            AVPlayerLayer *playerLayer2 = [AVPlayerLayer playerLayerWithPlayer:videoPlayer2];
//            playerLayer2.backgroundColor = [UIColor orangeColor].CGColor;
//            playerLayer2.frame = CGRectMake(0, (kScreenHeight - 64) / 2.0, kScreenWidth, (kScreenHeight - 64) / 2.0);
//            [self.view.layer addSublayer:playerLayer2];
//            [videoPlayer2 play];
//
//            // 文件大小对比
//            NSData *sourceVideoData = [NSData dataWithContentsOfFile:self.sourceVideoPathString];
//            float sourceVideoSize = (float)sourceVideoData.length / 1024.0 / 1024.0;
//            UILabel *sourceVideoSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 20)];
//            sourceVideoSizeLabel.backgroundColor = [UIColor yellowColor];
//            sourceVideoSizeLabel.text = [NSString stringWithFormat:@"源视频 : %.2fM", sourceVideoSize];
//            [self.view addSubview:sourceVideoSizeLabel];
//
//            NSData *compressVideoData = [NSData dataWithContentsOfFile:compressVideoPathString];
//            float compressVideoSize = (float)compressVideoData.length / 1024.0 / 1024.0;
//            UILabel *compressVideoSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (kScreenHeight - 64) / 2.0, 160, 20)];
//            compressVideoSizeLabel.backgroundColor = [UIColor greenColor];
//            compressVideoSizeLabel.text = [NSString stringWithFormat:@"压缩视频 : %.2fM", compressVideoSize];
//            [self.view addSubview:compressVideoSizeLabel];
//        }];
//        [alertController addAction:confirmAction];
//        [self presentViewController:alertController animated:YES completion:nil];
    } CompressFailedBlock:^{
        compressFailedBlock();
        NSLog(@"视频压缩结束");
    } CompressNotSupportBlock:^{
        compressNotSupportBlock();
        NSLog(@"视频压缩结束");
//        @"不支持当前压缩格式哦!"
    }];
    
}
@end
