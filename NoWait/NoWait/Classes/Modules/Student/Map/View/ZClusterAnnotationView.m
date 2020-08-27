//
//  ZClusterAnnotationView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZClusterAnnotationView.h"
#import "ZClusterAnnotation.h"
#import "ZAnnotationDataView.h"

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
@property (nonatomic, strong) ZAnnotationDataView *annDataView;

@property (nonatomic, strong) UIColor *drawColor;
@end

@implementation ZClusterAnnotationView

#pragma mark Initialization

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.01];
        [self setupMainView];
    }
    
    return self;
}

#pragma mark Utility
- (void)setupMainView{
    
    self.drawColor = [UIColor colorMain];
    
    [self addSubview:self.annDataView];
    
    [self.annDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *annBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [annBtn bk_whenTapped:^{
        if (weakSelf.annBlock) {
            weakSelf.annBlock(self.annotation);
        }
    }];
    [self addSubview:annBtn];
    [annBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.annDataView);
    }];
}

- (ZAnnotationDataView *)annDataView {
    if (!_annDataView) {
        _annDataView = [[ZAnnotationDataView alloc] init];
    }
    return _annDataView;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    
//    NSArray *subViews = self.subviews;
//    NSLog(@"pointInside---------%ld", subViews.count);
//    if ([subViews count] > 1)
//    {
//        for (UIView *aSubView in subViews)
//        {
//            if ([aSubView pointInside:[self convertPoint:point toView:aSubView] withEvent:event])
//            {
//                return YES;
//            }
//        }
//    }
//    if (point.x > 0 && point.x < self.frame.size.width && point.y > 0 && point.y < self.frame.size.height)
//    {
//        return YES;
//    }
//    return YES;
//}

#pragma mark - setdata
- (void)setMain:(NSDictionary *)data {
    [self.annDataView setMain:data];
    
    self.frame = CGRectMake(self.center.x, self.center.y, CGFloatIn750(240), CGFloatIn750(240));
    
    [self setNeedsDisplay];
}


- (void)setSubMain:(NSDictionary *)data {
    [self.annDataView setSubMain:data];
    
    CGSize contentSize = [data[@"content"] tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(CGFloatIn750(240), CGFloatIn750(40))];
    
    CGSize countSize = [[NSString stringWithFormat:@"%@",data[@"count"]] tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(CGFloatIn750(240), CGFloatIn750(40))];
    
    
    self.frame = CGRectMake(self.center.x, self.center.y, contentSize.width + countSize.width + CGFloatIn750(60), CGFloatIn750(60) + CGFloatIn750(16));
}

- (void)setTogether:(NSDictionary *)data {
    [self.annDataView setTogether:data];
    
    CGSize tempSize = [[NSString stringWithFormat:@"%@个%@",data[@"count"],@"校区"] tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(CGFloatIn750(240), CGFloatIn750(40))];
    
    
    self.frame = CGRectMake(self.center.x, self.center.y, tempSize.width + CGFloatIn750(32), CGFloatIn750(62));
}

- (void)setDetail:(NSString *)str {
    [self.annDataView setDetail:str];
    
    CGSize tempSize = [str tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(24)] constrainedToSize:CGSizeMake(CGFloatIn750(240), CGFloatIn750(40))];
    
    self.frame = CGRectMake(self.center.x, self.center.y, tempSize.width + 20, tempSize.height + CGFloatIn750(16));
}


- (void)setData:(NSDictionary *)data {
    _data = data;
    if ([data objectForKey:@"type"]) {
        if ([data[@"type"] intValue] == -1) {//搜索
            if([data[@"count"] intValue] == 1){
                self.drawColor = [UIColor colorWithWhite:0 alpha:0.01];
                [self setDetail:data[@"content"]];
            }else{
                self.drawColor = [UIColor colorWithWhite:0 alpha:0.01];
                [self setTogether:data];
            }
        }else if ([data[@"type"] intValue] == 0 || [data[@"type"] intValue] == 1) {
            self.drawColor = [UIColor colorMain];
            [self setMain:data];
        }else if ([data[@"type"] intValue] == 2){
            self.drawColor = [UIColor colorWithWhite:0 alpha:0.01];
            [self setSubMain:data];
        }else {
            if([data[@"count"] intValue] == 1){
                self.drawColor = [UIColor colorWithWhite:0 alpha:0.01];
                [self setDetail:data[@"content"]];
            }else{
                self.drawColor = [UIColor colorWithWhite:0 alpha:0.01];
                [self setTogether:data];
            }
        }
    }
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
//    return;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGContextSetAllowsAntialiasing(context, true);
//
//    UIColor *outerCircleStrokeColor = [UIColor colorWithWhite:0 alpha:0.25];
//    UIColor *innerCircleStrokeColor = [UIColor whiteColor];
//    UIColor *innerCircleFillColor = self.drawColor;
//
//    CGRect circleFrame = CGRectInset(rect, 4, 4);
//
//    [outerCircleStrokeColor setStroke];
//    CGContextSetLineWidth(context, 5.0);
//    CGContextStrokeEllipseInRect(context, circleFrame);
//
//    [innerCircleStrokeColor setStroke];
//    CGContextSetLineWidth(context, 4);
//    CGContextStrokeEllipseInRect(context, circleFrame);
//
//    [innerCircleFillColor setFill];
//    CGContextFillEllipseInRect(context, circleFrame);
}
@end

