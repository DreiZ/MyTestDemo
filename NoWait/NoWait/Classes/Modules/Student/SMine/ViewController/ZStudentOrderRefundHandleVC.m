//
//  ZStudentOrderRefundHandleVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrderRefundHandleVC.h"
#import "ZStudentMineOrderTopStateCell.h"
#import "ZStudentMineOrderDetailCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZTableViewListCell.h"
#import "ZStudentMineSettingBottomCell.h"

#import "ZStudentOrderPayVC.h"
#import "ZBaseUnitModel.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZStudentMineEvaEditVC.h"

@interface ZStudentOrderRefundHandleVC ()
@property (nonatomic,strong) UIButton *handleView;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end
@implementation ZStudentOrderRefundHandleVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailModel.refund_amount = self.detailModel.pay_amount;
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    if (!self.detailModel) {
        return;
    }
    
    self.detailModel.status = @"1";
    [self setOrderDetailCell];
    [self setUserCell];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"申请退款"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    [self.navigationItem setLeftBarButtonItem:item];
}


- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_navLeftBtn setTitle:@"" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor blackColor], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontMaxTitle]];
        [_navLeftBtn setImage:isDarkModel() ? [UIImage imageNamed:@"navleftBackDark"] : [UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
             
               NSArray *viewControllers = self.navigationController.viewControllers;
               NSArray *reversedArray = [[viewControllers reverseObjectEnumerator] allObjects];
               
               ZViewController *target;
               for (ZViewController *controller in reversedArray) {
                   if ([controller isKindOfClass:[NSClassFromString(@"ZStudentLessonDetailVC") class]]) {
                       target = controller;
                       break;
                   }else if ([controller isKindOfClass:[NSClassFromString(@"ZStudentOrganizationDetailDesVC") class]]){
                       target = controller;
                   }
               }
               
               if (target) {
                   [weakSelf.navigationController popToViewController:target animated:YES];
                   return;
               }
               [weakSelf.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}


- (void)setupMainView {
    [super setupMainView];
    [self.view addSubview:self.handleView];
    [self.handleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.handleView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

#pragma mark - lazy loading...
-(UIButton *)handleView {
    if (!_handleView) {
        __weak typeof(self) weakSelf = self;
        _handleView = [[ZButton alloc] initWithFrame:CGRectZero];
        [_handleView bk_addEventHandler:^(id sender) {
            NSMutableDictionary *params = @{}.mutableCopy;
            if (ValidStr(weakSelf.detailModel.refund_msg)) {
                [params setObject:SafeStr(weakSelf.detailModel.refund_msg) forKey:@"refund_desc"];
            }else{
                [TLUIUtility showErrorHint:@"请输入退款原因"];
                return ;
                
            }
            if (ValidStr(weakSelf.detailModel.refund_amount) && [weakSelf.detailModel.refund_amount doubleValue] >= 0.01) {
                [params setObject:SafeStr(weakSelf.detailModel.refund_amount) forKey:@"refund_amount"];
            }else{
                [TLUIUtility showErrorHint:@"请输入退款价格"];
                return ;
            }
            if ([self.detailModel.refund_amount doubleValue] - [self.detailModel.pay_amount doubleValue] >= 0.01) {
                [TLUIUtility showErrorHint:@"退款价格大于订单金额"];
                return;
            }
            
            if (ValidStr(weakSelf.detailModel.order_id)) {
                [params setObject:SafeStr(weakSelf.detailModel.order_id) forKey:@"order_id"];
            }
            
            if (ValidStr(weakSelf.detailModel.stores_id)) {
                [params setObject:SafeStr(weakSelf.detailModel.stores_id) forKey:@"stores_id"];
            }
            
            [ZOriganizationOrderViewModel handleOrderWithIndex:ZLessonOrderHandleTypeRefund data:params completeBlock:^(BOOL isSuccess, id data) {
                if (isSuccess) {
                    [TLUIUtility showSuccessHint:data];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [TLUIUtility showErrorHint:data];
                }
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        [_handleView setTitle:@"提交申请" forState:UIControlStateNormal];
        [_handleView setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_handleView.titleLabel setFont:[UIFont fontContent]];
        _handleView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    return _handleView;
}

#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentMineSettingBottomCell"]) {
        ZStudentMineSettingBottomCell *lcell = (ZStudentMineSettingBottomCell *)cell;
        lcell.titleLabel.font = [UIFont fontContent];
        lcell.titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        lcell.contentView.backgroundColor = HexAColor(0xf4f4f4, 1);
    }else if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]){
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.cellSetBlock = ^(UITableViewCell *tcell, NSIndexPath *tindexPath, ZCellConfig *tcellConfig) {
            if ([tcellConfig.title isEqualToString:@"name"]) {
                ZTextFieldCell *fCell = (ZTextFieldCell *)tcell;
                fCell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.detailModel.refund_msg = text;
                };
            }else if ([tcellConfig.title isEqualToString:@"price"]){
                ZTextFieldCell *fCell = (ZTextFieldCell *)tcell;
                fCell.valueChangeBlock = ^(NSString * text) {
                    weakSelf.detailModel.refund_amount = text;
                };
            }
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
          
    }
}


#pragma mark - set cell
- (void)setOrderDetailCell {
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderDetailCell className] title:[ZStudentMineOrderDetailCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderDetailCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:orderCellConfig];
}


- (void)setUserCell {
    self.detailModel.students_name = [ZUserHelper sharedHelper].user.nikeName;
    self.detailModel.account_phone = [ZUserHelper sharedHelper].user.phone;
    NSArray *textArr = @[@[@"退款原因", @"必填", @YES, @"", @"name",SafeStr(self.detailModel.refund_msg),@50,[NSNumber numberWithInt:ZFormatterTypeAny]],
                         @[@"退款金额", @"0", @YES, @"", @"price",SafeStr(self.detailModel.pay_amount),@10,[NSNumber numberWithInt:ZFormatterTypeDecimal]]];
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
        cellModel.textFont = [UIFont fontSmall];
        if (i == 1) {
            cellModel.textColor = [UIColor colorRedForButton];
            cellModel.textDarkColor = [UIColor colorRedForButton];
        }
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [configArr addObject:textCellConfig];
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}
#pragma mark - 网络数据
@end

