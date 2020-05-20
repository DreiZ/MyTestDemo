//
//  ZStudentLessonSureOrderVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSureOrderVC.h"

#import "ZStudentMineOrderDetailHandleBottomView.h"

#import "ZStudentMineOrderTopStateCell.h"
#import "ZStudentMineOrderDetailCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZTableViewListCell.h"
#import "ZStudentMineSettingBottomCell.h"

#import "ZStudentOrderPayVC.h"
#import "ZBaseUnitModel.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZStudentMineEvaEditVC.h"
#import "ZOrganizationCouponListView.h"
#import "ZPayManager.h"
#import "ZOrganizationMineOrderDetailVC.h"
#import "ZOrderModel.h"
#import "ZCouponListView.h"
#import "ZOriganizationCardViewModel.h"

@interface ZStudentLessonSureOrderVC ()
@property (nonatomic,strong) UIView *handleView;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) ZOriganizationCardListModel *cartModel;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,assign) BOOL isAlipay;
@property (nonatomic,assign) BOOL hadCard;
@end

@implementation ZStudentLessonSureOrderVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailModel.isStudent = YES;
    self.detailModel.status = @"1";
    self.detailModel.type = @"1";
    [self initCellConfigArr];
    [self.iTableView reloadData];
    [self getUseCard];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
  
    [self setOrderDetailCell];
    [self setCouponsCell];
    [self setOrderPriceCell];
    [self setPayTypeCell];
    [self setUserCell];
    [self setTipsCell];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"确认订单"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.view addSubview:self.handleView];
    [self.handleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(100)+safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.handleView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

- (void)setDataSource {
    [super setDataSource];
    __weak typeof(self) weakSelf = self;
    [[kNotificationCenter rac_addObserverForName:KNotificationPayBack object:nil] subscribeNext:^(NSNotification *notfication) {
        if (notfication.object && [notfication.object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *backDict = notfication.object;
            if (backDict && [backDict objectForKey:@"payState"]) {
                if ([backDict[@"payState"] integerValue] == 0) {
                    
                }else if ([backDict[@"payState"] integerValue] == 1) {
                    if (backDict && [backDict objectForKey:@"msg"]) {
                        [TLUIUtility showAlertWithTitle:@"支付结果" message:backDict[@"msg"]];
                    }
                }else if ([backDict[@"payState"] integerValue] == 2) {

                }else if ([backDict[@"payState"] integerValue] == 3) {
                    if (backDict && [backDict objectForKey:@"msg"]) {
                        [TLUIUtility showAlertWithTitle:@"支付结果" message:backDict[@"msg"]];
                    }
                }
                
                ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
                ZOrderListModel *listModel = [[ZOrderListModel alloc] init];
                listModel.order_id = weakSelf.order_id;
                listModel.stores_id = weakSelf.detailModel.stores_id;
                listModel.isStudent = YES;
                evc.model = listModel;
                [weakSelf.navigationController pushViewController:evc animated:YES];
            }
        }
    }];

}

#pragma mark - lazy loading...
- (UIView *)handleView {
    if (!_handleView) {
        _handleView = [[UIView alloc] init];
        _handleView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
        [_handleView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.handleView);
            make.height.mas_equalTo(CGFloatIn750(88));
        }];
        
        [topView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
            make.centerY.equalTo(topView.mas_centerY);
            make.right.equalTo(topView.mas_centerX).offset(-CGFloatIn750(20));
        }];
        
        [topView addSubview:self.payBtn];
        [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(topView);
            make.left.equalTo(topView.mas_centerX);
        }];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
        [topView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(topView);
            make.height.mas_equalTo(0.5);
        }];
    }
    
    return _handleView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMainDark]);
        _priceLabel.text = [NSString stringWithFormat:@"待支付：%@",self.detailModel.pay_amount];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldFontContent]];
    }
    return _priceLabel;
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        _payBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont boldFontContent]];
        
        __weak typeof(self) weakSelf = self;
        [_payBtn bk_addEventHandler:^(id sender) {
            if (!ValidStr(weakSelf.detailModel.account_phone)) {
                [TLUIUtility showErrorHint:@"请输入联系号码"];
                return ;
            }
            if ([weakSelf.detailModel.account_phone length] != 11) {
                [TLUIUtility showErrorHint:@"请输入正确的联系号码"];
                return ;
            }
            if (!ValidStr(weakSelf.detailModel.students_name)) {
                [TLUIUtility showErrorHint:@"请输入联系人"];
                return ;
            }
            NSMutableDictionary *params = @{}.mutableCopy;
            [params setObject:weakSelf.detailModel.stores_id forKey:@"stores_id"];
            [params setObject:weakSelf.detailModel.teacher_id forKey:@"teacher_id"];

            [params setObject:weakSelf.detailModel.course_id forKey:@"course_id"];
            [params setObject:weakSelf.detailModel.students_name forKey:@"real_name"];
            [params setObject:weakSelf.detailModel.account_phone forKey:@"phone"];
            if (self.cartModel) {
                [params setObject:self.cartModel.couponsID forKey:@"coupons_id"];
            }
            
            if (ValidStr(weakSelf.detailModel.emergency_name)) {
                [params setObject:weakSelf.detailModel.emergency_name forKey:@"emergency_name"];
                
                if (!ValidStr(weakSelf.detailModel.emergency_phone)) {
                    [TLUIUtility showErrorHint:@"您还没有输入紧急联系人电话"];
                    return;
                }
            }
            if (ValidStr(weakSelf.detailModel.emergency_phone)) {
                if (weakSelf.detailModel.emergency_phone.length != 11) {
                    [TLUIUtility showErrorHint:@"请输入正确的紧急联系人电话"];
                    return;
                }
                [params setObject:weakSelf.detailModel.emergency_phone forKey:@"emergency_phone"];
            }
            if (ValidStr(weakSelf.detailModel.emergency_contact)) {
                [params setObject:weakSelf.detailModel.emergency_contact forKey:@"emergency_contact"];
            }
            
            
            [TLUIUtility showLoading:@"获取支付信息"];
            [ZOriganizationOrderViewModel addOrder:params completeBlock:^(BOOL isSuccess, id data) {
                [TLUIUtility hiddenLoading];
                if (isSuccess) {
                    ZOrderAddNetModel *payModel = data;
                    weakSelf.order_id = payModel.order_id;
                    if (weakSelf.isAlipay) {
                        [[ZPayManager  sharedManager] getAliPayInfo:@{@"stores_id":SafeStr(self.detailModel.stores_id),@"pay_type":@"2",@"order_id":SafeStr(payModel.order_id)} complete:^(BOOL isSuccess, NSString *message) {
//                            ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
//                            ZOrderListModel *listModel = [[ZOrderListModel alloc] init];
//                            listModel.order_id = weakSelf.order_id;
//                            listModel.stores_id = weakSelf.detailModel.stores_id;
//                            listModel.isStudent = YES;
//                            evc.model = listModel;
//                            [weakSelf.navigationController pushViewController:evc animated:YES];
                        }];
                    }else{
                        [[ZPayManager sharedManager] getWechatPayInfo:@{@"stores_id":SafeStr(self.detailModel.stores_id),@"pay_type":@"1",@"order_id":SafeStr(payModel.order_id)} complete:^(BOOL isSuccess, NSString *message) {
//                            ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
//                            ZOrderListModel *listModel = [[ZOrderListModel alloc] init];
//                            listModel.order_id = weakSelf.order_id;
//                            listModel.stores_id = weakSelf.detailModel.stores_id;
//                            listModel.isStudent = YES;
//                            evc.model = listModel;
//                            [weakSelf.navigationController pushViewController:evc animated:YES];
                        }];
                    }
//                    ZOrderAddNetModel *model = data;
//                    [TLUIUtility showSuccessHint:model.message];
                }else{
                    [TLUIUtility showErrorHint:data];
                }
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentMineSettingBottomCell"]) {
        ZStudentMineSettingBottomCell *lcell = (ZStudentMineSettingBottomCell *)cell;
        lcell.titleLabel.font = [UIFont fontContent];
        lcell.titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        lcell.contentView.backgroundColor = HexAColor(0xf4f4f4, 1);
    }else if ([cellConfig.title isEqualToString:@"coupons"]) {
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.handleBlock = ^(ZCellConfig *cellConfig) {
            [ZCouponListView setAlertWithTitle:@"使用优惠券" type:@"use" stores_id:self.detailModel.stores_id course_id:self.detailModel.course_id teacher_id:self.detailModel.teacher_id  handlerBlock:^(ZOriganizationCardListModel * model) {
                weakSelf.cartModel = model;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
                 [[ZCouponListView sharedManager] removeFromSuperview];
            }];
        };
    }else if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]) {
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.handleBlock = ^(ZCellConfig *scellConfig) {
            if ([scellConfig.title isEqualToString:@"wepaylist"]){
                 self.isAlipay = NO;
                 [self initCellConfigArr];
                 [self.iTableView reloadData];
            }else if ([scellConfig.title isEqualToString:@"alipaylist"]){
                 self.isAlipay = YES;
                [self initCellConfigArr];
                [self.iTableView reloadData];
            }
        };
        
        lcell.cellSetBlock = ^(UITableViewCell *cell, NSIndexPath *index, ZCellConfig *cellConfig) {
            if ([cellConfig.title isEqualToString:@"name"]) {
                ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
                tCell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.detailModel.students_name = text;
                };
            }else if ([cellConfig.title isEqualToString:@"phone"]) {
                ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
                tCell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.detailModel.account_phone = text;
                };
            }else if ([cellConfig.title isEqualToString:@"contactName"]) {
                ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
                tCell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.detailModel.emergency_name = text;
                };
            }else if ([cellConfig.title isEqualToString:@"contactTel"]) {
                ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
                tCell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.detailModel.emergency_phone = text;
                };
            }else if ([cellConfig.title isEqualToString:@"relationship"]) {
                ZTextFieldCell *tCell = (ZTextFieldCell *)cell;
                tCell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.detailModel.emergency_contact = text;
                };
            }
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     
}

