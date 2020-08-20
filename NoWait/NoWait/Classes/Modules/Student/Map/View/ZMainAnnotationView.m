//
//  ZMainAnnotationView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMainAnnotationView.h"
#import "ZClusterAnnotation.h"

#pragma mark -

@interface ZMainAnnotationView ()

@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation ZMainAnnotationView

#pragma mark Initialization

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self setupLabel];
        [self setCount:1];
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        self.image = [UIImage imageNamed:@"hnglocaladdress"];
    }
    
    return self;
}

#pragma mark Utility

- (void)setupLabel
{
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 80, 36)];
    _countLabel.backgroundColor = [UIColor clearColor];
    _countLabel.textColor       = [UIColor whiteColor];
    _countLabel.textAlignment   = NSTextAlignmentCenter;
    _countLabel.shadowColor     = [UIColor colorWithWhite:0.0 alpha:0.75];
    _countLabel.shadowOffset    = CGSizeMake(0, -1);
    _countLabel.adjustsFontSizeToFitWidth = YES;
    _countLabel.numberOfLines = 1;
    _countLabel.font = [UIFont boldSystemFontOfSize:12];
    _countLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self addSubview:_countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}
//
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    NSArray *subViews = self.subviews;
//    if ([subViews count] > 1)
//    {
//        for (UIView *aSubView in subViews)
//        {
//            if ([aSubView pointInside:[self convertPoint:point toView:aSubView] withEvent:event])
//            {
//                return NO;
//            }
//        }
//    }
//    if (point.x > 0 && point.x < self.frame.size.width && point.y > 0 && point.y < self.frame.size.height)
//    {
//        return NO;
//    }
//    return NO;
//}

- (void)setCount:(NSUInteger)count {
    _count = count;
    
    /* 按count数目设置view的大小. */
    CGSize tempSize = [[NSString stringWithFormat:@"%lu",(unsigned long)count] tt_sizeWithFont:[UIFont systemFontOfSize:12]];
    self.frame = CGRectMake(self.center.x - tempSize.width/2.0,
                            self.center.y - tempSize.height/2.0,
    tempSize.width,
    tempSize.height);
    
    self.countLabel.text = [@(_count) stringValue];
    
    [self setNeedsDisplay];
}

#pragma mark - annimation
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self addBounceAnnimation];
}

- (void)addBounceAnnimation {
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    bounceAnimation.values = @[@(0.05), @(1.1), @(0.9), @(1)];
    bounceAnimation.duration = 0.6;
    
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:bounceAnimation.values.count];
    for (NSUInteger i = 0; i < bounceAnimation.values.count; i++)
    {
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    }
    [bounceAnimation setTimingFunctions:timingFunctions.copy];
    
    bounceAnimation.removedOnCompletion = NO;
    
    [self.layer addAnimation:bounceAnimation forKey:@"bounce"];
}

#pragma mark draw rect
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);
    
    UIColor *outerCircleStrokeColor = [UIColor colorWithWhite:0 alpha:0.25];
    UIColor *innerCircleStrokeColor = [UIColor whiteColor];
    UIColor *innerCircleFillColor = [UIColor colorMain];
    
    CGRect circleFrame = CGRectInset(rect, 4, 4);
    
    [outerCircleStrokeColor setStroke];
    CGContextSetLineWidth(context, 5.0);
    CGContextStrokeEllipseInRect(context, circleFrame);
    
    [innerCircleStrokeColor setStroke];
    CGContextSetLineWidth(context, 4);
    CGContextStrokeEllipseInRect(context, circleFrame);
    
    [innerCircleFillColor setFill];
    CGContextFillEllipseInRect(context, circleFrame);
}
@end


