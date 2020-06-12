//
//  ZLoginCodeController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLoginCodeController.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZMineAccountTextFieldCell.h"

#import "ZAccountChangePasswordVC.h"
#import "ZLoginPasswordController.h"
#import "ZLaunchManager.h"
#import "ZAgreementVC.h"

#import "ZLoginViewModel.h"
#import "ZLoginModel.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import <WechatOpenSDK/WXApi.h>

@interface ZLoginCodeController ()
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) YYLabel *protocolLabel;
@property (nonatomic,strong) UIImageView *agreementView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) ZMineAccountTextFieldCell *phoneCell;

@property (nonatomic,assign) BOOL isAgree;

@property (nonatomic,strong) ZLoginViewModel *loginViewModel;
@end

@implementation ZLoginCodeController

#pragma mark - vc delegate-
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_phoneCell && _phoneCell.inputTextField.text.length == 0) {
//        [_phoneCell.inputTextField becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self initCellConfigArr];
    [self setOtherData];
}

- (void)setOtherData {
//    __weak typeof(self) weakSelf = self;
    self.iTableView.scrollEnabled = NO;
    [self.iTableView reloadData];
//    // 是否可以登录
//    RAC(self.loginBtn, enabled) = RACObserve(weakSelf.loginViewModel, isLoginEnable);

    NSString *hadLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"hadLogin"];
    if (hadLogin) {
        self.isAgree = YES;
    }else{
        self.isAgree = NO;
    }
}

- (void)setDataSource {
    [super setDataSource];
    _loginViewModel = [[ZLoginViewModel alloc] init];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    self.iTableView.tableFooterView = self.footerView;
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.navView.mas_bottom).offset(0);
    }];
}


#pragma mark - set data
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    if (KScreenHeight < 812) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }else{
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(25))];
    }
    
    
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"登录似锦";
    model.cellTitle = @"title";
    model.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(52)];
    model.leftMargin = CGFloatIn750(50);
    model.isHiddenLine = YES;
    model.cellHeight = CGFloatIn750(76);

    ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

    [self.cellConfigArr addObject:titleCellConfig];
    {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.rightColor = [UIColor colorTextGray];
        model.rightDarkColor = [UIColor colorTextGrayDark];
        if (self.type == 1) {
            model.leftTitle = @"未注册手机号码验证后即可登录";
        }else if(self.type == 2){
            model.rightColor = [UIColor colorRedForLabel];
            model.rightDarkColor = [UIColor colorRedForLabel];
            model.rightTitle = @"教师账号不可短信登录自动注册，教师账号由机构或者校区账号绑定后生成";
        }else if(self.type == 6){
            model.rightColor = [UIColor colorRedForLabel];
            model.rightDarkColor = [UIColor colorRedForLabel];
            model.rightTitle = @"校区账号不可短信登录自动注册，如您需要校区账号请联系平台，申请账号";
        }else if(self.type == 8){
            model.rightColor = [UIColor colorRedForLabel];
            model.rightDarkColor = [UIColor colorRedForLabel];
            model.rightTitle = @"机构账号不可短信登录自动注册，如您需要机构账号请联系平台，申请账号";
        }
        
        model.cellTitle = @"title";
        model.leftFont = [UIFont fontSmall];
        model.leftMargin = CGFloatIn750(50);
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth;
        model.singleCellHeight = CGFloatIn750(54);;
        model.cellHeight = CGFloatIn750(56);
        model.lineSpace = CGFloatIn750(6);

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [self.cellConfigArr addObject:menuCellConfig];
    }
    if (KScreenHeight < 812) {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(90))];
    }else{
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(130))];
    }
    
    ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"phone" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"手机号码"];

    [self.cellConfigArr addObject:textCellConfig];
    
    {
        if (KScreenHeight < 812) {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(16))];
        }else{
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        }
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"imageCode" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"图形验证码"];
        
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    {
        if (KScreenHeight < 812) {
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(16))];
        }else{
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        }
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"code" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"短信验证码"];
        
        [self.cellConfigArr addObject:textCellConfig];
    }
}

