//
//  ZAccountChangePasswordVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAccountChangePasswordVC.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZMineAccountTextFieldCell.h"

#import "ZLoginViewModel.h"

@interface ZAccountChangePasswordVC ()
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) ZLoginViewModel *loginViewModel;

@property (nonatomic,strong) ZMineAccountTextFieldCell *codeCell;

@end

@implementation ZAccountChangePasswordVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_codeCell && _codeCell.inputTextField.text.length == 0) {
        [_codeCell.inputTextField becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    self.iTableView.scrollEnabled = NO;
    [self.iTableView reloadData];;
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


- (void)setDataSource {
    [super setDataSource];
    _loginViewModel = [[ZLoginViewModel alloc] init];
    _loginViewModel.loginModel.tel = [ZUserHelper sharedHelper].user.phone;
}


#pragma mark - set data
- (void)initCellConfigArr {
    [super initCellConfigArr];
 
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"修改密码";
    model.cellTitle = @"title";
    model.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(52)];
    model.leftMargin = CGFloatIn750(50);
    model.isHiddenLine = YES;
    model.cellHeight = CGFloatIn750(126);


    ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

    [self.cellConfigArr addObject:titleCellConfig];
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(100))];
    
    
    ZCellConfig *phoneCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"phone" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(104) cellType:ZCellTypeClass dataModel:self.loginViewModel.loginModel.tel];
    
    [self.cellConfigArr addObject:phoneCellConfig];
    
    {
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"imageCode" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"图形验证码"];
        
        [self.cellConfigArr addObject:textCellConfig];
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    }
    
   ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"code" showInfoMethod:nil heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
   
   [self.cellConfigArr addObject:textCellConfig];
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"password" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"输入密码"];
        
        [self.cellConfigArr addObject:textCellConfig];
    }
    
     
     {
         [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
         
         ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"repassword" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"再次确认密码"];
         
         [self.cellConfigArr addObject:textCellConfig];
     }
    {

        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"密码只能包含字母数字和下划线，且长度在8-16位之间";
        model.cellTitle = @"hint";
        model.leftFont = [UIFont fontMin];
        model.leftColor = [UIColor colorTextGray1];
        model.leftDarkColor = [UIColor colorTextGray1Dark];
        model.leftMargin = CGFloatIn750(60);
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(60);


        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [self.cellConfigArr addObject:titleCellConfig];
        
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = YES;

    [self.navigationItem setTitle:@"修改密码"];
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
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
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
            make.height.mas_equalTo(CGFloatIn750(100));
            make.left.equalTo(self.footerView.mas_left).offset(CGFloatIn750(60));
            make.right.equalTo(self.footerView.mas_right).offset(-CGFloatIn750(60));
            make.top.equalTo(self.footerView.mas_top).offset(CGFloatIn750(100));
        }];
        
        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
            NSMutableDictionary *params = @{}.mutableCopy;
            
            if (!weakSelf.loginViewModel.loginModel.messageCode || weakSelf.loginViewModel.loginModel.messageCode.length != 6) {
                [TLUIUtility showErrorHint:@"请输入验证码"];
                return ;
            }
            
            if (self.loginViewModel.loginModel.pwd && self.loginViewModel.loginModel.pwd.length >= 8) {
                if ([self checkPassword:self.loginViewModel.loginModel.pwd]) {
                    [params setObject:self.loginViewModel.loginModel.pwd forKey:@"password"];
                }else{
                    [TLUIUtility showErrorHint:@"密码必须大于等于8位，且由字母开头，包含大小写字母及数字"];
                    return;
                }
                
            }else{
                [TLUIUtility showErrorHint:@"密码必须大于等于8位，且由字母开头，包含大小写字母及数字"];
                return;
            }
            
            if (![weakSelf.loginViewModel.loginModel.pwd isEqualToString: weakSelf.loginViewModel.loginModel.rePwd]) {
                [TLUIUtility showErrorHint:@"两次密码不一致"];
                return ;
            }
            
            [params setObject:self.loginViewModel.loginModel.tel forKey:@"phone"];
            [params setObject:self.loginViewModel.loginModel.pwd forKey:@"password"];
            [params setObject:self.loginViewModel.loginModel.messageCode forKey:@"code"];
            [params setObject:[ZUserHelper sharedHelper].user.type forKey:@"login_type"];
            [params setObject:@YES forKey:@"is_login"];
            [TLUIUtility showLoading:nil];
            [weakSelf.loginViewModel updatePwdWithParams:params block:^(BOOL isSuccess, NSString *message) {
                if (isSuccess) {
                    [TLUIUtility showSuccessHint:message];
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [TLUIUtility showErrorHint:message];
                }
            }];
            
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _footerView;
}

- (BOOL)checkPassword:(NSString *)password {
    NSString *newPattern = @"^[a-zA-Z0-9_]{7,17}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",newPattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}


#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"phone"]) {
        ZStudentMineSettingBottomCell *bCell = (ZStudentMineSettingBottomCell *)cell;
        bCell.titleLabel.font = [UIFont boldFontMax1Title];
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
        _codeCell = bCell;
        [bCell getImageCode];
    }else if ([cellConfig.title isEqualToString:@"code"]) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.placeholder = @"请输入验证码";
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
           
           NSMutableDictionary *params = @{@"ckey":weakSelf.loginViewModel.loginModel.ckey,@"captcha":weakSelf.loginViewModel.loginModel.code,@"phone":weakSelf.loginViewModel.loginModel.tel}.mutableCopy;
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
    }else if ([cellConfig.title isEqualToString:@"password"] ) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.type = 3;
        bCell.max = 20;
        bCell.formatterType = ZFormatterTypeAny;
        bCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.loginViewModel.loginModel.pwd = text;
        };
    }else if ([cellConfig.title isEqualToString:@"repassword"]) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.type = 3;
        bCell.max = 20;
        bCell.formatterType = ZFormatterTypeAny;
        bCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.loginViewModel.loginModel.rePwd = text;
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

#pragma mark - RouteHandler
@interface ZAccountChangePasswordVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZAccountChangePasswordVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_changePassword;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZAccountChangePasswordVC *routevc = [[ZAccountChangePasswordVC alloc] init];
    if (request.prts) {
        routevc.isSwitch = [request.prts boolValue];
    }
    
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
