//
//  ZAccountViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAccountViewController.h"
#import "ZLaunchManager.h"
#import "ZLoginViewModel.h"
#import "ZUserHelper.h"

#import "ZAgreementVC.h"

#define CountTimer 59
static NSUInteger myRetrieveTime = 59;
static NSTimer *retrieveTimer = nil;

@interface ZAccountViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *agreementView;


@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *getCodeBtn;

@property (nonatomic,strong) UIButton *resignBtn;
@property (nonatomic,strong) UIButton *getPasswdBtn;

@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *passwordTF;
@property (nonatomic,strong) UITextField *codeTF;
@property (nonatomic,strong) UIImageView *imageViewVerification;

@property (nonatomic,strong) YYLabel *protocolLabel;

@property (nonatomic,assign) BOOL isAgree;
@property (nonatomic,strong) ZLoginViewModel *loginViewModel;

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
    // Do any additional setup after loading the view.
    [self setData];
    [self setNavgation];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.userNameTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupMainView];
}

- (void)setData {
    _loginViewModel = [[ZLoginViewModel alloc] init];
    
    
    NSString *hadLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"hadLogin"];
    if (hadLogin) {
        self.isAgree = YES;
    }else{
        self.isAgree = NO;
    }
    
    // 是否可以登录
    RAC(self.loginBtn, enabled) = RACObserve(self.loginViewModel, isLoginEnable);
}

- (void)setNavgation {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
//    [self addRightBarButtonWithTitle:@"取消" actionBlick:^{
//        [[ZLaunchManager sharedInstance] showMainTab];
//    }];
//
    [self setTitle:@"登录"];
}

- (void)setupMainView {
    self.view.backgroundColor = KBackColor;
    
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = KFont9Color;
    hintLabel.text = @"账号登录";
    hintLabel.numberOfLines = 0;
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    [self.view addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(72));
    }];
    
    UIView *leftHintLineView = [[UIView alloc] init];
    leftHintLineView.backgroundColor = KFont9Color;
    [self.view addSubview:leftHintLineView];
    [leftHintLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(200));
        make.height.mas_equalTo(CGFloatIn750(1));
        make.centerY.equalTo(hintLabel.mas_centerY);
        make.right.equalTo(hintLabel.mas_left).offset(-CGFloatIn750(12));
    }];
    
    UIView *rightHintLineView = [[UIView alloc] init];
    rightHintLineView.backgroundColor = KFont9Color;
    [self.view addSubview:rightHintLineView];
    [rightHintLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(200));
        make.height.mas_equalTo(CGFloatIn750(1));
        make.centerY.equalTo(hintLabel.mas_centerY);
        make.left.equalTo(hintLabel.mas_right).offset(CGFloatIn750(12));
    }];
    
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, KScreenWidth - 30, 91)];
    contView.backgroundColor = [UIColor whiteColor];
    contView.layer.masksToBounds = YES;
    contView.layer.cornerRadius = 5;
    contView.layer.borderColor = KBorderColor.CGColor;
    contView.layer.borderWidth = CGFloatIn750(1);
    [self.view addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(22));
        make.height.mas_equalTo(CGFloatIn750(200));
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(22));
        make.top.equalTo(hintLabel.mas_bottom).offset(CGFloatIn750(72));
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = KBorderColor;
    [contView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(contView);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    
    [contView addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contView);
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(24));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(24));
        make.bottom.equalTo(lineView.mas_top);
    }];
    
    [contView addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contView.mas_bottom);
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(24));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(24));
        make.top.equalTo(lineView.mas_bottom);
    }];
    
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contView.mas_bottom).offset(CGFloatIn750(152));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(22));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(22));
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    UIView *getCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(172+12), CGFloatIn750(70))];
    ViewBorderRadius(self.getCodeBtn, 5, 0.5, KMainColor);
    
    [getCodeView addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(getCodeView);
        make.left.equalTo(getCodeView.mas_left).offset(CGFloatIn750(12));
    }];
    
    self.codeTF.rightView = getCodeView;
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    contView.alpha = 0;
    self.loginBtn.alpha = 0;
    
    contView.transform = CGAffineTransformMakeTranslation(KScreenWidth, 0);
    self.loginBtn.transform = CGAffineTransformMakeTranslation(KScreenWidth, 0);
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        contView.alpha = 1;
        
        contView.transform = CGAffineTransformMakeTranslation(0, 0);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:.5 delay:0.2 usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.loginBtn.alpha = 1;
        self.loginBtn.transform = CGAffineTransformMakeTranslation(0, 0);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    _protocolLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
    _protocolLabel.layer.masksToBounds = YES;
    _protocolLabel.textColor = KFont9Color;
    _protocolLabel.numberOfLines = 0;
    _protocolLabel.textAlignment = NSTextAlignmentCenter;
    [_protocolLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    [self.view addSubview:_protocolLabel];
    [_protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loginBtn.mas_centerX);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(CGFloatIn750(32));
    }];
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"我已阅读并同意遵守《幻轻服务条款》和《隐私协议》"];
    text.lineSpacing = 0;
    text.font = [UIFont systemFontOfSize:CGFloatIn750(22)];
    text.color = KFont9Color;
