//
//  ZViewController.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/15.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAnimatedImageView.h"
#import "UIViewController+PopGesture.h"
#import "XYTransitionProtocol.h"
#import "UIScrollView+EmptyDataSet.h"


@interface ZViewController : UIViewController <XYTransitionProtocol,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
//是否在加载中
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic, strong) NSString *emptyDataStr;
@property (nonatomic, strong) NSString *emptyImage;

@property (nonatomic, strong) NSString *analyzeTitle;
@property (nonatomic, assign) NSInteger currentPage;

/// 当前VC stutusBar的状态，仅在viewWillAppear时生效，默认LightContent
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

@property (nonatomic, strong) UIImage *headerImage;
@property (nonatomic, assign) BOOL isTransition;//是否开启转场动画

- (void)refreshData;
- (void)setNavgation;

@end
