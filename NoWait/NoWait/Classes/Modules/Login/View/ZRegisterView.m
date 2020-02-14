//
//  ZRegisterView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRegisterView.h"
#import "ZLoginViewModel.h"
#import "ZLoginModel.h"

#define CountTimer 59
static NSUInteger myRetrieveTime = 59;
static NSTimer *retrieveTimer = nil;

@interface ZRegisterView ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *agreementView;
@property (nonatomic,strong) YYLabel *protocolLabel;

@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *getCodeBtn;

@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *passwordTF;
@property (nonatomic,strong) UITextField *codeTF;
@property (nonatomic,strong) UITextField *messageCodeTF;
@property (nonatomic,strong) UIButton *pooCodeView;
@property (nonatomic,strong) NSString *codeString;
@property (nonatomic,strong) ZLoginViewModel *loginViewModel;


@property (nonatomic,assign) BOOL isAgree;

@end

@implementation ZRegisterView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark --初始化view----------------
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;

    _loginViewModel = [[ZLoginViewModel alloc] init];
 
    UIView *contView = [[UIView alloc] init];
    contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    contView.layer.masksToBounds = YES;
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(50));
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(50));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(40));
    }];
        
    
    UIView *nLineView = [[UIView alloc] init];
    nLineView.backgroundColor = [UIColor  colorMain];
    [contView addSubview:nLineView];
    [nLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(contView);
        make.top.equalTo(contView.mas_top).offset(CGFloatIn750(100));
    }];
    
    
    [contView addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(0));
        make.bottom.equalTo(nLineView.mas_top);
    }];
    
    UIView *mcLineView = [[UIView alloc] init];
     mcLineView.backgroundColor = [UIColor  colorMain];
     [contView addSubview:mcLineView];
     [mcLineView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(0.5);
         make.left.right.equalTo(contView);
         make.top.equalTo(nLineView.mas_bottom).offset(CGFloatIn750(96));
     }];
     
    
     

    [contView addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(190));
        make.bottom.equalTo(mcLineView.mas_top);
    }];

    UIView *tLineView = [[UIView alloc] init];
    tLineView.backgroundColor = [UIColor  colorMain];
    [contView addSubview:tLineView];
    [tLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(contView);
        make.top.equalTo(mcLineView.mas_bottom).offset(CGFloatIn750(96));
    }];
    
   
    [contView addSubview:self.messageCodeTF];
    [self.messageCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(190));
        make.bottom.equalTo(tLineView.mas_top);
    }];
    
    UIView *pLineView = [[UIView alloc] init];
     pLineView.backgroundColor = [UIColor  colorMain];
     [contView addSubview:pLineView];
     [pLineView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(0.5);
         make.left.right.equalTo(contView);
         make.top.equalTo(tLineView.mas_bottom).offset(CGFloatIn750(96));
     }];
     
    
     [contView addSubview:self.passwordTF];
     [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(CGFloatIn750(80));
         make.left.equalTo(contView.mas_left).offset(CGFloatIn750(0));
         make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(0));
         make.bottom.equalTo(pLineView.mas_top);
     }];
    
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorGrayLine] forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorTextGray] forState:UIControlStateHighlighted];
    [forgetBtn.titleLabel setFont:[UIFont fontSmall]];
    [forgetBtn bk_whenTapped:^{
        
    }];
    [contView addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(140));
        make.height.mas_equalTo(CGFloatIn750(70));
        make.right.equalTo(self.passwordTF.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.passwordTF.mas_bottom).offset(CGFloatIn750(4));
    }];
    
    
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTF.mas_bottom).offset(CGFloatIn750(82));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(10));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(10));
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    __weak typeof(self) weakSelf = self;
    //1.默认
    _pooCodeView = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 68, 28)];
    [_pooCodeView setTitle:@"图形验证码" forState:UIControlStateNormal];
    [_pooCodeView.titleLabel setFont:[UIFont fontSmall]];
    [_pooCodeView setTitleColor:[UIColor  colorMain] forState:UIControlStateNormal];
    [_pooCodeView bk_whenTapped:^{
        [weakSelf getImageCode];
    }];
    
    [contView addSubview:self.pooCodeView];
    [self.pooCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contView.mas_right);
        make.centerY.equalTo(self.codeTF.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(148));
        make.height.mas_equalTo(CGFloatIn750(60));
    }];
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    //获取验证码
    UIView *getCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(172+12), CGFloatIn750(70))];
    ViewBorderRadius(self.getCodeBtn, 5, 0.5, [UIColor  colorMain]);
    
    [getCodeView addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(getCodeView);
        make.left.equalTo(getCodeView.mas_left).offset(CGFloatIn750(12));
    }];
    [contView addSubview:getCodeView];
    [getCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contView.mas_right);
        make.centerY.equalTo(self.messageCodeTF.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(184));
        make.height.mas_equalTo(CGFloatIn750(70));
    }];