//    __weak typeof(self) weakself = self;
    
    [text setTextHighlightRange:NSMakeRange(9, 8) color:KMainColor backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        ZAgreementVC *avc = [[ZAgreementVC alloc] init];
        avc.navTitle = @"幻轻服务条款";
        avc.type = @"service_agreement";
        [self.navigationController pushViewController:avc animated:YES];
    }];
    
    [text setTextHighlightRange:NSMakeRange(18, 6) color:KMainColor backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        ZAgreementVC *avc = [[ZAgreementVC alloc] init];
        avc.navTitle = @"隐私协议";
        avc.type = @"privacy_policy";
        [self.navigationController pushViewController:avc animated:YES];
    }];
    
    
    _protocolLabel.preferredMaxLayoutWidth = kScreenWidth - CGFloatIn750(44); //设置最大的宽度
    _protocolLabel.attributedText = text;  //设置富文本
    
    [self.view addSubview:self.agreementView];
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.protocolLabel.mas_centerY).offset(-CGFloatIn750(4));
        make.right.equalTo(self.protocolLabel.mas_left).offset(-3);
        make.width.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *agreementBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [agreementBtn bk_addEventHandler:^(id sender) {
        weakSelf.isAgree = !weakSelf.isAgree;
    } forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:agreementBtn];
    [agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom);
        make.height.mas_equalTo(CGFloatIn750(100));
        make.width.mas_equalTo(CGFloatIn750(100));
        make.centerX.equalTo(self.agreementView.mas_centerX);
    }];
    
    UIButton *visterBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    visterBtn.layer.masksToBounds = YES;
    visterBtn.layer.cornerRadius = CGFloatIn750(40);
    visterBtn.layer.borderColor = KMainColor.CGColor;
    visterBtn.layer.borderWidth = 1;
    [visterBtn bk_addEventHandler:^(id sender) {
        [[ZLaunchManager sharedInstance] showMainTab];
    } forControlEvents:UIControlEventTouchUpInside];
    [visterBtn setTitle:@"游客模式" forState:UIControlStateNormal];
    [visterBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    [visterBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    [self.view addSubview:visterBtn];
    [visterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(180));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(CGFloatIn750(-80));
    }];
}

