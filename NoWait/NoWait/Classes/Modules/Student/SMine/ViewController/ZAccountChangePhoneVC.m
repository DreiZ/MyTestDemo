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
#import "ZLoginCodeController.h"

@interface ZAccountChangePhoneVC ()
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *footerView;

@end

@implementation ZAccountChangePhoneVC

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
    
    {
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(180) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
    }

   ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineAccountTextFieldCell className] title:@"phone" showInfoMethod:@selector(setPlaceholder: ) heightOfCell:[ZMineAccountTextFieldCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"手机号码"];
   
   [self.cellConfigArr addObject:textCellConfig];
    
    {
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
        
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


-(UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
        _footerView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        doneBtn.layer.masksToBounds = YES;
        doneBtn.layer.cornerRadius = CGFloatIn750(50);
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [doneBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
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
            ZLoginCodeController *ovc = [[ZLoginCodeController alloc] init];
            [self.navigationController pushViewController:ovc animated:YES];
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
    
    if ([cellConfig.title isEqualToString:@"phone"] ) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.type = 0;
        bCell.valueChangeBlock = ^(NSString * text) {
            
        };
    }else if ([cellConfig.title isEqualToString:@"code"]) {
        ZMineAccountTextFieldCell *bCell = (ZMineAccountTextFieldCell *)cell;
        bCell.type = 1;
        bCell.valueChangeBlock = ^(NSString * text) {
            
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


