//
//  ZAccountChangePhoneVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAccountChangePhoneVC.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZMineAccountTextFieldCell.h"
#import "ZLoginViewModel.h"

@interface ZAccountChangePhoneVC ()
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) ZLoginViewModel *loginViewModel;

@property (nonatomic,strong) ZMineAccountTextFieldCell *phoneCell;

@end

@implementation ZAccountChangePhoneVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_phoneCell && _phoneCell.inputTextField.text.length == 0) {
        [_phoneCell.inputTextField becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    self.iTableView.scrollEnabled = NO;
    [self.iTableView reloadData];;
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
    model.leftTitle = @"绑定新手机号码";
    model.cellTitle = @"title";
    model.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(52)];
    model.leftMargin = CGFloatIn750(50);
    model.isHiddenLine = YES;
    model.cellHeight = CGFloatIn750(126);

    ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

    [self.cellConfigArr addObject:titleCellConfig];
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(180))];
    

   ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"phone" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"手机号码"];
   
   [self.cellConfigArr addObject:textCellConfig];
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"imageCode" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"图形验证码"];
        
        [self.cellConfigArr addObject:textCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"code" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"短信验证码"];
        
        [self.cellConfigArr addObject:textCellConfig];
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
        
//        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
//            if (weakSelf.iTextView.text && weakSelf.iTextView.text.length > 0) {
//                if (weakSelf.iTextView.text.length < 5) {
//                    [TLUIUtility showErrorHint:@"意见太少了，不能少有5个字符"];
//                    return ;
//                }
////                [TLUIUtility showLoading:nil];
////                [ZMIneViewModel saveProposalContentWith:weakSelf.iTextView.text completeBlock:^(BOOL isSuccess, NSString *message) {
////                    [TLUIUtility hiddenLoading];
////                    if (isSuccess) {
////                        [TLUIUtility showSuccessHint:message];
////
////                        [weakSelf.navigationController popViewControllerAnimated:YES];
////                    }else{
////                        [TLUIUtility showErrorHint:message];
////                    }
////                }];
//            }else{
//                [TLUIUtility showErrorHint:@"意见不能为空"];
//            }
            
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
            weakSelf.loginViewModel.loginModel.code = text;
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