#pragma mark - set cell
- (void)setOrderDetailCell {
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderDetailCell className] title:[ZStudentMineOrderDetailCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderDetailCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:orderCellConfig];
}


- (void)setCouponsCell {
    if (!(self.hadCard)) {
        return;
    }
    NSMutableArray *configArr = @[].mutableCopy;
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.leftTitle = @"平台优惠";
    if (self.cartModel) {
        model.rightTitle = [NSString stringWithFormat:@"￥%@",self.cartModel.amount];
    }else{
        model.rightTitle = [NSString stringWithFormat:@"%@",@"不使用优惠券"];
    }
    
    model.rightImage = @"rightBlackArrowN";
    model.isHiddenLine = YES;
    model.lineLeftMargin = CGFloatIn750(30);
    model.lineRightMargin = CGFloatIn750(30);
    model.cellHeight = CGFloatIn750(62);
    model.leftFont = [UIFont boldFontSmall];
    model.rightFont = [UIFont fontSmall];
    model.rightColor = [UIColor colorRedDefault];
    model.rightDarkColor = [UIColor colorRedDefault];
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:@"couponsamount" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    
    [configArr addObject:menuCellConfig];
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:@"coupons" showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}


- (void)setOrderPriceCell {
    NSArray *tempArr ;
    
    if (self.cartModel) {
        self.detailModel.use_coupons = @"2";
    }else{
        self.detailModel.use_coupons = @"1";
    }
    if ([self.detailModel.use_coupons intValue] == 2) {
        double amount = [self.detailModel.pay_amount doubleValue] - [self.cartModel.amount doubleValue];
        if (amount <= 1) {
            amount = 1;
        }
        
        tempArr = @[@[@"合计",[NSString stringWithFormat:@"%@", SafeStr(self.detailModel.order_amount)]],@[@"平台优惠", [NSString stringWithFormat:@"-￥%@",SafeStr(self.cartModel.amount)]],@[@"",[NSString stringWithFormat:@"订单合计：￥%.2f",amount]]];
        
        self.priceLabel.text = [NSString stringWithFormat:@"待支付：￥%.2f",amount];
    }else{
        tempArr =@[@[@"合计", SafeStr(self.detailModel.order_amount)],@[@"",[NSString stringWithFormat:@"订单合计：￥%@",self.detailModel.pay_amount]]];
        self.priceLabel.text = [NSString stringWithFormat:@"待支付：￥%@",self.detailModel.pay_amount];
    }
    NSMutableArray *configArr = @[].mutableCopy;
    for (NSArray *tArr in tempArr) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = tArr[0];
        model.rightTitle = tArr[1];
        model.isHiddenLine = YES;
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.leftFont = [UIFont boldFontSmall];
        model.rightFont = [UIFont fontSmall];
        model.rightColor = [UIColor colorTextBlack];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [configArr addObject:menuCellConfig];
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}

