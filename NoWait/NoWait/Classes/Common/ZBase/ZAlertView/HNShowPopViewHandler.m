//
//  HNShowPopViewHandler.m
//  hntx
//
//  Created by RoyLei on 2018/6/5.
//  Copyright © 2018年 LaKa. All rights reserved.
//

#import "HNShowPopViewHandler.h"

@interface HNShowPopViewHandler()

@property (strong, nonatomic) UIControl *backgroundView;
@property (weak,   nonatomic) UIView    *containerView;   /**<必须先设置containerView*/
@property (weak,   nonatomic) UIView    *popContentView;

@property (strong, nonatomic) UIVisualEffectView *blurView;

@property (assign, nonatomic) BOOL isShowing;

@property (assign, nonatomic) HNShowPopViewType popType;

@end

@implementation HNShowPopViewHandler

+ (instancetype)showContentView:(UIView *)contentView
                inContainerView:(UIView *)containerView
              useBlurBackground:(BOOL)useBlurBackground
                        popType:(HNShowPopViewType)popType
{
    __block HNShowPopViewHandler *popViewHandler = [HNShowPopViewHandler new];
    popViewHandler.useBlurBackground = useBlurBackground;
    popViewHandler.containerView = containerView;
    popViewHandler.popContentView = contentView;
    
    [popViewHandler showPopViewWithAnimationWithPopType:popType];
    return popViewHandler;
}

- (void)setContainerView:(UIView *)containerView
{
    if (_containerView != containerView) {
        _containerView = nil;
        _containerView = containerView;
        
        _backgroundView = [[UIControl alloc] initWithFrame:_containerView.bounds];
        [_backgroundView setBackgroundColor:[UIColorHex(0x000000) colorWithAlphaComponent:0.3]];
        [_backgroundView addTarget:self action:@selector(backgroundPressed:) forControlEvents:UIControlEventTouchUpInside];
        _backgroundView.enabled = NO;
        [_backgroundView setAlpha:0.0];
        [_containerView addSubview:_backgroundView];
    }
}

- (void)setPopContentView:(UIView *)popContentView
{
    if (_popContentView != popContentView) {
        _popContentView = nil;
        
        if (self.useBlurBackground) {
            [self.blurView setFrame:popContentView.bounds];
            [self.blurView.contentView addSubview:popContentView];
            _popContentView = self.blurView;
        }else {
            _popContentView = popContentView;
        }
        
        [self.containerView addSubview:_popContentView];
    }
}

#pragma mark - Getter

- (UIVisualEffectView *)blurView
{
    if (!_blurView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
    }
    
    return _blurView;
}

#pragma mark - Button Action

- (void)backgroundPressed:(id)sender
{
    [self dissmiss];
    if (self.backgroundViewPressedBlock) {
        self.backgroundViewPressedBlock();
    }
}

#pragma mark - Animation

- (void)showPopViewWithAnimationWithPopType:(HNShowPopViewType)popType
{
    if (self.isShowing) {
        return;
    }
    
    self.isShowing = YES;
    
    self.popType = popType;
    self.viewDidDisappearPressedBlock = nil;
    
    NSAssert(nil != self.backgroundView, @"self.backgroundView 不能为空");
    
    switch (popType) {
        case HNShowPopViewTypeSpringMiddle: {
            [self.popContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.containerView.mas_centerX);
                make.centerY.mas_equalTo(self.containerView.mas_centerY);
                make.size.mas_equalTo(self.popContentView.size);
            }];
            
            self.popContentView.layer.opacity = 0.5f;
            self.popContentView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
            
            [UIView animateWithDuration:0.2 animations:^{
                [self.backgroundView setAlpha:1.0];
                self.popContentView.layer.opacity = 1.0f;
            }];
            
            [UIView animateWithDuration:0.4f delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.popContentView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                             }
                             completion:nil];
            break;
        }
        case HNShowPopViewTypeSpringTop: {
            
            [_backgroundView setBackgroundColor:[UIColorHex(0x000000) colorWithAlphaComponent:0.3]];
            
            [self.popContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.containerView.mas_centerX);
                make.top.mas_equalTo(self.containerView.mas_top).offset(-self.popContentView.height);
                make.size.mas_equalTo(self.popContentView.size);
            }];
            [self.containerView layoutIfNeeded];
            
            [UIView animateWithDuration:0.2 animations:^{
                [self.backgroundView setAlpha:1.0];
            }];
            
            [UIView animateWithDuration:0.6f
                                  delay:0.0
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.2
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 
                                 [self.popContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                                     make.top.mas_equalTo(self.containerView.mas_top).offset((self.containerView.height-self.popContentView.height)/2);
                                 }];
                                 [self.containerView layoutIfNeeded];
                             }
                             completion:nil];
            
            break;
        }
        case HNShowPopViewTypeSpringBottom: {
            
            [_backgroundView setBackgroundColor:[UIColorHex(0x000000) colorWithAlphaComponent:0.25]];
            
            [self.popContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.containerView.mas_centerX);
                make.size.mas_equalTo(self.popContentView.size);
                make.bottom.mas_equalTo(self.containerView.mas_bottom).offset(self.popContentView.size.height);
            }];
            [self.containerView layoutIfNeeded];
            
            [UIView animateWithDuration:0.2 animations:^{
                [self.backgroundView setAlpha:1.0];
            }];
            
            [self.popContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.containerView.mas_bottom);
            }];
            [UIView animateWithDuration:0.3f
                                  delay:0.0
                 usingSpringWithDamping:4
                  initialSpringVelocity:0.1
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [self.containerView layoutIfNeeded];
                             }
                             completion:nil];
            
            break;
        }
        case HNShowPopViewTypeNormalBottom: {
            
            [_backgroundView setBackgroundColor:[UIColorHex(0x000000) colorWithAlphaComponent:0.25]];
            
            [self.popContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.containerView.mas_centerX);
                make.size.mas_equalTo(self.popContentView.size);
                make.bottom.mas_equalTo(self.containerView.mas_bottom).offset(self.popContentView.size.height);
            }];
            [self.containerView layoutIfNeeded];
            
            [UIView animateWithDuration:0.2 animations:^{
                [self.backgroundView setAlpha:1.0];
            }];
            
            [self.popContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.containerView.mas_bottom);
            }];
            
            [UIView animateWithDuration:0.3 animations:^{
                [self.containerView layoutIfNeeded];
            }];
            
            break;
        }
    }
}

