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
@property (nonatomic, weak)UIView *volumeSuperView;
//记录我们 hook 的对象信息
@property (nonatomic, strong)id<AspectToken>hookAVPlaySingleTap;
@end

@implementation ZAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加监听播放状态
    [self HF_addNotificationForName:AVPlayerItemDidPlayToEndTimeNotification block:^(NSNotification *notification) {
        NSLog(@"我播放结束了！");
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }];
    
    Class UIGestureRecognizerTarget = NSClassFromString(@"UIGestureRecognizerTarget");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    _hookAVPlaySingleTap = [UIGestureRecognizerTarget aspect_hookSelector:@selector(_sendActionWithGestureRecognizer:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>info,UIGestureRecognizer *gest){
        if (gest.numberOfTouches == 1) {
            //AVVolumeButtonControl
            if (!self.volumeSuperView) {
                UIView *view = [gest.view findViewByClassName:@"AVVolumeButtonControl"];
                if (view) {
                    while (view.superview) {
                        view = view.superview;
                        if ([view isKindOfClass:[NSClassFromString(@"AVTouchIgnoringView") class]]) {
                            self.volumeSuperView = view;
                            
                            [view HF_addObserverForKeyPath:@"hidden" block:^(__weak id object, id oldValue, id newValue) {
                                NSLog(@"newValue ==%@",newValue);
                        
                            }];
                            break;
                        }
                    }
                }
            }else{
                [self.player pause];
            }
        }
        
    } error:nil];

    if (self.readyForDisplay) {
        [self.player play];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.hookAVPlaySingleTap remove];
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
