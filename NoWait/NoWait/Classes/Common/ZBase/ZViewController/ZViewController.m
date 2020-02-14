//
//  ZViewController.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "AFNetworkReachabilityManager.h"

@implementation ZViewController

- (id)init
{
    if (self = [super init]) {
        [self setStatusBarStyle:UIStatusBarStyleDefault];
        self.emptyImage = @"emptyData";
        self.emptyDataStr = @"暂无数据，点击重新加载";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG])];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [MobClick beginLogPageView:self.analyzeTitle];
    if ([UIApplication sharedApplication].statusBarStyle != self.statusBarStyle) {
        [UIApplication sharedApplication].statusBarStyle = self.statusBarStyle;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:self.analyzeTitle];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [TLUIUtility hiddenLoading];
}

- (void)dealloc
{
#ifdef DEBUG_MEMERY
    DLog(@"dealloc %@", self.navigationItem.title);
#endif
}

#pragma mark - # Getter
- (NSString *)analyzeTitle
{
    if (_analyzeTitle == nil) {
        return self.navigationItem.title;
    }
    return _analyzeTitle;
}
//
//#pragma mark ————— 转场动画起始View —————
//-(UIView *)targetTransitionView{
//    return [UIView new];
//}
//
//-(BOOL)isNeedTransition{
//    return YES;
//}




#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (self.loading) {
        text = @"数据加载中...";
        font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        textColor = [UIColor colorWithHexString:@"999999"];
        
        
        if (!text) {
            return nil;
        }
        
        if (font) [attributes setObject:font forKey:NSFontAttributeName];
        if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }else{
        if ([self getNetworkStatus]) {
            text = self.emptyDataStr;
            font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0];
            textColor = [UIColor colorWithHexString:@"222222"];
            
            
            if (!text) {
                return nil;
            }
            
        }else{
            NSString *title = @"天呐，您的网络好像出了点小问题...";
            NSString *subTitle = @"                  解决方案：";
            NSString *detailTitle = @"                             1、在设置中开启网络权限，\n                             2、换个网络更好的地方试试吧！";
            
            text = [NSString stringWithFormat:@"%@\n%@\n%@",title,subTitle,detailTitle];
            
            NSMutableAttributedString *attributedSting =  [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
            
            NSRange netRangeTitle = NSMakeRange([[attributedSting string] rangeOfString:title].location, [[attributedSting string] rangeOfString:title].length);
            NSRange netRangeSubtitle = NSMakeRange([[attributedSting string] rangeOfString:subTitle].location, [[attributedSting string] rangeOfString:subTitle].length);
            NSRange netRangeDetailTitle = NSMakeRange([[attributedSting string] rangeOfString:detailTitle].location, [[attributedSting string] rangeOfString:detailTitle].length);
            
            //标题
            [attributedSting addAttribute:NSFontAttributeName value:[UIFont fontContent] range:netRangeTitle];
            [attributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor colorTextBlack] range:netRangeTitle];
            NSMutableParagraphStyle * titleParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            [titleParagraphStyle setLineSpacing:CGFloatIn750(40)];
            [titleParagraphStyle setAlignment:NSTextAlignmentCenter];
            [attributedSting addAttribute:NSParagraphStyleAttributeName value:titleParagraphStyle range:netRangeTitle];
            
            //副标题
            [attributedSting addAttribute:NSFontAttributeName value:[UIFont fontContent] range:netRangeSubtitle];
            [attributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor colorTextGray1] range:netRangeSubtitle];
            NSMutableParagraphStyle * subParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            [subParagraphStyle setLineSpacing:CGFloatIn750(24)];
            [subParagraphStyle setAlignment:NSTextAlignmentLeft];
            [attributedSting addAttribute:NSParagraphStyleAttributeName value:subParagraphStyle range:netRangeSubtitle];
            
            //内容
            [attributedSting addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:CGFloatIn750(22)] range:netRangeDetailTitle];
            [attributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor colorTextGray1] range:netRangeDetailTitle];
            NSMutableParagraphStyle * detailParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            [detailParagraphStyle setLineSpacing:CGFloatIn750(16)];
            [detailParagraphStyle setAlignment:NSTextAlignmentLeft];
            [attributedSting addAttribute:NSParagraphStyleAttributeName value:detailParagraphStyle range:netRangeDetailTitle];
            
            return attributedSting;
        }
        
        if (!text) {
            return nil;
        }
        
        if (font) [attributes setObject:font forKey:NSFontAttributeName];
        if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        
        
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        return [UIImage imageNamed:@"zphoto_number_icon"];
    }else{
        if ([self getNetworkStatus]) {
            return [UIImage imageNamed:_emptyImage? _emptyImage : @"emptyData"];
        }else{
            return [UIImage imageNamed: @"noNetwork"];
        }
    }
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    //    animation.duration = 0.25;
    //    animation.cumulative = YES;
    //    animation.repeatCount = MAXFLOAT;
    CGFloat duration = 0.8f;
    
    CGFloat height = 50.f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 缩放
    CAKeyframeAnimation *animScale = [CAKeyframeAnimation animation];
    
    animScale.keyPath = @"transform.scale";
    
    // 0 ~ 1
    static CGFloat scale = 0.5;

    animScale.values = @[@(scale/(4.0/8.0)), @(scale/(5.0/8.0)), @(scale/(6.0/8.0)), @(scale/(7.0/8.0)), @(scale/(8.0/8.0)), @(scale/(7.0/8.0)), @(scale/(6.0/8.0)), @(scale/(5.0/8.0)), @(scale/(4.0/8.0))];
    
    animScale.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    animScale.duration = duration;
    animScale.repeatCount = HUGE_VALF;
    animScale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    
    CGFloat currentTy = 0;
    
    animation.duration = duration;
    
    animation.values = @[@(currentTy), @(currentTy - height/4), @(currentTy-height/4*2), @(currentTy-height/4*3), @(currentTy - height), @(currentTy-height/4*3), @(currentTy -height/4*2), @(currentTy - height/4), @(currentTy)];
    
    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.repeatCount = HUGE_VALF;
    
    //    [sender.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
    group.duration = duration;
    group.animations = @[animScale,animation];
    group.repeatCount = HUGE_VALF;
    return group;
}


- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -CGFloatIn750(60);
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return CGFloatIn750(40);
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.isLoading) {
        return nil;
    }
    if (![self getNetworkStatus]) {
        return [UIImage imageNamed:@"emptyReload"];
    }else {
        return nil;
    }
    
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    if (!self.isLoading) {
        return NO;
    }
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    self.loading = YES;
    [scrollView reloadEmptyDataSet];
    [self refreshData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    [scrollView reloadEmptyDataSet];
    [self refreshData];
}


- (BOOL)getNetworkStatus {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if(mgr.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
        //        [[HNPublicTool shareInstance] showHudMessage:@"没有网络，请检查手机网络连接"];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark 初始化 datasource delegate
- (void)refreshData {
    
}
@end
