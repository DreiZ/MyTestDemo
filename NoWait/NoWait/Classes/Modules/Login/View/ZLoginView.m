//
//  ZLoginView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLoginView.h"
#import "PooCodeView.h"
#import "ZLoginViewModel.h"
#import "ZLoginModel.h"


@interface ZLoginView ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *agreementView;
@property (nonatomic,strong) YYLabel *protocolLabel;

@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *passwordTF;
@property (nonatomic,strong) UITextField *codeTF;
@property (nonatomic,strong) PooCodeView *pooCodeView;
@property (nonatomic,strong) NSString *codeString;
@property (nonatomic,strong) ZLoginViewModel *loginViewModel;


@property (nonatomic,assign) BOOL isAgree;

@end

@implementation ZLoginView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;

    _loginViewModel = [[ZLoginViewModel alloc] init];
   
    UIView *contView = [[UIView alloc] init];
    contView.backgroundColor = [UIColor whiteColor];
    contView.layer.masksToBounds = YES;
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(50));
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(50));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(40));
    }];
        
    
    UIView *nLineView = [[UIView alloc] init];
    nLineView.backgroundColor = KMainColor;
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

    UIView *pLineView = [[UIView alloc] init];
    pLineView.backgroundColor = KMainColor;
    [contView addSubview:pLineView];
    [pLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(contView);
        make.top.equalTo(nLineView.mas_bottom).offset(CGFloatIn750(96));
    }];
    
   
    [contView addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(0));
        make.bottom.equalTo(pLineView.mas_top);
    }];

    UIView *tLineView = [[UIView alloc] init];
    tLineView.backgroundColor = KMainColor;
    [contView addSubview:tLineView];
    [tLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(contView);
        make.top.equalTo(pLineView.mas_bottom).offset(CGFloatIn750(96));
    }];
    
   
    [contView addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(0));
        make.bottom.equalTo(tLineView.mas_top);
    }];
    
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:KLineColor forState:UIControlStateNormal];
    [forgetBtn setTitleColor:KFont6Color forState:UIControlStateHighlighted];
    [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    [contView addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(140));
        make.height.mas_equalTo(CGFloatIn750(70));
        make.right.equalTo(self.codeTF.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.codeTF.mas_bottom).offset(CGFloatIn750(4));
    }];
   
    
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTF.mas_bottom).offset(CGFloatIn750(162));
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(10));
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(10));
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
     
    __weak typeof(self) weakSelf = self;
    //1.默认
    _pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(10, 100, 68, 28) andChangeArray:nil];
    //注意:文字高度不能大于poocodeview高度,否则crash
    _pooCodeView.textSize = 18;
    _pooCodeView.changBlock = ^(NSString *codeString) {
        weakSelf.codeString = codeString;
    };
    
    //不设置为blackColor
    _pooCodeView.textColor = KMainColor;
    self.codeTF.rightView = _pooCodeView;
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    _protocolLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
    _protocolLabel.layer.masksToBounds = YES;
    _protocolLabel.textColor = KFont9Color;
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
    text.color = KFont9Color;
    //    __weak typeof(self) weakself = self;
    
    [text setTextHighlightRange:NSMakeRange(9, 8) color:KMainColor backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        ZAgreementVC *avc = [[ZAgreementVC alloc] init];
//        avc.navTitle = @"莫等闲服务条款";
//        avc.type = @"service_agreement";
//        [self.navigationController pushViewController:avc animated:YES];
    }];
    
    [text setTextHighlightRange:NSMakeRange(18, 6) color:KMainColor backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
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
    visterBtn.layer.borderColor = KMainColor.CGColor;
    visterBtn.layer.borderWidth = 1;
    [visterBtn bk_addEventHandler:^(id sender) {
//        [[ZLaunchManager sharedInstance] showMainTab];
    } forControlEvents:UIControlEventTouchUpInside];
    [visterBtn setTitle:@"游客模式" forState:UIControlStateNormal];
    [visterBtn setTitleColor:KMainColor forState:UIControlStateNormal];
    [visterBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    [self addSubview:visterBtn];
    [visterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(180));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-80));
    }];
    
   contView.alpha = 0;
   self.loginBtn.alpha = 0;
   
   contView.transform = CGAffineTransformMakeTranslation(KScreenWidth - CGFloatIn750(50)*2, 0);
    
    
   self.loginBtn.transform = CGAffineTransformMakeTranslation(KScreenWidth - CGFloatIn750(60)*2, 0);
    
    
   [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       contView.alpha = 1;
       contView.transform = CGAffineTransformMakeTranslation(0, 0);
       [self layoutIfNeeded];
   } completion:^(BOOL finished) {
       
   }];
    
   [UIView animateWithDuration:.5 delay:0.2 usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.loginBtn.alpha = 1;
       self.loginBtn.transform = CGAffineTransformMakeTranslation(0, 0);
       [self layoutIfNeeded];
   } completion:^(BOOL finished) {
       
   }];
    // 是否可以登录
   RAC(self.loginBtn, enabled) = RACObserve(weakSelf.loginViewModel, isLoginEnable);
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
            weakSelf.loginViewModel.loginModel.tel = x;
        }];
        _userNameTF.delegate = self;
        _userNameTF.keyboardType = UIKeyboardTypePhonePad;
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
        _passwordTF.tag = 103;
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
            weakSelf.loginViewModel.loginModel.pwd = x;
        }];
    }
    return _passwordTF;
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
                weakSelf.editBlock(2, x);
            }
            weakSelf.loginViewModel.loginModel.code = x;
        }];
        _codeTF.delegate = self;
        _codeTF.keyboardType = UIKeyboardTypeDefault;
    }
    return _codeTF;
}


- (UIButton *)loginBtn {
    if (!_loginBtn) {
        __weak typeof(self) weakSelf = self;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn bk_addEventHandler:^(id sender) {
            [weakSelf inputResignFirstResponder];
            NSComparisonResult result1 = [weakSelf.pooCodeView.changeString compare:weakSelf.codeTF.text options:NSCaseInsensitiveSearch];
            
            if ((weakSelf.pooCodeView.changeString.length == weakSelf.codeTF.text.length ) && (result1 == 0)) {
                NSLog(@"匹配正确");
            }
            else{
                NSLog(@"验证码错误");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.pooCodeView changeCode];
                });
                return ;
            }
            if (!self.isAgree) {
                [TLUIUtility showErrorHint:@"请阅读并同意遵守《莫等闲服务条款》和《隐私协议》"];
                return ;
            }
            
            
//            [self.loginViewModel loginWithUsername:self.loginViewModel.loginModel.tel password:self.loginViewModel.loginModel.code block:^(BOOL isSuccess, NSString *message) {
//                if (isSuccess) {
//                    [TLUIUtility showSuccessHint:message];
//                }else{
//                    [TLUIUtility showErrorHint:message];
//                }
//
//                DLog(@"login message %@",message);
//                //                ZPerfectUserInfoViewController *prefectVC = [[ZPerfectUserInfoViewController alloc] init];
//                //                PushVC(prefectVC);
//            }];
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


- (void)inputResignFirstResponder {
    [self.userNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
}
@end