//    self.messageCodeTF.rightView = getCodeView;
//    self.messageCodeTF.rightViewMode = UITextFieldViewModeAlways;
    
    _protocolLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
    _protocolLabel.layer.masksToBounds = YES;
    _protocolLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray]);
    _protocolLabel.numberOfLines = 0;
    _protocolLabel.textAlignment = NSTextAlignmentCenter;
    [_protocolLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    [self addSubview:_protocolLabel];
    [_protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loginBtn.mas_centerX);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(CGFloatIn750(32));
    }];
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"我已阅读并同意遵守《莫等闲服务条款》和《隐私协议》"];
    text.lineSpacing = 0;
    text.font = [UIFont systemFontOfSize:CGFloatIn750(22)];
    text.color = [UIColor colorTextGray1];
    //    __weak typeof(self) weakself = self;
    
    [text setTextHighlightRange:NSMakeRange(9, 8) color:[UIColor  colorMain] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        ZAgreementVC *avc = [[ZAgreementVC alloc] init];
//        avc.navTitle = @"莫等闲服务条款";
//        avc.type = @"service_agreement";
//        [self.navigationController pushViewController:avc animated:YES];
    }];
    
    [text setTextHighlightRange:NSMakeRange(18, 6) color:[UIColor  colorMain] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        ZAgreementVC *avc = [[ZAgreementVC alloc] init];
//        avc.navTitle = @"隐私协议";
//        avc.type = @"privacy_policy";
//        [self.navigationController pushViewController:avc animated:YES];
    }];
    
    
    _protocolLabel.preferredMaxLayoutWidth = kScreenWidth - CGFloatIn750(44); //设置最大的宽度
    _protocolLabel.attributedText = text;  //设置富文本
    
    [self addSubview:self.agreementView];
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.protocolLabel.mas_centerY).offset(-CGFloatIn750(4));
        make.right.equalTo(self.protocolLabel.mas_left).offset(-3);
        make.width.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    UIButton *agreementBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [agreementBtn bk_addEventHandler:^(id sender) {
        weakSelf.isAgree = !weakSelf.isAgree;
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:agreementBtn];
    [agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom);
        make.height.mas_equalTo(CGFloatIn750(100));
        make.width.mas_equalTo(CGFloatIn750(100));
        make.centerX.equalTo(self.agreementView.mas_centerX);
    }];
    
    UIButton *visterBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    visterBtn.layer.masksToBounds = YES;
    visterBtn.layer.cornerRadius = CGFloatIn750(40);
    visterBtn.layer.borderColor = [UIColor  colorMain].CGColor;
    visterBtn.layer.borderWidth = 1;
    [visterBtn bk_addEventHandler:^(id sender) {
//        [[ZLaunchManager sharedInstance] showMainTab];
    } forControlEvents:UIControlEventTouchUpInside];
    [visterBtn setTitle:@"游客模式" forState:UIControlStateNormal];
    [visterBtn setTitleColor:[UIColor  colorMain] forState:UIControlStateNormal];
    [visterBtn.titleLabel setFont:[UIFont fontContent]];
    [self addSubview:visterBtn];
    [visterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(180));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-80));
    }];
    
    
    // 是否可以登录
   RAC(self.loginBtn, enabled) = RACObserve(weakSelf.loginViewModel, isRegisterEnable);
    
    
    [self getImageCode];
    NSString *hadLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"hadLogin"];
    if (hadLogin) {
       self.isAgree = YES;
    }else{
       self.isAgree = NO;
    }
}
        
