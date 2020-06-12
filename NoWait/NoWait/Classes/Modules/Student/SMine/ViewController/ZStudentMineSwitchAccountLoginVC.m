//
//  ZStudentMineSwitchAccountLoginVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSwitchAccountLoginVC.h"
#import "ZMineAccountTextFieldCell.h"
#import "ZLoginViewModel.h"
#import "ZLoginPasswordController.h"

@interface ZStudentMineSwitchAccountLoginVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) ZLoginViewModel *loginViewModel;
@property (nonatomic,strong) ZMineAccountTextFieldCell *bCell;
@property (nonatomic,strong) ZMineAccountTextFieldCell *sCell;
@end

@implementation ZStudentMineSwitchAccountLoginVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_isCode && _bCell.inputTextField.text.length == 0) {
        [_bCell.inputTextField becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self setMainView];
}

#pragma mark - set data
- (void)setDataSource {
   
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;
    
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    [self.navigationItem setTitle:@"切换账号"];
}


- (void)setMainView {
    [self.view addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(324));
        make.height.width.mas_equalTo(CGFloatIn750(120));
    }];
    
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.userImageView.mas_bottom).offset(CGFloatIn750(24));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.view addSubview:bottomLineView];
    
    if (self.isCode) {
        UIView *tempView = [self codeView];
        [self.view addSubview:tempView];
        [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(52));
            make.height.mas_equalTo([ZMineAccountTextFieldCell z_getCellHeight:nil] * 2 + CGFloatIn750(50));
        }];
        
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.top.equalTo(tempView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        bottomLineView.hidden = YES;
    }else{
        [self.view addSubview:self.userNameTF];
        [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.height.mas_equalTo(CGFloatIn750(86));
            make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(52));
        }];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.top.equalTo(self.userNameTF.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        bottomLineView.hidden = NO;
    }
    
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(78));
        make.top.equalTo(bottomLineView.mas_bottom).offset(CGFloatIn750(120));
    }];
    
    if (!_isCode) {
        UILabel *otherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        otherLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        otherLabel.text = @"其他登录方式";
        otherLabel.textAlignment = NSTextAlignmentCenter;
        [otherLabel setFont:[UIFont fontMin]];
        [self.view addSubview:otherLabel];
        [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.loginBtn.mas_bottom).offset(CGFloatIn750(120));
        }];
        
        
//        UIView *leftView = [self getMenuBtnWithImageName:@"loginwechat" title:@"微信登录" tag:0];
        UIView *midView = [self getMenuBtnWithImageName:@"loginpassword" title:@"验证码登录" tag:1];
//        [self.view addSubview:leftView];
        [self.view addSubview:midView];
        
//        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
//            make.centerX.equalTo(self.view.mas_right).multipliedBy(1.0/4);
//            make.width.height.mas_equalTo(CGFloatIn750(120));
//        }];
        
        [midView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
            make.centerX.equalTo(self.view.mas_right).multipliedBy(2.0/4);
            make.width.height.mas_equalTo(CGFloatIn750(120));
        }];
    }
}

#pragma mark - lazy loading...
-(ZLoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[ZLoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        __weak typeof(self) weakSelf  = self;
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [backBtn bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(98));
            make.top.bottom.left.equalTo(self.navView);
        }];
        
        [backBtn addSubview:self.backImageView];
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(backBtn);
        }];
    }
    
    return _navView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [[UIImage imageNamed:@"navleftBack"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    }
    return _backImageView;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(self.model.image)] placeholderImage:[UIImage imageNamed:@"default_head"]];
        ViewRadius(_userImageView, CGFloatIn750(60));
    }
    return _userImageView;
}


- (UIButton *)loginBtn {
    if (!_loginBtn) {
        __weak typeof(self) weakSelf = self;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.isCode) {
                [weakSelf codeLogin];
            }else{
                [weakSelf passWordLogin];
            }
       } forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = CGFloatIn750(38);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont fontContent]];
    }
    return _loginBtn;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        NSString *typestr = @"";
        //    1：学员 2：教师 6：校区 8：机构
        if ([self.model.type intValue] == 1) {
            typestr = @"学员端";
        }else if ([self.model.type intValue] == 2) {
            typestr = @"教师端";
        }else if ([self.model.type intValue] == 6) {
            typestr = @"校区端";
        }else if ([self.model.type intValue] == 8) {
            typestr = @"机构端";
        }
        NSString *temp = (ValidStr(self.model.nick_name) ? self.model.nick_name:self.model.phone);
        _nameLabel.text = [NSString stringWithFormat:@"%@(%@)",temp,typestr];
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _nameLabel;
}