#pragma mark lazy loading
- (UITextField *)userNameTF {
    if (!_userNameTF ) {
        
        UIView *leftView = [self leftHintView:@"loginTel" title:@"手机号码"];
        _userNameTF  = [[UITextField alloc] init];
        _userNameTF.tag = 101;
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        _userNameTF.leftView = leftView;
        [_userNameTF setTextAlignment:NSTextAlignmentRight];
        [_userNameTF setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
        [_userNameTF setBorderStyle:UITextBorderStyleNone];
        [_userNameTF setBackgroundColor:[UIColor clearColor]];
        [_userNameTF setReturnKeyType:UIReturnKeyDone];
        [_userNameTF setPlaceholder:@"请输入您的手机号码"];
        [_userNameTF.rac_textSignal subscribeNext:^(NSString *x) {
            if (x.length > 11) {
                x = [x substringWithRange:NSMakeRange(0, 11)];
                _userNameTF.text = x;
            }
            self.loginViewModel.loginModel.tel = x;
        }];
        _userNameTF.delegate = self;
        _userNameTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _userNameTF;
}


- (UITextField *)passwordTF {
    if (!_passwordTF ) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.tag = 102;
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        [_passwordTF setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
        [_userNameTF setTextAlignment:NSTextAlignmentLeft];
        [_passwordTF setBorderStyle:UITextBorderStyleNone];
        [_passwordTF setBackgroundColor:[UIColor clearColor]];
//        [_passwordTF setReturnKeyType:UIReturnKeyDone];
        [_passwordTF setPlaceholder:@"密码"];
        [_passwordTF setSecureTextEntry:YES];
        _passwordTF.delegate = self;
        _passwordTF.keyboardType = UIKeyboardTypeDefault;
    }
    return _passwordTF;
}

- (UITextField *)codeTF {
    if (!_codeTF ) {
        
        UIView *leftView = [self leftHintView:@"loginCode" title:@"验证码"];
        
        _codeTF = [[UITextField alloc] init];
        _codeTF.tag = 103;
        _codeTF.leftView = leftView;
        _codeTF.leftViewMode = UITextFieldViewModeAlways;
        [_codeTF setFont:[UIFont systemFontOfSize:12]];
        [_codeTF setBorderStyle:UITextBorderStyleNone];
        [_codeTF setBackgroundColor:[UIColor clearColor]];
        [_codeTF setTextAlignment:NSTextAlignmentRight];
//        [_codeTF setReturnKeyType:UIReturnKeySearch];
//        [_codeTF setPlaceholder:@"验证码"];
//        [_codeTF setSecureTextEntry:YES];
        [_codeTF.rac_textSignal subscribeNext:^(NSString *x) {
            if (x.length > 6) {
                x = [x substringWithRange:NSMakeRange(0, 6)];
                _codeTF.text = x;
            }
            _codeTF.text = x;
            self.loginViewModel.loginModel.code = x;
        }];
        _codeTF.delegate = self;
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeTF;
}

- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        __weak typeof(self) weakSelf = self;
        _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_getCodeBtn bk_addEventHandler:^(id sender) {
            if (_userNameTF.text.length != 11) {
                [TLUIUtility showErrorHint:@"请输入正确的手机号" ];
                //        [[HNPublicTool shareInstance] showHudMessage:@"请输入正确的手机号"];
                return;
            }
            [self.loginViewModel codeWithTel:self.userNameTF.text block:^(BOOL isSuccess, NSString *message) {
                if (isSuccess) {
                    [TLUIUtility showSuccessHint:message];
                    [weakSelf.codeTF becomeFirstResponder];
                    DLog(@"login message %@",message);
                    if (myRetrieveTime == CountTimer) {
                        [self.getCodeBtn setTitle:@"60秒" forState:UIControlStateDisabled];
                        [self startTimer];
                        self.getCodeBtn.enabled = NO;
                    }
                }else{
                    [TLUIUtility showErrorHint:message];
                }
            }];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:KMainColor forState:UIControlStateNormal];
        [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _getCodeBtn;
}


- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn bk_addEventHandler:^(id sender) {
            [self.codeTF resignFirstResponder];
            [self.userNameTF resignFirstResponder];
            if (!self.isAgree) {
                [TLUIUtility showErrorHint:@"请阅读并同意遵守《幻轻服务条款》和《隐私协议》"];
                return ;
            }
            
            [self.loginViewModel loginWithUsername:self.loginViewModel.loginModel.tel password:self.loginViewModel.loginModel.code block:^(BOOL isSuccess, NSString *message) {
                if (isSuccess) {
                    [TLUIUtility showSuccessHint:message];
                }else{
                     [TLUIUtility showErrorHint:message];
                }
                
                DLog(@"login message %@",message);
//                ZPerfectUserInfoViewController *prefectVC = [[ZPerfectUserInfoViewController alloc] init];
//                PushVC(prefectVC);
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = CGFloatIn750(40);
        //        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"302d38"];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageWithColor:KMainColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageWithColor:KBorderColor] forState:UIControlStateDisabled];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(34)]];
    }
    return _loginBtn;
}

- (UIImageView *)agreementView {
    if (!_agreementView) {
        _agreementView = [[UIImageView alloc] init];
        _agreementView.layer.masksToBounds = YES;
        _agreementView.image = [UIImage imageNamed:@"seletBtnno"];
    }
    return _agreementView;
}

- (void)setIsAgree:(BOOL)isAgree {
    _isAgree = isAgree;
    
    if (isAgree) {
//        ViewBorderRadius(self.agreementView, CGFloatIn750(13), 0, [UIColor clearColor]);
        self.agreementView.image = [UIImage imageNamed:@"seletBtnyes"];
    }else{
//        ViewBorderRadius(self.agreementView , CGFloatIn750(13), 0.5, KLineColor);
        self.agreementView.image = [UIImage imageNamed:@"seletBtnno"];
    }
}


- (UIView *)leftHintView:(NSString *)image title:(NSString *)title {
    UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(200), CGFloatIn750(100))];
    
    UIImageView *hintImageView = [[UIImageView alloc] init];
    hintImageView.image = [UIImage imageNamed:image];
    hintImageView.layer.masksToBounds = YES;
    [hintView addSubview:hintImageView];
    [hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintView.mas_left).offset(CGFloatIn750(CGFloatIn750(24)));
        make.centerY.equalTo(hintView.mas_centerY);
//        make.width.height.mas_equalTo(CGFloatIn750(29));
    }];
    
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = KFont6Color;
    hintLabel.text = title;
    hintLabel.textAlignment = NSTextAlignmentLeft;
    [hintLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    [hintView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintImageView.mas_right).offset(CGFloatIn750(CGFloatIn750(14)));
        make.centerY.equalTo(hintView.mas_centerY);
    }];
    
    
    return hintView;
}

#pragma mark 按钮 click
- (void)startTimer {
    [retrieveTimer invalidate];
    retrieveTimer = nil;
    if (!retrieveTimer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
        retrieveTimer = timer;
        [[NSRunLoop mainRunLoop] addTimer:retrieveTimer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - 定时器方法
- (void)timerChange{
    if (myRetrieveTime == -1) {
        [retrieveTimer invalidate];
        retrieveTimer = nil;
        myRetrieveTime = CountTimer;
        self.getCodeBtn.enabled = YES;
        
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateDisabled];
        return;
    }
    
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",myRetrieveTime] forState:UIControlStateDisabled];
    myRetrieveTime --;
    
}



#pragma mark textField delegate ---------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *regexString;
    if (textField.tag == 101) {
        regexString = @"^\\d{0,11}$";
    }else if (textField.tag == 103) {
        
         regexString = @"^\\d*$";
    }

    NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];

    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];

    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
}

@end