#pragma mark lazy loading
- (UITextField *)userNameTF {
    if (!_userNameTF ) {
        __weak typeof(self) weakSelf = self;
        UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(80), CGFloatIn750(80))];
        
        UIImageView *hintImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloatIn750(48))/2, (CGFloatIn750(48))/2, CGFloatIn750(32), CGFloatIn750(32))];
        hintImageView.image = [UIImage imageNamed:@"loginUserName"];
        hintImageView.layer.masksToBounds = YES;
        [hintView addSubview:hintImageView];
        
        _userNameTF  = [[UITextField alloc] init];
        _userNameTF.tag = 101;
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        _userNameTF.leftView = hintView;
        [_userNameTF setTextAlignment:NSTextAlignmentLeft];
        [_userNameTF setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
        [_userNameTF setBorderStyle:UITextBorderStyleNone];
        [_userNameTF setBackgroundColor:[UIColor clearColor]];
        [_userNameTF setReturnKeyType:UIReturnKeyDone];
        [_userNameTF setPlaceholder:@"请输入手机号码"];
        [_userNameTF.rac_textSignal subscribeNext:^(NSString *x) {
            if (x.length > 11) {
                x = [x substringWithRange:NSMakeRange(0, 11)];
                weakSelf.userNameTF.text = x;
            }
            if (weakSelf.editBlock) {
                weakSelf.editBlock(0, x);
            }
            weakSelf.loginViewModel.registerModel.tel = x;
        }];
        _userNameTF.delegate = self;
        _userNameTF.keyboardType = UIKeyboardTypePhonePad;
        _userNameTF.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
    }
    return _userNameTF;
}


- (UITextField *)passwordTF {
    if (!_passwordTF ) {
        __weak typeof(self) weakSelf = self;
        UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(80), CGFloatIn750(80))];
        
        UIImageView *hintImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloatIn750(48))/2, (CGFloatIn750(48))/2, CGFloatIn750(32), CGFloatIn750(32))];
        hintImageView.image = [UIImage imageNamed:@"LoginPassword"];
        hintImageView.layer.masksToBounds = YES;
        [hintView addSubview:hintImageView];
        
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.tag = 104;
        _passwordTF.leftView = hintView;
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        _passwordTF.delegate = self;
        _passwordTF.keyboardType = UIKeyboardTypeDefault;
        [_passwordTF setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
        [_userNameTF setTextAlignment:NSTextAlignmentLeft];
        [_passwordTF setBorderStyle:UITextBorderStyleNone];
        [_passwordTF setBackgroundColor:[UIColor clearColor]];
        [_passwordTF setReturnKeyType:UIReturnKeyDone];
        [_passwordTF setPlaceholder:@"请输入密码"];
        [_passwordTF setSecureTextEntry:YES];
        
        [_passwordTF.rac_textSignal subscribeNext:^(NSString *x) {
            weakSelf.passwordTF.text = x;
            if (weakSelf.editBlock) {
                weakSelf.editBlock(1, x);
            }
            weakSelf.loginViewModel.registerModel.pwd = x;
        }];
        _passwordTF.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
    }
    return _passwordTF;
}


- (UITextField *)messageCodeTF {
    if (!_messageCodeTF ) {
        __weak typeof(self) weakSelf = self;
        UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(80), CGFloatIn750(80))];
        
        UIImageView *hintImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloatIn750(48))/2, (CGFloatIn750(48))/2, CGFloatIn750(32), CGFloatIn750(32))];
        hintImageView.image = [UIImage imageNamed:@"loginCode"];
        hintImageView.layer.masksToBounds = YES;
        [hintView addSubview:hintImageView];
        
        _messageCodeTF = [[UITextField alloc] init];
        _messageCodeTF.tag = 102;
        _messageCodeTF.leftView = hintView;
        _messageCodeTF.leftViewMode = UITextFieldViewModeAlways;
        [_messageCodeTF setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
        [_messageCodeTF setBorderStyle:UITextBorderStyleNone];
        [_messageCodeTF setBackgroundColor:[UIColor clearColor]];
        [_messageCodeTF setTextAlignment:NSTextAlignmentLeft];
        [_messageCodeTF setPlaceholder:@"请输入验证码"];
        [_messageCodeTF.rac_textSignal subscribeNext:^(NSString *x) {
            if (x.length > 6) {
                x = [x substringWithRange:NSMakeRange(0, 6)];
                weakSelf.messageCodeTF.text = x;
            }
            if (weakSelf.editBlock) {
                weakSelf.editBlock(2, x);
            }
            weakSelf.loginViewModel.registerModel.messageCode = x;
        }];
        _messageCodeTF.delegate = self;
        _messageCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _messageCodeTF.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
    }
    return _messageCodeTF;
}

