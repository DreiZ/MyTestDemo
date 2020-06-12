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
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"修改密码")
    .zChain_resetMainView(^{
        weakSelf.iTableView.scrollEnabled = NO;
    }).zChain_updateDataSource(^{
        weakSelf.loginViewModel = [[ZLoginViewModel alloc] init];
    }).zChain_resetMainView(^{
        [weakSelf.view addSubview:weakSelf.navView];
        [weakSelf.navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view.mas_top).offset(kStatusBarHeight);
            make.height.mas_equalTo(CGFloatIn750(88));
        }];
        
        weakSelf.iTableView.tableFooterView = weakSelf.footerView;
        [weakSelf.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view.mas_bottom);
            make.top.equalTo(weakSelf.navView.mas_bottom).offset(0);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];

        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"title")
        .zz_titleLeft(@"绑定新手机号码")
        .zz_fontLeft([UIFont boldSystemFontOfSize:CGFloatIn750(52)])
        .zz_marginLeft(CGFloatIn750(50))
        .zz_lineHidden(YES)
        .zz_cellHeight(CGFloatIn750(126));
        
         ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

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
    });
    
    self.zChain_reload_ui();
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
    self.zChain_reload_ui();
}
@end
