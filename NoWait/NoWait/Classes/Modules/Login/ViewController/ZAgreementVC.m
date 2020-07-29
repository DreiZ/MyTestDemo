//
//  ZAgreementVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAgreementVC.h"

@interface ZAgreementVC ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *contentWebView;

@end

@implementation ZAgreementVC


- (instancetype)init {
    self = [super init];
    if (self) {
        self.analyzeTitle = @"协议页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationItem setTitle:self.model.navTitle];
    
    [self setMainView];
    [self.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0]];
//    [self.contentWebView loadRequest:[NSURLRequest ]];
}

- (void)setMainView {
    _contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-(kNavBarHeight+kStatusBarHeight))];
    _contentWebView.delegate = self;
    [_contentWebView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_contentWebView];
    UIScrollView *tempView = (UIScrollView *)[_contentWebView.subviews objectAtIndex:0];
    tempView.scrollEnabled = YES;
    tempView.pinchGestureRecognizer.enabled = YES;
}


#pragma mark  webViewDelegate
- (void) webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
@end

#pragma mark - RouteHandler
@interface ZAgreementVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZAgreementVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_agreement;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZAgreementVC *routevc = [[ZAgreementVC alloc] init];
    routevc.model = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
