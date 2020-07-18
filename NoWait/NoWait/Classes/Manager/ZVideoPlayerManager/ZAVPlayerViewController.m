//
//  ZAVPlayerViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAVPlayerViewController.h"
#import <AVKit/AVKit.h>

#import "NSObject+BlockObserver.h"
#import "Aspects.h"
#import "UIView+ViewDesc.h"

@interface ZAVPlayerViewController ()

//增加两个属性先
//记录音量控制的父控件，控制它隐藏显示的 view
@property (nonatomic,strong) UIView *volumeSuperView;
//记录我们 hook 的对象信息
@property (nonatomic,strong) id<AspectToken>hookAVPlaySingleTap;
@property (nonatomic,assign) BOOL isPlay;
@property (nonatomic,assign) BOOL isControllHidden;
@end

@implementation ZAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加监听播放状态
    [self HF_addNotificationForName:AVPlayerItemDidPlayToEndTimeNotification block:^(NSNotification *notification) {
        DLog(@"我播放结束了！");
        self.isPlay = NO;
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }];
    
//    if (self.readyForDisplay) {
//        [self.player play];
//    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     Class UIGestureRecognizerTarget = NSClassFromString(@"UIGestureRecognizerTarget");
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"

        _hookAVPlaySingleTap = [UIGestureRecognizerTarget aspect_hookSelector:@selector(_sendActionWithGestureRecognizer:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>info,UIGestureRecognizer *gest){
            
            if (gest.numberOfTouches == 1) {
                //AVVolumeButtonControl
                if (!self.volumeSuperView) {
                    UIView *view = [gest.view findViewByClassName:@"AVVolumeButtonControl"];
                    if (view) {
                        while (view.superview) {
                            view = view.superview;
                            if ([view isKindOfClass:[NSClassFromString(@"AVTouchIgnoringView") class]]) {
                                self.volumeSuperView = view;
                                DLog(@"*****************%@",view.className);
                                [view HF_addObserverForKeyPath:@"hidden" block:^(__weak id object, id oldValue, id newValue) {
                                    DLog(@"newValue ==%@",newValue);
                                    
                                    if ([[NSString stringWithFormat:@"%@",newValue] intValue] == 0) {
                                        self.isControllHidden = NO;
                                    }else{
                                        self.isControllHidden = YES;
                                    }
                                }];
                                break;
                            }
                        }
                    }
                }else{
                    if (self.isControllHidden) {
                        if (gest.state == UIGestureRecognizerStateBegan) {
                            [self.player pause];
                            self.isPlay = NO;
                        }
                    }
                }
            }
        } error:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.hookAVPlaySingleTap remove];
    self.player = nil;
}

- (void)dimissSelf {
    if (self.navigationController.viewControllers.count >1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
