//
//  ZSJCustomVidoLayerVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSJCustomVidoLayerVC.h"
#import "SJVideoPlayer.h"
#import <SJUIKit/NSAttributedString+SJMake.h>

@interface ZSJCustomVidoLayerVC ()
@property (nonatomic, strong) SJVideoPlayer *player;

@end

@implementation ZSJCustomVidoLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupViews];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
 
- (void)_setupViews {
    _player = [SJVideoPlayer player];
    _player.pausedToKeepAppearState = self.isAutoPlay;
    [self _removeExtraItems];
    
    if ([self.data isKindOfClass:[NSString class]]) {
        _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:[NSURL URLWithString:self.data]];
    }else if ([self.data isKindOfClass:[AVAsset class]]){
        _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithAVAsset:self.data];
    }
    
    [self.view addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

///
/// 删除当前demo不需要的item
///
- (void)_removeExtraItems {
//    [_player.defaultEdgeControlLayer.bottomAdapter removeItemForTag:SJEdgeControlLayerBottomItem_FullBtn];
    [_player.defaultEdgeControlLayer.bottomAdapter removeItemForTag:SJEdgeControlLayerBottomItem_Separator];
    [_player.defaultEdgeControlLayer.bottomAdapter exchangeItemForTag:SJEdgeControlLayerBottomItem_DurationTime withItemForTag:SJEdgeControlLayerBottomItem_Progress];
    SJEdgeControlButtonItem *durationItem = [_player.defaultEdgeControlLayer.bottomAdapter itemForTag:SJEdgeControlLayerBottomItem_DurationTime];
    durationItem.insets = SJEdgeInsetsMake(8, 16);
    _player.defaultEdgeControlLayer.bottomContainerView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    _player.defaultEdgeControlLayer.topContainerView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    [_player.defaultEdgeControlLayer.bottomAdapter reload];
}

@end
