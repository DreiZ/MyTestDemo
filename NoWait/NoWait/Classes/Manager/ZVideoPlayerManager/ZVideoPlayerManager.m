//
//  ZVideoPlayerManager.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2019/6/11.
//  Copyright © 2019 zhuang zhang. All rights reserved.
//

#import "ZVideoPlayerManager.h"
#import "AppDelegate.h"
#import <AVKit/AVKit.h>
#import "ZFileManager.h"
#import "ZAVPlayerViewController.h"

static ZVideoPlayerManager *videoPlayerManager;


@interface ZVideoPlayerManager ()
@property (nonatomic,strong) UIView *compressView;
@property (nonatomic,strong) AVPlayer *videoPlayer1;
@property (nonatomic,strong) AVPlayerLayer *playerLayer1;
@property (nonatomic,strong) AVPlayer *videoPlayer2;
@property (nonatomic,strong) AVPlayerLayer *playerLayer2;
@property (nonatomic,strong) UILabel *sourceVideoSizeLabel;
@property (nonatomic,strong) UILabel *compressVideoSizeLabel;
@property (nonatomic,strong) ZAVPlayerViewController *apvc;
@end


@implementation ZVideoPlayerManager
+ (ZVideoPlayerManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        videoPlayerManager = [[ZVideoPlayerManager alloc] init];
    });
    return videoPlayerManager;
}


- (void)playVideoWithUrl:(NSString *)url title:(NSString *)title {
    if (!_apvc) {
        _apvc = [[ZAVPlayerViewController alloc] init];
    }
    
    NSURL *remoteURL = [NSURL URLWithString:url];
    AVPlayer *player = [AVPlayer playerWithURL:remoteURL];
    _apvc.player = player;
    _apvc.showsPlaybackControls = YES;
    if (@available(iOS 11.0, *)) {
        _apvc.entersFullScreenWhenPlaybackBegins = YES;
    } else {
        // Fallback on earlier versions
    }//开启这个播放的时候支持（全屏）横竖屏哦
    if (@available(iOS 11.0, *)) {
        _apvc.exitsFullScreenWhenPlaybackEnds = YES;
    } else {
        // Fallback on earlier versions
    }//
    
//    apvc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].getCurrentVC presentViewController:_apvc animated:YES completion:^{
//        [apvc.player play];
    }];
}


#pragma mark -compress
- (UIView *)compressView {
    if (!_compressView) {
        _compressView = [[UIView alloc] init];
        _compressView.layer.masksToBounds = YES;
        _compressView.backgroundColor = [UIColor colorBlackBGDark];
        
        __weak typeof(self) weakSelf = self;
        UIButton *close = [[UIButton alloc] initWithFrame:CGRectZero];
        close.backgroundColor = [UIColor colorGrayBG];
        close.layer.masksToBounds = YES;
        close.layer.cornerRadius = CGFloatIn750(35);
        close.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [close setImage:[UIImage imageNamed:@"clean_attachment_icon"] forState:UIControlStateNormal];
        [close bk_addEventHandler:^(id sender) {
            [weakSelf.videoPlayer1 pause];
            [weakSelf.videoPlayer2 pause];
            [weakSelf.compressView removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        [_compressView addSubview:close];
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.compressView.mas_left).offset(CGFloatIn750(20));
            make.top.equalTo(self.compressView.mas_top).offset(CGFloatIn750(-60)+kTopHeight);
            make.width.height.mas_equalTo(CGFloatIn750(70));
        }];
        
        
        _sourceVideoSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTopHeight, 160, 20)];
        _sourceVideoSizeLabel.backgroundColor = [UIColor redColor];
        [_compressView addSubview:_sourceVideoSizeLabel];
       
        _compressVideoSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (kScreenHeight - 64) / 2.0, 160, 20)];
        _compressVideoSizeLabel.backgroundColor = [UIColor greenColor];
        
        [_compressView addSubview:_compressVideoSizeLabel];
    }
    return _compressView;
}