- (UITextField *)codeTF {
    if (!_codeTF ) {
        __weak typeof(self) weakSelf = self;
        UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(80), CGFloatIn750(80))];
        
        UIImageView *hintImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGFloatIn750(48))/2, (CGFloatIn750(48))/2, CGFloatIn750(32), CGFloatIn750(32))];
        hintImageView.image = [UIImage imageNamed:@"loginCode"];
        hintImageView.layer.masksToBounds = YES;
        [hintView addSubview:hintImageView];
        
        _codeTF = [[UITextField alloc] init];
        _codeTF.tag = 103;
        _codeTF.leftView = hintView;
        _codeTF.leftViewMode = UITextFieldViewModeAlways;
        [_codeTF setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
        [_codeTF setBorderStyle:UITextBorderStyleNone];
        [_codeTF setBackgroundColor:[UIColor clearColor]];
        [_codeTF setTextAlignment:NSTextAlignmentLeft];
        [_codeTF setPlaceholder:@"请输入图形验证码"];
       [_codeTF.rac_textSignal subscribeNext:^(NSString *x) {
            if (x.length > 4) {
                x = [x substringWithRange:NSMakeRange(0, 4)];
                weakSelf.codeTF.text = x;
            }
            if (weakSelf.editBlock) {
                weakSelf.editBlock(3, x);
            }
            weakSelf.loginViewModel.registerModel.code = x;
        }];
        _codeTF.delegate = self;
        _codeTF.keyboardType = UIKeyboardTypeDefault;
        _codeTF.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
    }
    return _codeTF;
}


- (UIButton *)loginBtn {
    if (!_loginBtn) {
        __weak typeof(self) weakSelf = self;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn bk_addEventHandler:^(id sender) {
            [weakSelf inputResignFirstResponder];
            
            if (!self.isAgree) {
                [TLUIUtility showErrorHint:@"请阅读并同意遵守《莫等闲服务条款》和《隐私协议》"];
                return ;
            }
            
            NSMutableDictionary *params = @{}.mutableCopy;
            if (self.loginViewModel.registerModel.tel && self.loginViewModel.registerModel.tel.length == 11) {
                [params setObject:self.loginViewModel.registerModel.tel forKey:@"phone"];
            }else{
                return;
            }
            
            if (self.loginViewModel.registerModel.pwd && self.loginViewModel.registerModel.pwd.length > 8) {
                if ([self checkPassword:self.loginViewModel.registerModel.pwd]) {
                    [params setObject:self.loginViewModel.registerModel.pwd forKey:@"password"];
                }else{
                    [TLUIUtility showErrorHint:@"密码必须大于8位，且包含大小写字母及数字"];
                    return;
                }
                
            }else{
                [TLUIUtility showErrorHint:@"密码必须大于8位，且包含大小写字母及数字"];
                return;
            }
            
            if (self.loginViewModel.registerModel.messageCode && self.loginViewModel.registerModel.messageCode.length == 6) {
                [params setObject:self.loginViewModel.registerModel.messageCode forKey:@"code"];
            }else{
                return;
            }

            [self.loginViewModel retrieveWithParams:params block:^(BOOL isSuccess, id message) {
                if (isSuccess) {
                    [TLUIUtility showSuccessHint:message];
                }else{
                    [TLUIUtility showErrorHint:message];
                }
            }];

        } forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = CGFloatIn750(40);
        //        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"302d38"];
        [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor  colorMain]] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorGrayLine]] forState:UIControlStateDisabled];
        [_loginBtn.titleLabel setFont:[UIFont fontTitle]];
    }
    return _loginBtn;
}


- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        __weak typeof(self) weakSelf = self;
        _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_getCodeBtn bk_addEventHandler:^(id sender) {
            if (!weakSelf.loginViewModel.registerModel.tel || weakSelf.loginViewModel.registerModel.tel.length != 11) {
                [TLUIUtility showErrorHint:@"请输入正确的手机号" ];
                //        [[HNPublicTool shareInstance] showHudMessage:@"请输入正确的手机号"];
                return;
            }
            
            if (!weakSelf.loginViewModel.registerModel.code || weakSelf.loginViewModel.registerModel.code.length != 4) {
                [TLUIUtility showErrorHint:@"请输入图形验证码" ];
                //        [[HNPublicTool shareInstance] showHudMessage:@"请输入正确的手机号"];
                return;
            }
            
            NSMutableDictionary *params = @{@"ckey":weakSelf.loginViewModel.registerModel.ckey,@"captcha":weakSelf.loginViewModel.registerModel.code,@"phone":weakSelf.loginViewModel.registerModel.tel}.mutableCopy;
            [self.loginViewModel codeWithParams:params block:^(BOOL isSuccess, id message) {
               if (isSuccess) {
                   [TLUIUtility showSuccessHint:message];
                   [weakSelf.messageCodeTF becomeFirstResponder];
                   DLog(@"login message %@",message);
                   if (myRetrieveTime == CountTimer) {
                       [weakSelf.getCodeBtn setTitle:@"60秒" forState:UIControlStateDisabled];
                       [weakSelf startTimer];
                       weakSelf.getCodeBtn.enabled = NO;
                   }
               }else{
                   [TLUIUtility showErrorHint:message];
               }
            }];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _getCodeBtn;
}

- (UIImageView *)agreementView {
    if (!_agreementView) {
        _agreementView = [[UIImageView alloc] init];
        _agreementView.layer.masksToBounds = YES;
        _agreementView.image = [UIImage imageNamed:@"studentNoSelect"];
    }
    return _agreementView;
}


#pragma mark --setting----------------
- (void)setIsAgree:(BOOL)isAgree {
    _isAgree = isAgree;
    
    if (isAgree) {
        self.agreementView.image = [UIImage imageNamed:@"studentSelect"];
    }else{
        self.agreementView.image = [UIImage imageNamed:@"studentNoSelect"];
    }
}


#pragma mark textField delegate ---------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *regexString;
    if (textField.tag == 101) {
        regexString = @"^\\d{0,11}$";
    }else if (textField.tag == 102) {
        regexString = @"^\\d*$";
    }else if (textField.tag == 103 ){
        regexString = @"^[a-zA-Z0-9]*$";
    }else{
        return YES;
    }
    
    NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    
    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
}

#pragma mark --按钮 click
- (void)startTimer {
    [retrieveTimer invalidate];
    retrieveTimer = nil;
    if (!retrieveTimer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
        retrieveTimer = timer;
        [[NSRunLoop mainRunLoop] addTimer:retrieveTimer forMode:NSRunLoopCommonModes];
    }
}

// 定时器方法
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

- (void)inputResignFirstResponder {
    [self.userNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
    [self.messageCodeTF resignFirstResponder];
}

- (void)getImageCode {
    __weak typeof(self) weakSelf = self;
    [self.loginViewModel imageCodeWith:@"" block:^(BOOL isSuccess, id message) {
        if (isSuccess) {
            [weakSelf.pooCodeView setTitle:@"" forState:UIControlStateNormal];
            ZImageCodeBackModel *model = message;
            NSString *str = model.img;
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            str = [str substringFromIndex:@"data:image/png;base64,".length];
            NSString *encodedImageStr = str;
            NSData *decodedImgData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *image = [UIImage imageWithData:decodedImgData];
            [weakSelf.pooCodeView setBackgroundImage:image forState:UIControlStateNormal];
            weakSelf.loginViewModel.registerModel.ckey = model.ckey;
        }else{
            if ([message isKindOfClass:[NSString class]]) {
                [TLUIUtility showErrorHint:message];
            }
        }
    }];
}

- (BOOL)checkPassword:(NSString *)password {
    NSString *newPattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",newPattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}
@end
