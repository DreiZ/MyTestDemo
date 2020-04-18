//
//  ZStudentMineChangePasswordVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineChangePasswordVC.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZMineAccountTextFieldCell.h"
#import "ZLoginViewModel.h"

@interface ZStudentMineChangePasswordVC ()
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) ZLoginViewModel *loginViewModel;
@end

@implementation ZStudentMineChangePasswordVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
}


#pragma mark - set data
- (void)initCellConfigArr {
    [super initCellConfigArr];
 
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"设置新密码";
    model.cellTitle = @"title";
    model.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(52)];
    model.leftMargin = CGFloatIn750(50);
    model.isHiddenLine = YES;
    model.cellHeight = CGFloatIn750(126);
    
    {
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(100) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
    }

    ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

    [self.cellConfigArr addObject:titleCellConfig];
    
    ZCellConfig *phoneCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"phone" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(104) cellType:ZCellTypeClass dataModel:self.loginViewModel.loginModel.tel];
    
    [self.cellConfigArr addObject:phoneCellConfig];

   ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"password" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"输入密码"];
   
   [self.cellConfigArr addObject:textCellConfig];
    
    {
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"repassword" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"再次确认密码"];
        
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
        [backBtn bk_whenTapped:^{
            NSArray *viewControllers = self.navigationController.viewControllers;
            NSArray *reversedArray = [[viewControllers reverseObjectEnumerator] allObjects];
            
            ZViewController *target;
            for (ZViewController *controller in reversedArray) {
                if ([controller isKindOfClass:[NSClassFromString(@"ZLoginPasswordController") class]]) {
                    target = controller;
                    break;
                }
            }
            
            if (target) {
                [weakSelf.navigationController popToViewController:target animated:YES];
                return;
            }
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
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
            if (weakSelf.isSwitch) {
                if (weakSelf.loginSuccess) {
                    weakSelf.loginSuccess();
                }
            }
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
    if ([cellConfig.title isEqualToString:@"phone"]) {
        ZStudentMineSettingBottomCell *bCell = (ZStudentMineSettingBottomCell *)cell;
        bCell.titleLabel.font = [UIFont boldFontMax1Title];
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