- (void)setIsAgree:(BOOL)isAgree {
    _isAgree = isAgree;
    
    if (isAgree) {
        self.agreementView.image = [UIImage imageNamed:@"selectedCycle"];
    }else{
        self.agreementView.image = [UIImage imageNamed:@"unSelectedCycle"];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;

    [self.navigationItem setTitle:@"登录似锦"];
}

#pragma mark - lazy loading...
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


-(UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(520))];
        _footerView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        doneBtn.layer.masksToBounds = YES;
        doneBtn.layer.cornerRadius = CGFloatIn750(50);
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [doneBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [doneBtn.titleLabel setFont:[UIFont fontTitle]];
        [_footerView addSubview:doneBtn ];
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (KScreenHeight < 812) {
                make.top.equalTo(self.footerView.mas_top).offset(CGFloatIn750(60));
            }else{
                make.top.equalTo(self.footerView.mas_top).offset(CGFloatIn750(100));
            }
            make.height.mas_equalTo(CGFloatIn750(100));
            make.left.equalTo(self.footerView.mas_left).offset(CGFloatIn750(60));
            make.right.equalTo(self.footerView.mas_right).offset(-CGFloatIn750(60));
        }];
        _loginBtn = doneBtn;
        
        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
            [weakSelf.iTableView endEditing:YES];
            
            
            if (!self.isAgree) {
                [TLUIUtility showErrorHint:@"请阅读并同意遵守《似锦服务条款》和《隐私协议》"];
                return ;
            }
            
            NSMutableDictionary *params = @{}.mutableCopy;
            if (self.loginViewModel.loginModel.tel && self.loginViewModel.loginModel.tel.length == 11) {
                [params setObject:self.loginViewModel.loginModel.tel forKey:@"phone"];
            }else{
                [TLUIUtility showErrorHint:@"请输入正确的手机号"];
                return;
            }
            
            
            if (self.loginViewModel.loginModel.messageCode && self.loginViewModel.loginModel.messageCode.length == 6) {
                [params setObject:self.loginViewModel.loginModel.messageCode forKey:@"code"];
            }else{
                [TLUIUtility showErrorHint:@"请输入正确的验证码"];
                return;
            }
            
            [params setObject:[NSString stringWithFormat:@"%ld",weakSelf.type] forKey:@"type"];

            [self.loginViewModel loginWithParams:params block:^(BOOL isSuccess, id message) {
                if (isSuccess) {
                     [[NSUserDefaults standardUserDefaults] setObject:@"hadLogin" forKey:@"hadLogin"];
                    if (weakSelf.loginSuccess) {
                        weakSelf.loginSuccess();
                        if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                            [[ZLaunchManager sharedInstance].tabBarController setSelectedIndex:2];
                        }
                    }else{
                        if (isSuccess) {
                            //进入主页
                            [[ZLaunchManager sharedInstance] launchInWindow:nil];
                            if ([[ZUserHelper sharedHelper].user.type intValue] != 1) {
                                [[ZLaunchManager sharedInstance].tabBarController setSelectedIndex:2];
                            }
                        }
                    }
                    [TLUIUtility showSuccessHint:message];
                }else{
                    [TLUIUtility showErrorHint:message];
                }
            }];

        } forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *otherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        otherLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        otherLabel.text = @"其他登录方式";
        otherLabel.textAlignment = NSTextAlignmentCenter;
        [otherLabel setFont:[UIFont fontMin]];
        [_footerView addSubview:otherLabel];
        [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.footerView.mas_centerX);
            make.top.equalTo(doneBtn.mas_bottom).offset(CGFloatIn750(120));
        }];
        
//
//        UIView *leftView = [self getMenuBtnWithImageName:@"loginwechat" title:@"微信登录" tag:0];
        UIView *midView = [self getMenuBtnWithImageName:@"loginpassword" title:@"密码登录" tag:1];
//        [_footerView addSubview:leftView];
        [_footerView addSubview:midView];
        
        if (_isSwitch) {
//            [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
//                make.centerX.equalTo(self.footerView.mas_right).multipliedBy(1.0/4);
//                make.width.height.mas_equalTo(CGFloatIn750(120));
//            }];
            
            [midView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
                make.centerX.equalTo(self.footerView.mas_right).multipliedBy(2.0/4);
                make.width.height.mas_equalTo(CGFloatIn750(120));
            }];
        }else{
            UIView *rightView = [self getMenuBtnWithImageName:@"visitorLogin" title:@"游客模式" tag:2];
            [_footerView addSubview:rightView];
            
//            [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
//                make.centerX.equalTo(self.footerView.mas_right).multipliedBy(1.0/6);
//                make.width.height.mas_equalTo(CGFloatIn750(120));
//            }];
            
            [midView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
                make.centerX.equalTo(self.footerView.mas_right).multipliedBy(1.0/4);
                make.width.height.mas_equalTo(CGFloatIn750(120));
            }];
            
            [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(otherLabel.mas_bottom).offset(CGFloatIn750(60));
                make.centerX.equalTo(self.footerView.mas_right).multipliedBy(3.0/4);
                make.width.height.mas_equalTo(CGFloatIn750(120));
            }];
        }
    }
    
    return _footerView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _protocolLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _protocolLabel.layer.masksToBounds = YES;
        _protocolLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _protocolLabel.numberOfLines = 0;
        _protocolLabel.textAlignment = NSTextAlignmentCenter;
        [_protocolLabel setFont:[UIFont fontContent]];
        [_bottomView addSubview:_protocolLabel];
        [_protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomView.mas_centerX);
            make.top.bottom.equalTo(self.bottomView);
        }];
        NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"已阅读并同意遵守《服务条款》和《隐私协议》"];
        text.lineSpacing = 0;
        text.font = [UIFont fontMin];
        text.color = [UIColor colorTextGray1];
        //    __weak typeof(self) weakself = self;
        
        [text setTextHighlightRange:NSMakeRange(8, 6) color:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            ZAgreementVC *avc = [[ZAgreementVC alloc] init];
            avc.navTitle = @"似锦服务条款";
            avc.type = @"service_agreement";
            avc.url = @"http://www.xiangcenter.com/User/useragreement.html";
            [self.navigationController pushViewController:avc animated:YES];
        }];
        
        [text setTextHighlightRange:NSMakeRange(15, 6) color:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            ZAgreementVC *avc = [[ZAgreementVC alloc] init];
            avc.navTitle = @"隐私协议";
            avc.type = @"privacy_policy";
            avc.url = @"http://www.xiangcenter.com/User/privacyprotocol.html";
            [self.navigationController pushViewController:avc animated:YES];
        }];
        
        
        _protocolLabel.preferredMaxLayoutWidth = kScreenWidth - CGFloatIn750(60);
        _protocolLabel.attributedText = text;  //设置富文本
        [_bottomView addSubview:self.agreementView];
        [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.protocolLabel.mas_centerY).offset(-CGFloatIn750(0));
            make.right.equalTo(self.protocolLabel.mas_left).offset(-3);
            make.width.height.mas_equalTo(CGFloatIn750(26));
        }];
        
        UIButton *agreementBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [agreementBtn bk_addEventHandler:^(id sender) {
            weakSelf.isAgree = !weakSelf.isAgree;
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:agreementBtn];
        [agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.bottomView);
            make.width.mas_equalTo(CGFloatIn750(100));
            make.centerX.equalTo(self.agreementView.mas_centerX);
        }];
    }
    return _bottomView;
}

