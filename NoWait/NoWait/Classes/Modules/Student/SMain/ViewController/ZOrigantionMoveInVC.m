//
//  ZOrigantionMoveInVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrigantionMoveInVC.h"
#import "ZOriganizationModel.h"
#import "ZOrganizationRadiusCell.h"
#import "ZAlertDataModel.h"
#import "ZAlertDataSinglePickerView.h"

@interface ZOrigantionMoveInVC ()
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) ZStoresMoveInModel *model;

@end

@implementation ZOrigantionMoveInVC

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
}

- (void)setDataSource {
    [super setDataSource];
}


- (void)setOtherData {
//    __weak typeof(self) weakSelf = self;
    self.iTableView.scrollEnabled = NO;
    [self.iTableView reloadData];
}

- (void)setupMainView {
    [super setupMainView];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(242)+safeAreaTop());
    }];
    
    [self.view insertSubview:self.topImageView atIndex:0];
    
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    self.iTableView.tableFooterView = self.footerView;
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(1036));
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(234));
    }];
    
    ViewRadius(self.iTableView, CGFloatIn750(16));
}


#pragma mark - set data
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
 
    NSArray *textArr = @[@[@"机构名称", @"请输入机构名称", @YES, @"", @"name",SafeStr(self.model.storeName),@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"机构类型", @"请选择机构类型", @NO, @"rightBlackArrowN", @"type",SafeStr(self.model.storeType),@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"机构地址",@"请输入机构地址", @YES, @"", @"address",SafeStr(self.model.storeAddress),@30,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"联系人", @"请输入联系人", @YES, @"", @"contactName",SafeStr(self.model.contentName),@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"联系方式", @"请输入联系方式", @YES, @"", @"phone",SafeStr(self.model.storePhone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                         @[@"备注", @"选填", @YES, @"", @"remark",SafeStr(self.model.remark),@11,[NSNumber numberWithInt:ZFormatterTypeAny]]];
    
    for (int i = 0; i < textArr.count; i++) {
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = textArr[i][0];
        cellModel.placeholder = textArr[i][1];
        cellModel.isTextEnabled = [textArr[i][2] boolValue];
        cellModel.rightImage = textArr[i][3];
        cellModel.cellTitle = textArr[i][4];
        cellModel.content = textArr[i][5];
        cellModel.max = [textArr[i][6] intValue];
        cellModel.formatterType = [textArr[i][7] intValue];
        cellModel.isHiddenLine = YES;
        cellModel.cellHeight = CGFloatIn750(108);
        cellModel.leftFont = [UIFont boldFontMaxTitle];
        cellModel.rightFont = [UIFont fontContent];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [self.cellConfigArr addObject:textCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;

    [self.navigationItem setTitle:@"机构线上申请入口"];
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
        _backImageView.image = [UIImage imageNamed:@"navleftBack"];
        _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorBlackBGDark]);
    }
    return _backImageView;
}


- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.clipsToBounds = YES;
        [_topImageView tt_setImageWithURL:[NSURL URLWithString:@"http://wx1.sinaimg.cn/mw600/006WU3Oqly1gdcdy7j11pj30hs0vlwfh.jpg"]];
    }
    return _topImageView;
}


-(UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(480))];
        _footerView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UIButton *doneBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        doneBtn.layer.masksToBounds = YES;
        doneBtn.layer.cornerRadius = CGFloatIn750(40);
        [doneBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [doneBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [doneBtn.titleLabel setFont:[UIFont fontContent]];
        [_footerView addSubview:doneBtn ];
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(80));
            make.left.equalTo(self.footerView.mas_left).offset(CGFloatIn750(40));
            make.right.equalTo(self.footerView.mas_right).offset(-CGFloatIn750(40));
            make.top.equalTo(self.footerView.mas_top).offset(CGFloatIn750(100));
        }];
        
        __weak typeof(self) weakSelf = self;
        [doneBtn bk_addEventHandler:^(id sender) {
            [weakSelf.iTableView endEditing:YES];
//
//            NSMutableDictionary *params = @{}.mutableCopy;
//            if (self.loginViewModel.loginModel.tel && self.loginViewModel.loginModel.tel.length == 11) {
//                [params setObject:self.loginViewModel.loginModel.tel forKey:@"phone"];
//            }else{
//                return;
//            }
//
//            if (self.loginViewModel.loginModel.pwd && self.loginViewModel.loginModel.pwd.length >= 8) {
//                [params setObject:self.loginViewModel.loginModel.pwd forKey:@"password"];
//            }else{
//                return;
//            }
//            [params setObject:[NSString stringWithFormat:@"%ld",self.type] forKey:@"type"];
//            [TLUIUtility showLoading:@""];
//            [self.loginViewModel loginPwdWithParams:params block:^(BOOL isSuccess, id message) {
//                [TLUIUtility hiddenLoading];
//                if (isSuccess) {
//                     [[NSUserDefaults standardUserDefaults] setObject:@"hadLogin" forKey:@"hadLogin"];
//                    if (weakSelf.loginSuccess) {
//                        weakSelf.loginSuccess();
//                    }else{
//                        if (isSuccess) {
//                            //进入主页
//                            [[ZLaunchManager sharedInstance] launchInWindow:nil];
//                        }
//                    }
//                    [TLUIUtility showSuccessHint:message];
//                }else{
//                    [TLUIUtility showErrorHint:message];
//                }
//            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _footerView;
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"name"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.model.storeName = text;
        };
    }else if ([cellConfig.title isEqualToString:@"type"]) {
        
    }else if ([cellConfig.title isEqualToString:@"address"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.model.storeAddress = text;
        };
    }else if ([cellConfig.title isEqualToString:@"contactName"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.model.contentName = text;
        };
    }else if ([cellConfig.title isEqualToString:@"phone"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.model.storePhone = text;
        };
    }else if ([cellConfig.title isEqualToString:@"remark"]) {
        ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
        tCell.valueChangeBlock = ^(NSString * text) {
            weakSelf.model.remark = text;
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"type"]) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *temp = @[@"体育",@"艺术",@"兴趣",@"其他"];;
        for (int i = 0; i < temp.count; i++) {
           ZAlertDataItemModel *model = [[ZAlertDataItemModel alloc] init];
           model.name = temp[i];
           [items addObject:model];
        }
        __weak typeof(self) weakSelf = self;
        [ZAlertDataSinglePickerView setAlertName:@"类别选择" items:items handlerBlock:^(NSInteger index) {
            weakSelf.model.storeType = [NSString stringWithFormat:@"%ld",index+1];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }];
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

