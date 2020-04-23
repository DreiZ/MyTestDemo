//
//  ZWebBridgeViewController.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/24.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZWebBridgeViewController.h"
#import "ZDSBridgePublicManager.h"
#import "dsbridge.h"
#import "DWKWebView.h"

#import "ZViewController.h"

@interface ZWebBridgeViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) DWKWebView *iWebView;
@property (nonatomic,strong) UIView *navView;
/** UI */
@property (nonatomic, strong) UIProgressView *myProgressView;

@property (nonatomic, strong) ZDSBridgePublicManager *dsBridge;
@end

@implementation ZWebBridgeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.analyzeTitle = @"桥接web页面";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:SafeStr(self.navTitle)];
    [self initMainView];
}


- (void)initMainView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    _url = [_url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    
    [self.iWebView loadRequest:testRequest];
    [self.view addSubview:_iWebView];
    [self.iWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.myProgressView];
    [self.myProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(kStatusBarHeight + kNavBarHeight);
        make.height.mas_equalTo(1);
    }];
    
//    //监听UIWindow显示
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(beginFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];
    //监听UIWindow隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];
}

-(void)endFullScreen{
    DLog(@"退出全屏");
//    [[UIApplication sharedApplication] setStatusBarHidden:false animated:false];
    [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationSlide];
}

// 记得取消监听
- (void)dealloc
{
    [self.iWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavBarHeight, KScreenWidth, 1)];
        _myProgressView.tintColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _myProgressView;
}

- (DWKWebView *)iWebView {
    if (!_iWebView) {
        _iWebView = [[DWKWebView alloc] initWithFrame:CGRectMake(0, 0 , KScreenWidth, KScreenHeight-(kStatusBarHeight ))];
        _iWebView.backgroundColor = [UIColor whiteColor];
       
        _dsBridge = [ZDSBridgePublicManager sharedManager];
        
        
        [_iWebView addJavascriptObject:_dsBridge namespace:nil];
        _iWebView.DSUIDelegate = self;
        _iWebView.navigationDelegate = self;
        _iWebView.scrollView.bounces = NO;

        [_iWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _iWebView;
}


- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kStatusBarHeight + kNavBarHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
        
        
        
        __weak typeof(self) weakSelf = self;
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [backBtn setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
        [backBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.presentingViewController) {
                [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }else{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(kNavBarHeight);
            make.left.equalTo(self.navView.mas_left);
            make.top.equalTo(self.navView.mas_top).offset(kStatusBarHeight);
        }];
    }
    return _navView;
}


#pragma mark WKWebView代理方法 WKNavigationDelegate 协议
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    DLog(@"webView 开始加载");
    
}
// 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    DLog(@"webView 内容开始返回");
}
// 页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    DLog(@"webView 页面加载完成");
    self.navView.hidden = YES;
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error {
    DLog(@"webView 页面加载失败");
    self.navView.hidden = NO;
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.iWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
