//
//  ZVideoPlayerManager.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2019/6/11.
//  Copyright © 2019 zhuang zhang. All rights reserved.
//

#import "ZVideoPlayerManager.h"
#import "AppDelegate.h"
#import "SJVideoPlayer.h"
#import <SJBaseVideoPlayer.h>


static ZVideoPlayerManager *videoPlayerManager;


@interface ZVideoPlayerManager ()
@property (nonatomic,strong) UIView *playerView;
@property (nonatomic, strong) SJVideoPlayer *player;

@property (nonatomic,strong) UIView *compressView;
@property (nonatomic,strong) AVPlayer *videoPlayer1;
@property (nonatomic,strong) AVPlayerLayer *playerLayer1;
@property (nonatomic,strong) AVPlayer *videoPlayer2;
@property (nonatomic,strong) AVPlayerLayer *playerLayer2;
@property (nonatomic,strong) UILabel *sourceVideoSizeLabel;
@property (nonatomic,strong) UILabel *compressVideoSizeLabel;
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

- (UIView *)playerView {
    if (!_playerView) {
        _playerView = [[UIView alloc] init];
        _playerView.layer.masksToBounds = YES;
        _playerView.backgroundColor = [UIColor blackColor];
        
        __weak typeof(self) weakSelf = self;
        UIButton *close = [[UIButton alloc] initWithFrame:CGRectZero];
        close.backgroundColor = [UIColor colorGrayBG];
        close.layer.masksToBounds = YES;
        close.layer.cornerRadius = CGFloatIn750(35);
        close.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [close setImage:[UIImage imageNamed:@"videoClose"] forState:UIControlStateNormal];
        [close bk_addEventHandler:^(id sender) {
            [weakSelf.player stop];
            [weakSelf.playerView removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        [_playerView addSubview:close];
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playerView.mas_left).offset(CGFloatIn750(20));
            make.top.equalTo(self.playerView.mas_top).offset(CGFloatIn750(-60)+kTopHeight);
            make.width.height.mas_equalTo(CGFloatIn750(70));
        }];
        
        
        _player = [SJVideoPlayer player];
        
        [_playerView addSubview:_player.view];
        [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.playerView.mas_centerY).offset(-CGFloatIn750(120));
            make.leading.trailing.offset(0);
            make.height.equalTo(self->_player.view.mas_width).multipliedBy(9 / 16.0f);
        }];
        
        
        
//        _player.hideBackButtonWhenOrientationIsPortrait = YES;
        _player.pausedToKeepAppearState = YES;
//        _player.enableFilmEditing = NO;
        _player.filmEditingConfig.saveResultToAlbumWhenExportSuccess = YES;
        _player.resumePlaybackWhenAppDidEnterForeground = YES;
        
        SJEdgeControlButtonItem *titleItem = [_player.defaultEdgeControlLayer.topAdapter itemForTag:SJEdgeControlLayerTopItem_Title];
        titleItem.numberOfLines = 1;
    }
    return _playerView;
}

- (void)playVideoWithUrl:(NSString *)url title:(NSString *)title {
    self.playerView.alpha = 0;
    self.playerView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self.playerView];
    [UIView animateWithDuration:0.3 animations:^{
        self.playerView.alpha = 1;
        self.playerView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
    
    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:url]];
    _player.URLAsset.title = title;
    //    _player.URLAsset.playableLimit = 10;
}

#pragma mark -compress

- (UIView *)compressView {
    if (!_compressView) {
        _compressView = [[UIView alloc] init];
        _compressView.layer.masksToBounds = YES;
        _compressView.backgroundColor = [UIColor blackColor];
        
        __weak typeof(self) weakSelf = self;
        UIButton *close = [[UIButton alloc] initWithFrame:CGRectZero];
        close.backgroundColor = [UIColor colorGrayBG];
        close.layer.masksToBounds = YES;
        close.layer.cornerRadius = CGFloatIn750(35);
        close.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [close setImage:[UIImage imageNamed:@"videoClose"] forState:UIControlStateNormal];
        [close bk_addEventHandler:^(id sender) {
            [weakSelf.player stop];
            [weakSelf.compressView removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        [_compressView addSubview:close];
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.compressView.mas_left).offset(CGFloatIn750(20));
            make.top.equalTo(self.compressView.mas_top).offset(CGFloatIn750(-60)+kTopHeight);
            make.width.height.mas_equalTo(CGFloatIn750(70));
        }];
        
        
        _sourceVideoSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 20)];
        [self.compressView addSubview:_sourceVideoSizeLabel];
       
        _compressVideoSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (kScreenHeight - 64) / 2.0, 160, 20)];
        _compressVideoSizeLabel.backgroundColor = [UIColor greenColor];
        
        [self.compressView addSubview:_compressVideoSizeLabel];
    }
    return _playerView;
}

- (void)compressVideoWithUrl:(NSString *)url oldUrl:(NSString *)oldUrl
{
    if (_videoPlayer1) {
        [_videoPlayer1 pause];
    }
    if (_videoPlayer2) {
        [_videoPlayer2 pause];
    }
    
    [_playerLayer1 removeFromSuperlayer];
    [_playerLayer2 removeFromSuperlayer];
    _videoPlayer1 = nil;
    _videoPlayer2 = nil;
    _playerLayer1 = nil;
    _playerLayer2 = nil;
    
    // 播放效果对比
    NSURL *sourceVideoUrl = [NSURL fileURLWithPath:oldUrl];
    _videoPlayer1 = [AVPlayer playerWithURL:sourceVideoUrl];
    _playerLayer1 = [AVPlayerLayer playerLayerWithPlayer:_videoPlayer1];
    _playerLayer1.backgroundColor = [UIColor redColor].CGColor;
    _playerLayer1.frame = CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 64) / 2.0);
    [self.compressView.layer addSublayer:_playerLayer1];

    NSURL *compressVideoUrl = [NSURL fileURLWithPath:url];
    _videoPlayer2 = [AVPlayer playerWithURL:compressVideoUrl];
    _playerLayer2 = [AVPlayerLayer playerLayerWithPlayer:_videoPlayer2];
    _playerLayer2.backgroundColor = [UIColor orangeColor].CGColor;
    _playerLayer2.frame = CGRectMake(0, (kScreenHeight - 64) / 2.0, kScreenWidth, (kScreenHeight - 64) / 2.0);
    [self.compressView.layer addSublayer:_playerLayer2];
    

    
    // 文件大小对比
    NSData *sourceVideoData = [NSData dataWithContentsOfFile:oldUrl];
    float sourceVideoSize = (float)sourceVideoData.length / 1024.0 / 1024.0;
    _sourceVideoSizeLabel.text = [NSString stringWithFormat:@"源视频 : %.2fM", sourceVideoSize];
    
    NSData *compressVideoData = [NSData dataWithContentsOfFile:url];
           float compressVideoSize = (float)compressVideoData.length / 1024.0 / 1024.0;
    _compressVideoSizeLabel.text = [NSString stringWithFormat:@"压缩视频 : %.2fM", compressVideoSize];
    
    self.compressView.alpha = 0;
    self.compressView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self.playerView];
    [UIView animateWithDuration:0.3 animations:^{
        self.compressView.alpha = 1;
        self.compressView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        [_videoPlayer1 play];
        [_videoPlayer2 play];
    }];
}
@end
