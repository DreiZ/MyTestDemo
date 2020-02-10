//
//  ZAccountViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAccountViewController.h"
#import <IQKeyboardReturnKeyHandler.h>

#import "ZLaunchManager.h"
#import "ZLoginViewModel.h"
#import "ZUserHelper.h"

#import "ZAgreementVC.h"
#import "ZLoginView.h"
#import "ZRegisterView.h"


@interface ZAccountViewController ()<UITextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *agreementView;


@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *resignBtn;
@property (nonatomic,strong) UIView *selectLineView;
@property (nonatomic,strong) UIScrollView *iScrollView;
@property (nonatomic,strong) ZRegisterView *registerView;
@property (nonatomic,strong) ZLoginView *loginView;



@property (nonatomic,strong) ZLoginViewModel *loginViewModel;
@property (nonatomic,assign) NSInteger index;
@end

@implementation ZAccountViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        self.analyzeTitle = @"登录页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.loginView inputResignFirstResponder];
    [self.registerView inputResignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupMainView];
}


- (void)setNavgation {
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)initData {
    _index = 0;
}

- (void)setupMainView {
    self.view.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [closeBtn bk_whenTapped:^{
        [[ZLaunchManager sharedInstance] showMainTab];
    }];
    [closeBtn setImage:[UIImage imageNamed:@"lessonSelectClose"] forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(120));
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(kTopHeight + 20));
    }];
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"loginLogo"];
    logoImageView.layer.masksToBounds = YES;
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(178));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(190));
    }];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = KMainColor;
    hintLabel.text = @"艺动";
    hintLabel.numberOfLines = 0;
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(42)]];
    [self.view addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(CGFloatIn750(50));
        make.top.equalTo(logoImageView.mas_bottom).offset(CGFloatIn750(2));
    }];
    
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(100));
        make.right.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(hintLabel.mas_bottom).offset(CGFloatIn750(80));
    }];
    
    [self.view addSubview:self.resignBtn];
    [self.resignBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-100));
        make.left.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(self.loginBtn);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.5)];
    lineView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.resignBtn.mas_right);
        make.height.mas_equalTo(0);
        make.left.equalTo(self.loginBtn.mas_left);
        make.top.equalTo(self.loginBtn.mas_bottom);
    }];
    
    UIView *hintLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.5)];
    hintLineView.backgroundColor = KAdaptAndDarkColor(KLineColor, K2eBackColor);
    [lineView addSubview:hintLineView];
    [hintLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.resignBtn.mas_right);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.loginBtn.mas_left);
        make.top.equalTo(self.loginBtn.mas_bottom);
    }];
    
    [lineView addSubview:self.selectLineView];
    self.selectLineView.frame = CGRectMake(0, 0, (KScreenWidth-CGFloatIn750(200))/2, 1);
    
    [self.view addSubview:self.iScrollView];
    [_iScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(hintLineView.mas_bottom).offset(1);
    }];
    self.iScrollView.clipsToBounds = YES;
   
    [self.iScrollView addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(CGFloatIn750(0));
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.width.mas_equalTo(KScreenWidth);
    }];
    
    [self.iScrollView addSubview:self.registerView];
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iScrollView);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(KScreenWidth);
        make.width.mas_equalTo(KScreenWidth);
    }];
    
    self.index = 0;
}

#pragma mark lazy loading
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        __weak typeof(self) weakSelf = self;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn bk_addEventHandler:^(id sender) {
            weakSelf.selectLineView.frame = CGRectMake(0, 0, (KScreenWidth-CGFloatIn750(200))/2, 1);
            
            [weakSelf.iScrollView setContentOffset:CGPointMake(0, 0)];
            
            weakSelf.index = 0;
        } forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = CGFloatIn750(40);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(38)]];
    }
    return _loginBtn;
}

- (UIButton *)resignBtn {
    if (!_resignBtn) {
        __weak typeof(self) weakSelf = self;
        _resignBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_resignBtn bk_addEventHandler:^(id sender) {
            weakSelf.selectLineView.frame = CGRectMake((KScreenWidth-CGFloatIn750(200))/2, 0, (KScreenWidth-CGFloatIn750(200))/2, 1);
            
            [weakSelf.iScrollView setContentOffset:CGPointMake(KScreenWidth, 0)];
            
            weakSelf.index = 1;
        } forControlEvents:UIControlEventTouchUpInside];
        
        _resignBtn.layer.masksToBounds = YES;
        _resignBtn.layer.cornerRadius = CGFloatIn750(40);
        [_resignBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_resignBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        [_resignBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(38)]];
    }
    return _resignBtn;
}

- (UIView *)selectLineView {
    if (!_selectLineView) {
        _selectLineView = [[UIView alloc] init];
        _selectLineView.layer.masksToBounds = YES;
        _selectLineView.backgroundColor = KMainColor;
    }
    return _selectLineView;
}

- (UIScrollView *)iScrollView {
    if(!_iScrollView) {
        _iScrollView = [[UIScrollView alloc] init];
        _iScrollView.delegate = self;
        _iScrollView.backgroundColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _iScrollView.pagingEnabled = YES;
        _iScrollView.bounces = NO;
        _iScrollView.showsHorizontalScrollIndicator = NO;
        _iScrollView.contentSize = CGSizeMake(KScreenWidth*2, 1);
    }
    return _iScrollView;
}

- (ZRegisterView *)registerView {
    if (!_registerView) {
        _registerView = [[ZRegisterView alloc] initWithFrame:CGRectZero];
    }
    return _registerView;
}

- (ZLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[ZLoginView alloc] initWithFrame:CGRectZero];
    }
    return _loginView;
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.selectLineView.frame = CGRectMake(scrollView.contentOffset.x * ((KScreenWidth - CGFloatIn750(200))/(KScreenWidth*2)) , 0, (KScreenWidth-CGFloatIn750(200))/2, 2);
    
    CGPoint offSet = scrollView.contentOffset;
    NSInteger page = (offSet.x / KScreenWidth + 0.5);
    self.index = page;
}


#pragma mark set index
- (void )setIndex:(NSInteger)index {
    _index = index;
    if (self.index == 0) {
        [self.loginBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        [self.resignBtn setTitleColor:KFont9Color forState:UIControlStateNormal];
        
        [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(38)]];
        [self.resignBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
    }else if(self.index == 1){
        [self.loginBtn setTitleColor:KFont9Color forState:UIControlStateNormal];
        [self.resignBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
        [self.resignBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(38)]];
    }
}

@end