- (void)setPayTypeCell {
    NSArray *tempArr = @[@[@"wepaylist", @"微信", self.isAlipay ?@"unSelectedCycle":@"selectedCycle"],@[@"alipaylist", @"支付宝", self.isAlipay ?@"selectedCycle":@"unSelectedCycle"]];
    NSMutableArray *configArr = @[].mutableCopy;
    for (NSArray *tArr in tempArr) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = tArr[1];
        model.rightImage = tArr[2];
        model.leftImage = tArr[0];
        model.cellTitle = tArr[0];
        model.isHiddenLine = YES;
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.leftFont = [UIFont boldFontSmall];
        model.rightFont = [UIFont fontSmall];
        model.rightColor = [UIColor colorTextBlack];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [configArr addObject:menuCellConfig];
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}


- (void)setTipsCell {
    NSArray *tempArr = @[@[@"小提醒", @"订单金额不可小于1元，若使用优惠券后，订单金额小于1元，将按照最低1元支付"]];
    NSMutableArray *configArr = @[].mutableCopy;
    for (NSArray *tArr in tempArr) {
        ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
        model.leftTitle = tArr[0];
        model.rightTitle = tArr[1];
        model.isHiddenLine = YES;
        model.cellWidth = KScreenWidth - CGFloatIn750(60);
        model.singleCellHeight = CGFloatIn750(60);
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(62);
        model.leftFont = [UIFont fontSmall];
        model.rightFont = [UIFont fontSmall];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [configArr addObject:menuCellConfig];
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}


- (void)setUserCell {
//    self.detailModel.students_name = [ZUserHelper sharedHelper].user.nikeName;
    self.detailModel.account_phone = [ZUserHelper sharedHelper].user.phone;
    NSArray *textArr = @[@[@"真实姓名", @"请输入真实姓名", @YES, @"", @"name",SafeStr(self.detailModel.students_name),@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"联系方式", @"请输入联系方式", @YES, @"", @"phone",SafeStr(self.detailModel.account_phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                         @[@"紧急联系人姓名", @"选填", @YES, @"", @"contactName",SafeStr(self.detailModel.emergency_name),@10,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"紧急联系人电话", @"选填", @YES, @"", @"contactTel",SafeStr(self.detailModel.emergency_phone),@11,[NSNumber numberWithInt:ZFormatterTypePhoneNumber]],
                         @[@"紧急联系人与学员关系",@"选填", @YES, @"", @"relationship",SafeStr(self.detailModel.emergency_contact),@10,[NSNumber numberWithInt:ZFormatterTypeAny]]];
    NSMutableArray *configArr = @[].mutableCopy;
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
        cellModel.cellHeight = CGFloatIn750(62);
        cellModel.leftFont = [UIFont boldFontSmall];
        cellModel.rightFont = [UIFont fontSmall];
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [configArr addObject:textCellConfig];
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}

- (void)getUseCard {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:SafeStr(self.detailModel.stores_id) forKey:@"stores_id"];
    [params setObject:SafeStr(self.detailModel.course_id) forKey:@"course_id"];
    [params setObject:SafeStr(self.detailModel.teacher_id) forKey:@"teacher_id"];
    [params setObject:@"1" forKey:@"use_status"];
    [ZOriganizationCardViewModel getUseCardLessonList:params completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
        if (isSuccess && data) {
            if (data.list && data.list.count > 0) {
                weakSelf.cartModel = data.list[0];
                weakSelf.hadCard = YES;
            }else{
                weakSelf.hadCard = NO;
            }
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [weakSelf.iTableView reloadData];
        }
    }];
}
@end