- (UITextField *)userNameTF {
    if (!_userNameTF ) {
        __weak typeof(self) weakSelf = self;
        _userNameTF  = [[UITextField alloc] init];
        _userNameTF.tag = 101;
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        [_userNameTF setTextAlignment:NSTextAlignmentCenter];
        [_userNameTF setFont:[UIFont fontContent]];
        [_userNameTF setBorderStyle:UITextBorderStyleNone];
        [_userNameTF setBackgroundColor:[UIColor clearColor]];
        [_userNameTF setReturnKeyType:UIReturnKeyDone];
        [_userNameTF setPlaceholder:@"请输入密码"];
        [_userNameTF setSecureTextEntry:YES];
        [_userNameTF.rac_textSignal subscribeNext:^(NSString *x) {
            if (x.length > 20) {
                x = [x substringWithRange:NSMakeRange(0, 20)];
                weakSelf.userNameTF.text = x;
            }
//            if (weakSelf.editBlock) {
//                weakSelf.editBlock(0, x);
//            }
//            weakSelf.loginViewModel.loginModel.tel = x;
        }];
        _userNameTF.delegate = self;
        _userNameTF.keyboardType = UIKeyboardTypeDefault;
        _userNameTF.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }
    return _userNameTF;
}

- (ZMineAccountTextFieldCell *)bCell {
    if (!_bCell) {
        __weak typeof(self) weakSelf = self;
        _bCell = [[ZMineAccountTextFieldCell alloc] init];
        _bCell.type = 2;
        _bCell.max = 4;
        _bCell.placeholder = @"图形验证码";
        _bCell.formatterType = ZFormatterTypeAny;
        _bCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.loginViewModel.loginModel.code = text;
        };
        _bCell.imageCodeBlock = ^(NSString * ckey) {
            weakSelf.loginViewModel.loginModel.ckey = ckey;
        };
        [_bCell getImageCode];
        
    }
    return _bCell;
}

- (ZMineAccountTextFieldCell *)sCell {
    if (!_sCell) {
        __weak typeof(self) weakSelf = self;
        _sCell = [[ZMineAccountTextFieldCell alloc] init];
        _sCell.type = 1;
        _sCell.max = 6;
        _sCell.placeholder = @"短信验证码";
        _sCell.formatterType = ZFormatterTypeNumber;
        _sCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.loginViewModel.loginModel.messageCode = text;
        };
        _sCell.getCodeBlock = ^(void (^success)(NSString *)) {
            if (!weakSelf.model.phone || weakSelf.model.phone.length != 11) {
               [TLUIUtility showErrorHint:@"请输入正确的手机号" ];
               //        [[HNPublicTool shareInstance] showHudMessage:@"请输入正确的手机号"];
               return;
           }
           
           if (!weakSelf.loginViewModel.loginModel.code || weakSelf.loginViewModel.loginModel.code.length != 4) {
               [TLUIUtility showErrorHint:@"请输入图形验证码" ];
               //        [[HNPublicTool shareInstance] showHudMessage:@"请输入正确的手机号"];
               return;
           }
           
           NSMutableDictionary *params = @{@"ckey":SafeStr(weakSelf.loginViewModel.loginModel.ckey) ,@"captcha":SafeStr(weakSelf.loginViewModel.loginModel.code),@"phone":SafeStr(weakSelf.model.phone)}.mutableCopy;
           [ZLoginViewModel codeWithParams:params block:^(BOOL isSuccess, id message) {
              if (isSuccess) {
                  [TLUIUtility showSuccessHint:message];
                  if (success) {
                      success(message);
                  }
              }else{
                  [TLUIUtility showErrorHint:message];
              }
           }];
        };
    }
    return _sCell;
}
- (UIView *)codeView {
    UIView *tempView = [[UIView alloc] init];
    
    [tempView addSubview:self.bCell.contentView];
    [self.bCell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tempView);
        make.top.equalTo(tempView.mas_top);
        make.height.mas_equalTo(CGFloatIn750(100));
    }];
    
    [tempView addSubview:self.sCell.contentView];
    [self.sCell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tempView);
        make.top.equalTo(self.bCell.contentView.mas_bottom).offset(CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(100));
    }];
        
    return tempView;
}