- (void)dissmissWithCompletion:(HNShowPopViewNoParamsBlock)completion
{
    if (!self.isShowing) {
        
        self.viewDidDisappearPressedBlock = completion;
        if (self.viewDidDisappearPressedBlock) {
            self.viewDidDisappearPressedBlock();
        }
        return;
    }
    [self dissmiss];
}

- (void)dissmiss
{
    if (!self.isShowing) {
        return;
    }
    
    if (!self.popContentView.superview) {
        return;
    }
    
    [self.backgroundView.layer removeAllAnimations];
    [self.popContentView.layer removeAllAnimations];
    
    switch (self.popType) {
        case HNShowPopViewTypeSpringMiddle: {
            
            self.popContentView.layer.opacity = 1.0f;
            
            [UIView animateWithDuration:0.3f
                                  delay:0.0
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 [self.backgroundView setAlpha:0.0];
                                 self.popContentView.layer.opacity = 0.0f;
                                 self.popContentView.transform = CGAffineTransformMakeScale(0.6, 0.6);
                             }
                             completion:^(BOOL finished) {
                                 [self removeAllSubviews];
                             }];
            
            break;
        }
        case HNShowPopViewTypeSpringTop: {
            
            [UIView animateWithDuration:0.3 animations:^{
                [self.backgroundView setAlpha:0.0];
            }];
            [self.popContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.containerView.mas_top).offset(self.containerView.height);
            }];
            
            [UIView animateWithDuration:0.5f
                                  delay:0.0
                 usingSpringWithDamping:1.5
                  initialSpringVelocity:1.2
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.containerView layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {
                                 [self removeAllSubviews];
                             }];
            break;
        }
        case HNShowPopViewTypeSpringBottom: {
            
            [self.popContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.containerView.mas_bottom).offset(self.popContentView.height);
            }];
            
            [UIView animateWithDuration:0.25f
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.backgroundView setAlpha:0.0];
                                 [self.containerView layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {
                                 [self removeAllSubviews];
                             }];
            break;
        }
        case HNShowPopViewTypeNormalBottom: {
            
            [UIView animateWithDuration:0.3 animations:^{
                [self.backgroundView setAlpha:0.0];
            }];
            
            [self.popContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.containerView.mas_bottom).offset(self.popContentView.height);
            }];
            
            [UIView animateWithDuration:0.3 animations:^{
                [self.containerView layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeAllSubviews];
            }];
            break;
        }
    }
}

- (void)removeAllSubviews
{
    self.isShowing = NO;
    
    self.popContentView.layer.opacity = 1.0f;
    self.popContentView.transform = CGAffineTransformIdentity;
    
    [self.popContentView removeFromSuperview];
    [self.backgroundView removeFromSuperview];
    
    _containerView = nil;
    _popContentView = nil;
    _backgroundView = nil;
    
    if (self.viewDidDisappearPressedBlock) {
        self.viewDidDisappearPressedBlock();
    }
}
@end
