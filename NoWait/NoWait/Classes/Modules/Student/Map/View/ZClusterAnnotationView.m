//
//  ZClusterAnnotationView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZClusterAnnotationView.h"
#import "ZClusterAnnotation.h"


static CGFloat const ScaleFactorAlpha = 0.3;
static CGFloat const ScaleFactorBeta = 0.4;

/* 返回rect的中心. */
CGPoint RectCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

/* 返回中心为center，尺寸为rect.size的rect. */
CGRect CenterRect(CGRect rect, CGPoint center)
{
    CGRect r = CGRectMake(center.x - rect.size.width/2.0,
                          center.y - rect.size.height/2.0,
                          rect.size.width,
                          rect.size.height);
    return r;
}

/* 根据count计算annotation的scale. */
CGFloat ScaledValueForValue(CGFloat value)
{
    return 1.0 / (1.0 + expf(-1 * ScaleFactorAlpha * powf(value, ScaleFactorBeta)));
}

#pragma mark -

@interface ZClusterAnnotationView ()
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation ZClusterAnnotationView

#pragma mark Initialization

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self setupLabel];
    }
    
    return self;
}

#pragma mark Utility
- (void)setupLabel{
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 80, 36)];
    _countLabel.textColor       = [UIColor whiteColor];
    _countLabel.textAlignment   = NSTextAlignmentCenter;
    _countLabel.backgroundColor = [UIColor colorMain];
    _countLabel.layer.cornerRadius = CGFloatIn750(20);
    _countLabel.layer.masksToBounds = YES;
    _countLabel.numberOfLines = 1;
    _countLabel.font = [UIFont boldSystemFontOfSize:CGFloatIn750(24)];
    _countLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self addSubview:_countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
    }];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSArray *subViews = self.subviews;
    if ([subViews count] > 1)
    {
        for (UIView *aSubView in subViews)
        {
            if ([aSubView pointInside:[self convertPoint:point toView:aSubView] withEvent:event])
            {
                return YES;
            }
        }
    }
    if (point.x > 0 && point.x < self.frame.size.width && point.y > 0 && point.y < self.frame.size.height)
    {
        return YES;
    }
    return NO;
}

#pragma mark - setdata
- (void)setMain:(NSDictionary *)data {
    self.countLabel.text = [NSString stringWithFormat:@"%@\n%@个",data[@"content"],data[@"count"]];
    self.countLabel.numberOfLines = 0;
    CGSize tempSize = [data[@"content"] tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(CGFloatIn750(240), CGFloatIn750(40))];
    self.frame = CGRectMake(self.center.x, self.center.y, tempSize.width + 20, tempSize.height + CGFloatIn750(16));
    
    self.frame = CGRectMake(self.center.x, self.center.y, CGFloatIn750(120), CGFloatIn750(120));
    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(8));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(8));
    }];
    self.countLabel.layer.cornerRadius = CGFloatIn750(60);
    [self setNeedsDisplay];
}

- (void)setSubMain:(NSDictionary *)data {
    self.countLabel.text = [NSString stringWithFormat:@"%@个 \n  %@",data[@"count"],@"校区"];
    self.countLabel.numberOfLines = 0;
    CGSize tempSize = [data[@"content"] tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(CGFloatIn750(240), CGFloatIn750(40))];
    self.frame = CGRectMake(self.center.x, self.center.y, tempSize.width + 20, tempSize.height + CGFloatIn750(16));
    
    self.frame = CGRectMake(self.center.x, self.center.y, CGFloatIn750(120), CGFloatIn750(120));
    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(8));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(8));
    }];
    self.countLabel.layer.cornerRadius = CGFloatIn750(60);
    [self setNeedsDisplay];
}

- (void)setDetail:(NSString *)str {
    self.countLabel.text = str;
    self.countLabel.numberOfLines = 1;
    CGSize tempSize = [str tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(CGFloatIn750(240), CGFloatIn750(40))];
    self.frame = CGRectMake(self.center.x, self.center.y, tempSize.width + 20, tempSize.height + CGFloatIn750(16));
    
    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(40));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(8));
    }];
    self.countLabel.layer.cornerRadius = CGFloatIn750(20);
    [self setNeedsDisplay];
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    
    if ([data objectForKey:@"type"]) {
        if ([data[@"type"] intValue] == 4) {
            [self setDetail:data[@"content"]];
        }else if ([data[@"type"] intValue] == 3) {
            [self setSubMain:data];
        }else{
            [self setMain:data];
        }
    }
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