#pragma mark - fun
- (UIView *)getMenuBtnWithImageName:(NSString *)image  title:(NSString *)title tag:(NSInteger)tag {
    UIView *tempView = [[UIView alloc] init];
    
    UIView *imageBackView = [[UIView alloc] init];
    imageBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    ViewRadius(imageBackView, CGFloatIn750(35));
    [tempView addSubview:imageBackView];
    [imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tempView.mas_top);
        make.centerX.equalTo(tempView.mas_centerX);
        make.width.height.mas_equalTo(CGFloatIn750(70));
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:image];
    imageView.layer.masksToBounds = YES;
    [tempView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imageBackView);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontSmall]];
    [tempView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageBackView.mas_bottom).offset(CGFloatIn750(16));
        make.centerX.equalTo(tempView.mas_centerX);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    menuBtn.tag = tag;
    [menuBtn bk_addEventHandler:^(id sender) {
        if (tag == 0) {
            
        }else if (tag == 1){
            ZStudentMineSwitchAccountLoginVC *lvc = [[ZStudentMineSwitchAccountLoginVC alloc] init];
            lvc.model = self.model;
            lvc.isCode = YES;
            [weakSelf.navigationController pushViewController:lvc animated:YES];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [tempView addSubview:menuBtn];
    [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tempView);
    }];
    
    return tempView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorBlackBGDark]);
}


- (void)passWordLogin {
    __weak typeof(self) weakSelf = self;
    
    [self.userNameTF resignFirstResponder];

       NSMutableDictionary *params = @{}.mutableCopy;
       if (self.model && self.model.phone.length == 11) {
           [params setObject:self.model.phone forKey:@"phone"];
       }else{
           return;
       }
       
       if (self.userNameTF.text && self.userNameTF.text.length >= 8) {
           [params setObject:self.userNameTF.text forKey:@"password"];
       }else{
           [TLUIUtility showErrorHint:@"请输入正确的密码"];
           return;
       }
    [params setObject:self.model.type forKey:@"type"];
       [TLUIUtility showLoading:@""];
       [self.loginViewModel loginPwdWithParams:params block:^(BOOL isSuccess, id message) {
           [TLUIUtility hiddenLoading];
           if (isSuccess) {
                [weakSelf loginSuccess];
               [TLUIUtility showSuccessHint:message];
           }else{
               [TLUIUtility showErrorHint:message];
           }
       }];
}

- (void)codeLogin {
    NSMutableDictionary *params = @{}.mutableCopy;
    if (self.model.phone && self.model.phone.length == 11) {
        [params setObject:self.model.phone forKey:@"phone"];
    }else{
        return;
    }
    
    
    if (self.loginViewModel.loginModel.messageCode && self.loginViewModel.loginModel.messageCode.length == 6) {
        [params setObject:self.loginViewModel.loginModel.messageCode forKey:@"code"];
    }else{
        return;
    }
    [params setObject:self.model.type forKey:@"type"];
    __weak typeof(self) weakSelf = self;
    [self.loginViewModel loginWithParams:params block:^(BOOL isSuccess, id message) {
        if (isSuccess) {
             [[NSUserDefaults standardUserDefaults] setObject:@"hadLogin" forKey:@"hadLogin"];
            if (isSuccess) {
                //进入主页
                [weakSelf loginSuccess];
            }
            [TLUIUtility showSuccessHint:message];
        }else{
            [TLUIUtility showErrorHint:message];
        }
    }];
}

- (void)loginSuccess {
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSArray *reversedArray = [[viewControllers reverseObjectEnumerator] allObjects];
    
    ZViewController *target;
    for (ZViewController *controller in reversedArray) {
        if ([controller isKindOfClass:[NSClassFromString(@"ZMineMainVC") class]]) {
            target = controller;
            break;
        }
    }
    
    if (target) {
        [self.navigationController popToViewController:target animated:YES];
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end







