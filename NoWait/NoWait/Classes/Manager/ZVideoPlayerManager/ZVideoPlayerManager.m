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
        _playerView.backgroundColor = KBlackColor;
        
        __weak typeof(self) weakSelf = self;
        UIButton *close = [[UIButton alloc] initWithFrame:CGRectZero];
        close.backgroundColor = KBackColor;
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
@end
