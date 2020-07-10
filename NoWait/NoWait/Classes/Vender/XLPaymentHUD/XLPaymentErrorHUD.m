//
//  XLPaymentErrorHUD.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "XLPaymentErrorHUD.h"

static CGFloat lineWidth = 4.0f;
static CGFloat circleDuriation = 0.5f;
static CGFloat checkDuration = 0.2f;

#define BlueColor [UIColor colorMain]

@implementation XLPaymentErrorHUD {
    CALayer *_animationLayer;
}

//显示
+ (XLPaymentErrorHUD*)showIn:(UIView*)view {
    [self hideIn:view];
    XLPaymentErrorHUD *hud = [[XLPaymentErrorHUD alloc] initWithFrame:view.bounds];
    [hud start];
    [view addSubview:hud];
    return hud;
}

//隐藏
+ (XLPaymentErrorHUD *)hideIn:(UIView *)view {
    XLPaymentErrorHUD *hud = nil;
    for (XLPaymentErrorHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[XLPaymentErrorHUD class]]) {
            [subView hide];
            [subView removeFromSuperview];
            hud = subView;
        }
    }
    return hud;
}

- (void)start {
    [self circleAnimation];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.8 * circleDuriation * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self checkAnimation];
    });
}

- (void)hide {
    for (CALayer *layer in _animationLayer.sublayers) {
        [layer removeAllAnimations];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _animationLayer = [CALayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, 40, 40);
    _animationLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self.layer addSublayer:_animationLayer];
}

//画圆
- (void)circleAnimation {
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = _animationLayer.bounds;
    [_animationLayer addSublayer:circleLayer];
    circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    circleLayer.strokeColor  = BlueColor.CGColor;
    circleLayer.lineWidth = lineWidth;
    circleLayer.lineCap = kCALineCapRound;
    
    
    CGFloat lineWidth = 5.0f;
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    circleLayer.path = path.CGPath;
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.duration = circleDuriation;
    circleAnimation.fromValue = @(0.0f);
    circleAnimation.toValue = @(1.0f);
    circleAnimation.delegate = self;
    [circleAnimation setValue:@"circleAnimation" forKey:@"animationName"];
    [circleLayer addAnimation:circleAnimation forKey:nil];
}

//对号
- (void)checkAnimation {
    
    CGFloat a = _animationLayer.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(a*2.7/10,a*5.4/10)];
//    [path addLineToPoint:CGPointMake(a*4.5/10,a*7/10)];
//    [path addLineToPoint:CGPointMake(a*7.8/10,a*3.8/10)];
//
    //对号第一部分的起始
    [path moveToPoint:CGPointMake(a/7 * 2, a/7*2)];
    CGPoint pl =CGPointMake(a/7*5, a/7*5);
    [path addLineToPoint:pl];
    
    
    //对号第二部分起始
    [path moveToPoint:CGPointMake(a/7*5, a/7*2)];
    CGPoint p2 = CGPointMake(a/7 * 2, a/7*5);
    [path addLineToPoint:p2];
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = BlueColor.CGColor;
    checkLayer.lineWidth = lineWidth;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [_animationLayer addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = checkDuration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}

@end

