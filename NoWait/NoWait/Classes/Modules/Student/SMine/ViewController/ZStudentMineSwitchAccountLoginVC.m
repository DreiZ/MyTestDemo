//
//  ZStudentMineSwitchAccountLoginVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSwitchAccountLoginVC.h"
#import "ZMineAccountTextFieldCell.h"

@interface ZStudentMineSwitchAccountLoginVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UITextField *userNameTF;

@end

@implementation ZStudentMineSwitchAccountLoginVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
        
        
        UIView *leftView = [self getMenuBtnWithImageName:@"mineOrderCard" title:@"微信登录" tag:0];
        UIView *midView = [self getMenuBtnWithImageName:@"mineOrderCard" title:@"验证码登录" tag:1];
        [self.view addSubview:leftView];
        [self.view addSubview:midView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
            make.centerX.equalTo(self.view.mas_right).multipliedBy(1.0/4);
            make.width.height.mas_equalTo(CGFloatIn750(120));
        }];
        
        [midView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
            make.centerX.equalTo(self.view.mas_right).multipliedBy(3.0/4);
            make.width.height.mas_equalTo(CGFloatIn750(120));
        }];
    }
}

#pragma mark - lazy loading...
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        __weak typeof(self) weakSelf  = self;
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [backBtn bk_whenTapped:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
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
        _backImageView.image = [UIImage imageNamed:@"navleftBack"];
        _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorBlackBGDark]);
    }
    return _backImageView;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.image = [UIImage imageNamed:@"headImage"];
        ViewRadius(_userImageView, CGFloatIn750(60));
    }
    return _userImageView;
}


- (UIButton *)loginBtn {
    if (!_loginBtn) {
//        __weak typeof(self) weakSelf = self;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn bk_addEventHandler:^(id sender) {
           
        } forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = CGFloatIn750(38);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont fontContent]];
    }
    return _loginBtn;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.text = @"机构端";
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
            if (x.length > 11) {
                x = [x substringWithRange:NSMakeRange(0, 11)];
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
- (UIView *)codeView {
    UIView *tempView = [[UIView alloc] init];
//    __weak typeof(self) weakSelf = self;
        
    
    ZMineAccountTextFieldCell *bCell = [[ZMineAccountTextFieldCell alloc] init];
    bCell.type = 2;
    bCell.max = 4;
    bCell.placeholder = @"图形验证码";
    bCell.formatterType = ZFormatterTypeAny;
    bCell.valueChangeBlock = ^(NSString * text) {
//        weakSelf.loginViewModel.loginModel.code = text;
    };
    bCell.imageCodeBlock = ^(NSString * ckey) {
//        weakSelf.loginViewModel.loginModel.ckey = ckey;
    };
    [bCell getImageCode];
    [tempView addSubview:bCell.contentView];
    [bCell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tempView);
        make.top.equalTo(tempView.mas_top);
        make.height.mas_equalTo(CGFloatIn750(100));
    }];
    
    
    ZMineAccountTextFieldCell *sCell = [[ZMineAccountTextFieldCell alloc] init];
    sCell.type = 1;
    sCell.max = 6;
    sCell.placeholder = @"短信验证码";
    sCell.formatterType = ZFormatterTypeNumber;
    sCell.valueChangeBlock = ^(NSString * text) {
//        weakSelf.loginViewModel.loginModel.code = text;
    };
    [tempView addSubview:sCell.contentView];
    [sCell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tempView);
        make.top.equalTo(bCell.contentView.mas_bottom).offset(CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(100));
    }];
        
    return tempView;
}

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
    [menuBtn bk_whenTapped:^{
        if (tag == 0) {
            ZStudentMineSwitchAccountLoginVC *lvc = [[ZStudentMineSwitchAccountLoginVC alloc] init];
            lvc.isCode = YES;
            [weakSelf.navigationController pushViewController:lvc animated:YES];
        }else if (tag == 1){
            
        }
    }];
    [tempView addSubview:menuBtn];
    [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tempView);
    }];
    
    return tempView;
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorBlackBGDark]);
}
@end







