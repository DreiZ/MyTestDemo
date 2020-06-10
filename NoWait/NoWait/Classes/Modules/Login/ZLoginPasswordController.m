//
//  ZLoginPasswordController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLoginPasswordController.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZMineAccountTextFieldCell.h"

#import "ZAccountFogetPasswordVC.h"
#import "ZLoginViewModel.h"

@interface ZLoginPasswordController ()
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) ZMineAccountTextFieldCell *phoneTextCell;

@property (nonatomic,strong) ZLoginViewModel *loginViewModel;
@end

@implementation ZLoginPasswordController

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_phoneTextCell) {
        [_phoneTextCell.inputTextField becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)setDataSource {
    [super setDataSource];
    _loginViewModel = [[ZLoginViewModel alloc] init];
}


- (void)setOtherData {
//    __weak typeof(self) weakSelf = self;
    self.iTableView.scrollEnabled = NO;
    [self.iTableView reloadData];
    // 是否可以登录
//    RAC(self.loginBtn, enabled) = RACObserve(weakSelf.loginViewModel, isLoginPwdEnable);
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    self.iTableView.tableFooterView = self.footerView;
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.navView.mas_bottom).offset(0);
    }];
}


#pragma mark - set data
- (void)initCellConfigArr {
    [super initCellConfigArr];
 
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"欢迎回到似锦";
    model.cellTitle = @"title";
    model.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(52)];
    model.leftMargin = CGFloatIn750(50);
    model.isHiddenLine = YES;
    model.cellHeight = CGFloatIn750(126);

    ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

    [self.cellConfigArr addObject:titleCellConfig];
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(180))];

   ZCellConfig *phoneCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"phone" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"手机号码"];
   [self.cellConfigArr addObject:phoneCellConfig];
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    
    ZCellConfig *codeCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"password" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"密码"];
    [self.cellConfigArr addObject:codeCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;

    [self.navigationItem setTitle:@"密码登录"];
}

#pragma mark - lazy loading...
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        __weak typeof(self) weakSelf  = self;
        
        UIButton *backBtn = [[ZButton alloc] initWithFrame:CGRectZero];
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
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(480))];
        _footerView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UIButton *doneBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        doneBtn.layer.masksToBounds = YES;
        doneBtn.layer.cornerRadius = CGFloatIn750(50);
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [doneBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [doneBtn.titleLabel setFont:[UIFont fontTitle]];
        [_footerView addSubview:doneBtn ];
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(100));
            make.left.equalTo(self.footerView.mas_left).offset(CGFloatIn750(60));
            make.right.equalTo(self.footerView.mas_right).offset(-CGFloatIn750(60));
            make.top.equalTo(self.footerView.mas_top).offset(CGFloatIn750(100));
        }];
        
        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
            [weakSelf.iTableView endEditing:YES];
 
            NSMutableDictionary *params = @{}.mutableCopy;
            if (self.loginViewModel.loginModel.tel && self.loginViewModel.loginModel.tel.length == 11) {
                [params setObject:self.loginViewModel.loginModel.tel forKey:@"phone"];
            }else{
                [TLUIUtility showErrorHint:@"请填写正确的手机号"];
                return;
            }
            
            if (self.loginViewModel.loginModel.pwd && self.loginViewModel.loginModel.pwd.length >= 8) {
                [params setObject:self.loginViewModel.loginModel.pwd forKey:@"password"];
            }else{
                [TLUIUtility showErrorHint:@"请填写正确的密码，密码长度不小于8位"];
                return;
            }
            [params setObject:[NSString stringWithFormat:@"%ld",self.type] forKey:@"type"];
            [TLUIUtility showLoading:@""];
            [self.loginViewModel loginPwdWithParams:params block:^(BOOL isSuccess, id message) {
                [TLUIUtility hiddenLoading];
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
        
        UIButton *forgetBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [forgetBtn.titleLabel setFont:[UIFont fontContent]];
        [_footerView addSubview:forgetBtn ];
        [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(60));
            make.width.mas_equalTo(CGFloatIn750(120));
            make.top.equalTo(doneBtn.mas_bottom).offset(CGFloatIn750(30));
            make.centerX.equalTo(self.footerView.mas_centerX);
        }];
        
        [forgetBtn bk_addEventHandler:^(id sender) {
            ZAccountFogetPasswordVC *pvc = [[ZAccountFogetPasswordVC alloc] init];
            [weakSelf.navigationController pushViewController:pvc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _footerView;
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
        self.phoneTextCell = bCell;
    }else if ([cellConfig.title isEqualToString:@"password"]) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.type = 3;
        bCell.max = 20;
        bCell.formatterType = ZFormatterTypeAny;
        bCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.loginViewModel.loginModel.pwd = text;
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