- (UIImageView *)agreementView {
    if (!_agreementView) {
        _agreementView = [[UIImageView alloc] init];
        _agreementView.layer.masksToBounds = YES;
        _agreementView.image = [UIImage imageNamed:@"unSelectedCycle"];
    }
    return _agreementView;
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
    [menuBtn bk_addEventHandler:^(id sender) {
        if (tag == 0) {
           if ([WXApi isWXAppInstalled]) {
              SendAuthReq *req = [[SendAuthReq alloc] init];
             //这里是按照官方文档的说明来的此处我要获取的是个人信息内容
              req.scope = @"snsapi_userinfo";
              req.state = @"";
            //向微信终端发起SendAuthReq消息
               [WXApi sendReq:req completion:^(BOOL success) {
                   
               }];
            } else {;
            }
        }else if (tag == 1) {
            ZLoginPasswordController *lvc = [[ZLoginPasswordController alloc] init];
            lvc.loginSuccess = weakSelf.loginSuccess;
            lvc.isSwitch = lvc.isSwitch;
            lvc.type = weakSelf.type;
            [self.navigationController pushViewController:lvc animated:YES];
        }else if (tag == 2){
            if (weakSelf.isSwitch) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } else {
                [[ZLaunchManager sharedInstance] showMainTab];
            }
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [tempView addSubview:menuBtn];
    [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tempView);
    }];
    
    return tempView;
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"phone"] ) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.type = 0;
        bCell.max = 11;
        bCell.formatterType = ZFormatterTypePhoneNumber;
        bCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.loginViewModel.loginModel.tel = text;
        };
        _phoneCell = bCell;
    }else if ([cellConfig.title isEqualToString:@"imageCode"]) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.type = 2;
        bCell.max = 4;
        bCell.formatterType = ZFormatterTypeAny;
        bCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.loginViewModel.loginModel.code = text;
        };
        bCell.imageCodeBlock = ^(NSString * ckey) {
            weakSelf.loginViewModel.loginModel.ckey = ckey;
        };
        [bCell getImageCode];
    }else if ([cellConfig.title isEqualToString:@"code"]) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.type = 1;
        bCell.max = 6;
        bCell.formatterType = ZFormatterTypeNumber;
        bCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.loginViewModel.loginModel.messageCode = text;
        };
        bCell.getCodeBlock = ^(void (^success)(NSString *)) {
            if (!weakSelf.loginViewModel.loginModel.tel || weakSelf.loginViewModel.loginModel.tel.length != 11) {
               [TLUIUtility showErrorHint:@"请输入正确的手机号" ];
               //        [[HNPublicTool shareInstance] showHudMessage:@"请输入正确的手机号"];
               return;
           }
           
           if (!weakSelf.loginViewModel.loginModel.code || weakSelf.loginViewModel.loginModel.code.length != 4) {
               [TLUIUtility showErrorHint:@"请输入图形验证码" ];
               //        [[HNPublicTool shareInstance] showHudMessage:@"请输入正确的手机号"];
               return;
           }
           
           NSMutableDictionary *params = @{@"ckey":SafeStr(weakSelf.loginViewModel.loginModel.ckey) ,@"captcha":SafeStr(weakSelf.loginViewModel.loginModel.code),@"phone":SafeStr(weakSelf.loginViewModel.loginModel.tel)}.mutableCopy;
            [params setObject:[NSString stringWithFormat:@"%ld",self.type] forKey:@"type"];
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
}


#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorBlackBGDark]);
    // darkmodel change
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end