- (void)compressVideoWithUrl:(NSString *)url oldUrl:(NSString *)oldUrl
{
    if (_videoPlayer1) {
        [_videoPlayer1 pause];
    }
    if (_videoPlayer2) {
        [_videoPlayer2 pause];
    }
//
//    [_playerLayer1 removeFromSuperlayer];
//    [_playerLayer2 removeFromSuperlayer];
//    _videoPlayer1 = nil;
//    _videoPlayer2 = nil;
//    _playerLayer1 = nil;
//    _playerLayer2 = nil;
    
    // 播放效果对比
    NSURL *sourceVideoUrl = [NSURL fileURLWithPath:oldUrl];
    _videoPlayer1 = [AVPlayer playerWithURL:sourceVideoUrl];
    _playerLayer1 = [AVPlayerLayer playerLayerWithPlayer:_videoPlayer1];
    _playerLayer1.frame = CGRectMake(0, kTopHeight+40, kScreenWidth, (kScreenHeight - 264) / 2.0);
    [self.compressView.layer addSublayer:_playerLayer1];

    NSURL *compressVideoUrl = [NSURL fileURLWithPath:url];
    _videoPlayer2 = [AVPlayer playerWithURL:compressVideoUrl];
    _playerLayer2 = [AVPlayerLayer playerLayerWithPlayer:_videoPlayer2];
    _playerLayer2.frame = CGRectMake(0, (kScreenHeight - 264) / 2.0 + 40, kScreenWidth, (kScreenHeight - 264) / 2.0);
    [self.compressView.layer addSublayer:_playerLayer2];
    [self.compressView addSubview:_compressVideoSizeLabel];
    [self.compressView addSubview:_sourceVideoSizeLabel];
    
    // 文件大小对比
    NSData *sourceVideoData = [NSData dataWithContentsOfFile:oldUrl];
    float sourceVideoSize = (float)sourceVideoData.length / 1024.0 / 1024.0;
    _sourceVideoSizeLabel.text = [NSString stringWithFormat:@"源视频 : %.2fM", sourceVideoSize];
    
    NSData *compressVideoData = [NSData dataWithContentsOfFile:url];
           float compressVideoSize = (float)compressVideoData.length / 1024.0 / 1024.0;
    _compressVideoSizeLabel.text = [NSString stringWithFormat:@"压缩视频 : %.2fM", compressVideoSize];
    
    self.compressView.alpha = 0;
    self.compressView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AppDelegate shareAppDelegate].window addSubview:self.compressView];
        [UIView animateWithDuration:0.3 animations:^{
            self.compressView.alpha = 1;
            self.compressView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
            [self.videoPlayer1 play];
            [self.videoPlayer2 play];
        }];
    });
    DLog(@"---file  %@  \n %@",sourceVideoUrl, compressVideoUrl);
}

- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
      
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    if (!asset) {
        return nil;
    }
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
      
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
      
    if(!thumbnailImageRef)
    NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
      
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
      
    return thumbnailImage;
}

- (void)getVideoPreViewImageURL:(NSURL *)path placeHolderImage:(UIImage *)placeHolder placeHolderBlock:(void(^)(UIImage *))placeHolderBlock complete:(void(^)(UIImage *))completeBlock
{
    NSString *name = [[path absoluteString] md5String];//视频链接转MD5作为图片的名字
    //NSString *name = [path absoluteString];
//    NSString *PATH = [NSString stringWithFormat:@"%@/Documents/videoFolder/%@.png",NSHomeDirectory(),name];
    NSString *PATH = [NSString stringWithFormat:@"%@/%@/%@.png",[ZFileManager getDocumentDirectory],ImageCacheFolderOfVideo,name];
    UIImage *imagePath = [[UIImage alloc] initWithContentsOfFile:PATH];
    if (imagePath) {
        //本地有缓存图片，加载本地图片并return
        if (completeBlock) {
            completeBlock(imagePath);
        }
        return;
    }else{
        if (placeHolderBlock) {
            placeHolderBlock(placeHolder);
        }
    }
    
    dispatch_group_t group = dispatch_group_create();
    __block UIImage *videoImage;
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
        AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        assetGen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 2);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        videoImage = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        
        //创建文件夹
//        NSString *folder = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/videoFolder"];
        NSString *folder = [NSString stringWithFormat:@"%@/%@",[ZFileManager getDocumentDirectory],ImageCacheFolderOfVideo];
        [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:NO attributes:nil error:nil];
        [UIImagePNGRepresentation(videoImage) writeToFile:PATH atomically:YES];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //主线程更新UI
        if (completeBlock) {
            completeBlock(videoImage);
        }
    });
}
@end
