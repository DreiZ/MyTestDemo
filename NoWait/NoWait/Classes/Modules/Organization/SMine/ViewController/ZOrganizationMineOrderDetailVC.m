//
//  ZOrganizationMineOrderDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineOrderDetailVC.h"
#import "ZStudentMineOrderDetailHandleBottomView.h"

#import "ZStudentMineOrderTopStateCell.h"
#import "ZStudentMineOrderDetailCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZTableViewListCell.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZSingleLeftRoundImageCell.h"
#import "ZMineOrderDetailCell.h"
#import "ZSingleLineRightImageCell.h"
#import "ZOrganizationLessonAddPhotosCell.h"

#import "ZBaseUnitModel.h"
#import "ZOriganizationOrderViewModel.h"

@interface ZOrganizationMineOrderDetailVC ()
@property (nonatomic,strong) ZStudentMineOrderDetailHandleBottomView *handleView;
@property (nonatomic,strong) ZOrderDetailModel *detailModel;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end
@implementation ZOrganizationMineOrderDetailVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setDataSource {
    [super setDataSource];
    __weak typeof(self) weakSelf = self;
    [[kNotificationCenter rac_addObserverForName:KNotificationPayBack object:nil] subscribeNext:^(NSNotification *notfication) {
        if (notfication.object && [notfication.object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *backDict = notfication.object;
            if (backDict && [backDict objectForKey:@"payState"]) {
                [weakSelf refreshData];
            }
        }
    }];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    if (!self.detailModel) {
        return;
    }
    self.detailModel.isStudent = [[ZUserHelper sharedHelper].user.type intValue] == 1;
    self.detailModel.isRefund = self.model.isRefund;
    if (self.detailModel.isRefund) {
        [self setTableViewWhiteBack];
        [self setRefuseCell];
    }else{
        switch (self.detailModel.order_type) {
            case ZOrganizationOrderTypeForPay://待付款（去支付，取消）
                ;
            case ZStudentOrderTypeForPay://待付款（去支付，取消）
                {
                    [self setTopStateCell];
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
                    [self setPayDetailCell];
//                    [self setPayTypeCell];
                }
                break;
            case ZOrganizationOrderTypeHadPay://已付款（评价，退款，删除）
                ;
            case ZStudentOrderTypeHadPay://已付款（评价，退款，删除）
                {
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
                    [self setPayDetailCell];
                }
                break;
            case ZOrganizationOrderTypeHadEva://完成已评价(删除)
                ;
            case ZStudentOrderTypeHadEva://完成已评价(删除)
                {
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
                    [self setPayDetailCell];
                }
                break;
            case ZOrganizationOrderTypeOrderOutTime:
            case ZStudentOrderTypeOrderOutTime:
            case ZOrganizationOrderTypeOutTime://超时(删除)
                ;
            case ZStudentOrderTypeOutTime://超时(删除)
                {
                    [self setTopHintCell];
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
                    [self setPayDetailCell];
                }
                break;
            case ZOrganizationOrderTypeCancel://已取消(删除)
                ;
            case ZStudentOrderTypeCancel://已取消(删除)
                {
                    [self setTopHintCell];
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
                    [self setPayDetailCell];
                }
                break;
            case ZOrganizationOrderTypeOrderForPay://待付款（去支付，取消）
                ;
            case ZStudentOrderTypeOrderForPay://待付款（去支付，取消）
                {
                    [self setTopStateCell];
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
//                    [self setPayTypeCell];
                    [self setTipsCell];
                }
                break;
            case ZOrganizationOrderTypeOrderForReceived://待接收（预约）
            ;
            case ZStudentOrderTypeOrderForReceived://待接收（预约）
                {
                    [self setTopHintCell];
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
                    [self setPayDetailCell];
                    [self setTipsCell];
                }
                break;
            case ZStudentOrderTypeOrderComplete://已完成（预约，删除）
                [self setTopHintCell];
            case ZOrganizationOrderTypeOrderComplete://已完成（预约，删除）
                {
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
                    [self setPayDetailCell];
                    [self setTipsCell];
                }
                break;
            case ZOrganizationOrderTypeOrderRefuse://已拒绝（预约
                ;
            case ZStudentOrderTypeOrderRefuse://已拒绝（预约）
                {
                    [self setTopHintCell];
                    [self setOrderDetailCell];
                    [self setUserCell];
                    [self setOrderPriceCell];
                    [self setPayDetailCell];
                    [self setTipsCell];
                }
                break;
            default:
                break;
        }
    }
    

    [self updateBottom];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"订单详情"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
    [self.navigationItem setLeftBarButtonItem:item];
}


- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(80), CGFloatIn750(80))];
        [_navLeftBtn setTitle:@"" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorBlackBGDark], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontMaxTitle]];
        [_navLeftBtn setImage:isDarkModel() ? [UIImage imageNamed:@"navleftBackDark"] : [UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
             
               NSArray *viewControllers = weakSelf.navigationController.viewControllers;
               NSArray *reversedArray = [[viewControllers reverseObjectEnumerator] allObjects];
               
               ZViewController *target;
               for (ZViewController *controller in reversedArray) {
                   if ([controller isKindOfClass:[NSClassFromString(@"ZStudentExperienceLessonDetailVC") class]]) {
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
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(100)+safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.handleView.mas_top);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
    
    self.handleView.hidden = YES;
    
    [self setTableViewGaryBack];
}

- (void)updateBottom {
    self.handleView.model = self.detailModel;
    if (self.detailModel.isStudent) {
        if (self.detailModel.order_type == ZStudentOrderTypeForPay
            || self.detailModel.order_type == ZStudentOrderTypeHadEva
            || self.detailModel.order_type == ZStudentOrderTypeHadPay
            || self.detailModel.order_type == ZStudentOrderTypeOrderForPay
            || self.detailModel.order_type == ZStudentOrderTypeOrderOutTime
            || self.detailModel.order_type == ZStudentOrderTypeOutTime
            || self.detailModel.order_type == ZStudentOrderTypeOrderComplete
            || self.detailModel.order_type == ZStudentOrderTypeCancel
            || self.detailModel.order_type == ZStudentOrderTypeOrderForReceived
            || self.detailModel.order_type == ZStudentOrderTypeOrderRefuse
            || self.detailModel.isRefund) {
            
//            if (self.detailModel.order_type == ZStudentOrderTypeHadPay && [self.detailModel.can_comment intValue] != 1) {
//                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                    self.handleView.hidden = YES;
//
//                    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        make.left.right.equalTo(self.view);
//                        make.bottom.equalTo(self.view.mas_bottom);
//                        make.top.equalTo(self.view.mas_top).offset(0);
//                    }];
//                } completion:^(BOOL finished) {
//
//                }];
//                [self loadViewIfNeeded];
//                return;
//            }
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.handleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.right.equalTo(self.view);
                    make.height.mas_equalTo(CGFloatIn750(100)+safeAreaBottom());
                }];
                
                [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.bottom.equalTo(self.handleView.mas_top);
                    make.top.equalTo(self.view.mas_top).offset(0);
                }];
                self.handleView.hidden = NO;
            } completion:^(BOOL finished) {
                
            }];
            [self loadViewIfNeeded];
            return;
        }
    }else{
        if (self.detailModel.order_type == ZOrganizationOrderTypeOrderForReceived
            || self.detailModel.order_type == ZOrganizationOrderTypeOutTime
            || self.detailModel.order_type == ZOrganizationOrderTypeCancel
            || self.detailModel.isRefund) {
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.handleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.right.equalTo(self.view);
                    make.height.mas_equalTo(CGFloatIn750(100)+safeAreaBottom());
                }];
                
                [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.bottom.equalTo(self.handleView.mas_top);
                    make.top.equalTo(self.view.mas_top).offset(0);
                }];
                self.handleView.hidden = NO;
            } completion:^(BOOL finished) {
                
            }];
            [self loadViewIfNeeded];
            return;
        }
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.handleView.hidden = YES;
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.view.mas_top).offset(0);
        }];
    } completion:^(BOOL finished) {
        
    }];
    
    [self loadViewIfNeeded];
    
    if (self.detailModel && self.detailModel.isRefund && self.detailModel.isStudent) {
        if ([self.detailModel.refund_status intValue] == 1 || [self.detailModel.refund_status intValue] == 2 ||
            [self.detailModel.refund_status intValue] == 3 ||
            [self.detailModel.refund_status intValue] == 4) {
            UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
            sureBtn.layer.masksToBounds = YES;
            sureBtn.layer.cornerRadius = 3;
            sureBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
            [sureBtn setTitle:@"取消退款" forState:UIControlStateNormal];
            [sureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
            [sureBtn.titleLabel setFont:[UIFont fontSmall]];
            [sureBtn bk_addEventHandler:^(id sender) {
                [ZOriganizationOrderViewModel handleOrderWithIndex:ZLessonOrderHandleTypeSRefundCancle data:self.detailModel completeBlock:^(BOOL isSuccess, id data) {
                    
                }];
            } forControlEvents:UIControlEventTouchUpInside];
            [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
        }
    }
}

#pragma mark - lazy loading...
- (ZStudentMineOrderDetailHandleBottomView *)handleView {
    if (!_handleView) {
        __weak typeof(self) weakSelf = self;
        _handleView = [[ZStudentMineOrderDetailHandleBottomView alloc] init];
        _handleView.handleBlock = ^(ZLessonOrderHandleType type) {
            if (type == ZLessonOrderHandleTypeEva) {
                routePushVC(ZRoute_mine_evaEdit, weakSelf.detailModel, nil);
            }else if (type == ZLessonOrderHandleTypeTel) {
                if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
                    [ZPublicTool callTel:weakSelf.detailModel.phone];
                }else{
                    [ZPublicTool callTel:weakSelf.detailModel.account_phone];
                }
                
            }else{
                [ZOriganizationOrderViewModel handleOrderWithIndex:type data:weakSelf.detailModel completeBlock:^(BOOL isSuccess, id data) {
                    if (isSuccess) {
                        [TLUIUtility showSuccessHint:data];
                        [weakSelf refreshData];
                    }else{
                        [TLUIUtility showErrorHint:data];
                    }
                }];
            }
        };
        
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
        lcell.contentView.backgroundColor = adaptAndDarkColor(HexAColor(0xf4f4f4, 1), HexAColor(0x040404, 1));
    }else if ([cellConfig.title isEqualToString:@"refund_success"]) {
        ZStudentMineSettingBottomCell *lcell = (ZStudentMineSettingBottomCell *)cell;
        lcell.titleLabel.font = [UIFont fontContent];
        lcell.titleLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        lcell.contentView.backgroundColor = [UIColor colorMain];
    }else if ([cellConfig.title isEqualToString:@"ZStudentMineOrderDetailCell"]){
        ZStudentMineOrderDetailCell *lcell = (ZStudentMineOrderDetailCell *)cell;
        lcell.handleBlock = ^(NSInteger index, ZOrderDetailModel *model) {
            if (index == ZLessonOrderHandleTypeRefund) {
                routePushVC(ZRoute_mine_OrderRefundHandle, weakSelf.detailModel, nil);
            }else if (index == ZLessonOrderHandleTypeClub){
                ZStoresListModel *lmodel = [[ZStoresListModel alloc] init];
                lmodel.stores_id = model.stores_id;
                lmodel.name = model.store_name;
                routePushVC(ZRoute_main_organizationDetail, lmodel, nil);
            }else if(index == ZLessonOrderHandleTypeLesson){
                ZOriganizationLessonListModel *listmodel = [[ZOriganizationLessonListModel alloc] init];
                listmodel.lessonID = model.course_id;
                routePushVC(ZRoute_main_orderLessonDetail, listmodel, nil);
            }
        };
    }else if ([cellConfig.title isEqualToString:@"refundAmout"]){
        ZTextFieldCell *lcell = (ZTextFieldCell *)cell;
        lcell.valueChangeBlock = ^(NSString * text) {
            weakSelf.detailModel.refund_amount = text;
        };
    }else if([cellConfig.title isEqualToString:@"ZTableViewListCell"]){
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.handleBlock = ^(ZCellConfig *lcellConfig) {
            if ([lcellConfig.title isEqualToString:@"phone"]){
                if (!weakSelf.detailModel.isStudent) {
                    [ZPublicTool callTel:SafeStr(weakSelf.detailModel.account_phone)];
                }
            }
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if([cellConfig.title isEqualToString:@"ZMineOrderDetailCell"]){
         ZOriganizationLessonListModel *listmodel = [[ZOriganizationLessonListModel alloc] init];
         listmodel.lessonID = self.detailModel.course_id;
         routePushVC(ZRoute_main_orderLessonDetail, listmodel, nil);
     }else if ([cellConfig.title isEqualToString:@"phone"]){
         if (!self.detailModel.isStudent) {
             [ZPublicTool callTel:SafeStr(self.detailModel.account_phone)];
         }
     }
}


#pragma mark - set cell
- (void)setTopHintCell {
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:[ZStudentMineSettingBottomCell className] showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(48) cellType:ZCellTypeClass dataModel:self.detailModel.statusStr];
    [self.cellConfigArr addObject:orderCellConfig];
}

- (void)setTopStateCell {
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderTopStateCell className] title:[ZStudentMineOrderTopStateCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderTopStateCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:orderCellConfig];
}

- (void)setOrderDetailCell {
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderDetailCell className] title:[ZStudentMineOrderDetailCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderDetailCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
    [self.cellConfigArr addObject:orderCellConfig];
}

- (void)setUserCell {
    NSArray *tempArr = @[@[@"联系人姓名", SafeStr(self.detailModel.students_name)],@[@"手机号",  SafeStr(self.detailModel.account_phone)]];
    NSMutableArray *configArr = @[].mutableCopy;
    NSInteger index = 0;
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
        
        if (index == 1) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineRightImageCell className] title:@"phone" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineRightImageCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [configArr addObject:menuCellConfig];
            model.rightColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        }else {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [configArr addObject:menuCellConfig];
        }
        index ++;
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}

- (void)setOrderPriceCell {
    NSArray *tempArr ;
    
    if ([self.detailModel.use_coupons intValue] == 2) {
        tempArr = @[@[@"合计",[NSString stringWithFormat:@"%@", SafeStr(self.detailModel.order_amount)]],@[@"平台优惠", [NSString stringWithFormat:@"-￥%@",SafeStr(self.detailModel.coupons_amount)]],@[@"",[NSString stringWithFormat:@"订单合计：￥%@",self.detailModel.pay_amount]]];
    }else{
        tempArr =@[@[@"合计", SafeStr(self.detailModel.order_amount)],@[@"",[NSString stringWithFormat:@"订单合计：￥%@",self.detailModel.pay_amount]]];
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
    NSArray *tempArr = @[@[@"wepaylist", @"微信", @"selectedCycle"],@[@"alipaylist", @"支付宝", @"unSelectedCycle"]];
    NSMutableArray *configArr = @[].mutableCopy;
    for (NSArray *tArr in tempArr) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = tArr[1];
        model.rightImage = tArr[2];
        model.leftImage = tArr[0];
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

- (void)setPayDetailCell {
    NSArray *tempArr;
    if (self.detailModel.order_type == ZStudentOrderTypeForPay
        || self.detailModel.order_type == ZOrganizationOrderTypeForPay
        || self.detailModel.order_type == ZOrganizationOrderTypeOrderForPay
        || self.detailModel.order_type == ZStudentOrderTypeOrderForPay
        || self.detailModel.order_type == ZStudentOrderTypeOutTime
        || self.detailModel.order_type == ZOrganizationOrderTypeOutTime) {
        tempArr = @[@[@"订单号", SafeStr(self.detailModel.order_no)],@[@"创建时间", SafeStr(self.detailModel.create_at)]];
    }else{
        tempArr = @[@[@"支付方式", [SafeStr(self.detailModel.pay_type) intValue] == 1 ? @"微信":@"支付宝"],@[@"订单号", SafeStr(self.detailModel.order_no)],@[@"创建时间", SafeStr(self.detailModel.create_at)],@[@"付款时间", [SafeStr(self.detailModel.pay_time) timeStringWithFormatter:@"yyyy-MM-dd HH:mm:ss"]]];
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

- (void)setTipsCell {
    NSArray *tempArr = @[@[@"小提醒", @"支付后预约课程不可取消"]];
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

//退款
- (void)setRefuseCell {
    if ([self.detailModel.refund_status intValue] == 7 || [self.detailModel.refund_status intValue] == 8) {
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"refund_success" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(60) cellType:ZCellTypeClass dataModel:@"退款成功"];
        [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    if (!self.detailModel.isStudent) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = self.detailModel.nick_name ;
        model.leftImage = self.detailModel.account_image;
        model.isHiddenLine = YES;
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(84);
        model.leftFont = [UIFont fontSmall];
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLeftRoundImageCell className] title:[ZSingleLeftRoundImageCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLeftRoundImageCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:bottomCellConfig];
        [self.cellConfigArr addObject:[self getLineWithHeight:CGFloatIn750(4)]];
    }

    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        {
            NSArray *titleArr = @[@[@"交易金额", @"lessonName",@"",@10,[NSNumber numberWithInt:ZFormatterTypeAny],@NO,[NSString stringWithFormat:@"￥%@",self.detailModel.pay_amount]],@[@"退款金额",@"refundAmout",@"填写退款金额",@10,[NSNumber numberWithInt:ZFormatterTypeAny],@YES,SafeStr(self.detailModel.refund_amount)]];
            
            for (int i = 0 ; i < titleArr.count; i++) {
                ZBaseTextFieldCellModel *model = [[ZBaseTextFieldCellModel alloc] init];
                model.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
                model.isHiddenLine = YES;
                model.textAlignment = NSTextAlignmentRight;
                model.isHiddenInputLine = YES;
                model.leftFont = [UIFont boldFontSmall];
                model.textFont = [UIFont fontSmall];
                model.cellHeight = CGFloatIn750(62);
                model.textFieldHeight = CGFloatIn750(60);
                model.leftMargin = CGFloatIn750(30);
                
                
                model.leftTitle = titleArr[i][0];
                model.cellTitle = titleArr[i][1];
                model.placeholder = titleArr[i][2];
                model.max = [titleArr[i][3] intValue];
                model.formatterType = [titleArr[i][4] intValue];
                model.isTextEnabled = titleArr[i][5];
                model.content = titleArr[i][6];
                if (i == 1) {
                    if (self.detailModel.isStudent) {
                        //申请退款中的状态  状态：1：学员申请 2：校区拒绝 3：学员拒绝 4：学员同意 5：校区同意
                        if ([self.detailModel.refund_status intValue] == 2) {
                            model.isTextEnabled = YES;
                        }else{
                            model.isTextEnabled = NO;
                            model.placeholder = @"";
                        }
                    }else{
                        if ([self.detailModel.refund_status intValue] == 1 || [self.detailModel.refund_status intValue] == 3) {
                            model.isTextEnabled = YES;
                        }else{
                            model.isTextEnabled = NO;
                            model.placeholder = @"";
                        }
                    }
                }
                

                ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:nameCellConfig];
                if (i == 0) {
                    [self.cellConfigArr addObject:[self getLineWithHeight:CGFloatIn750(10)]];
                }
            }
            
            if (self.detailModel.isStudent) {
                //申请退款中的状态  状态：1：学员申请 2：校区拒绝 3：学员拒绝 4：学员同意 5：校区同意
                if ([self.detailModel.refund_status intValue] == 2) {
                    ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
                    model.rightTitle = @"校区已拒绝您提供的退款金额，如重新协商金额，请先修改此金额然后”协商退款“";
                    model.isHiddenLine = YES;
                    model.cellWidth = KScreenWidth;
                    model.leftMargin = CGFloatIn750(160);
                    model.rightMargin = CGFloatIn750(20);
                    model.singleCellHeight = CGFloatIn750(32);
                    model.cellHeight = CGFloatIn750(34);
                    model.lineSpace = CGFloatIn750(10);
                    model.rightFont = [UIFont fontSmall];
                    model.rightColor = [UIColor colorRedForLabel];
                    model.rightDarkColor =  [UIColor colorRedForLabel];
                    
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                    [self.cellConfigArr addObject:menuCellConfig];
                    [self.cellConfigArr addObject:[self getLineWithHeight:CGFloatIn750(40)]];
                }else{
                    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
                }
            }else{
                if ([self.detailModel.refund_status intValue] == 1 || [self.detailModel.refund_status intValue] == 3) {
                    ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
                    model.rightTitle = @"如重新协商金额，请先修改此金额然后“协商退款”";
                    if ([self.detailModel.refund_status intValue] == 3) {
                        model.rightTitle = @"学员已拒绝你提供的退款金额提议,如重新协商金额，请先修改此金额然后”协商退款“";
                    }
                    model.isHiddenLine = YES;
                    model.cellWidth = KScreenWidth;
                    model.leftMargin = CGFloatIn750(160);
                    model.rightMargin = CGFloatIn750(18);
                    model.singleCellHeight = CGFloatIn750(32);
                    model.cellHeight = CGFloatIn750(34);
                    model.lineSpace = CGFloatIn750(10);
                    model.rightFont = [UIFont fontSmall];
                    model.rightColor = [UIColor colorRedForLabel];
                    model.rightDarkColor =  [UIColor colorRedForLabel];
                    
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                    [self.cellConfigArr addObject:menuCellConfig];
                    [self.cellConfigArr addObject:[self getLineWithHeight:CGFloatIn750(40)]];
                }else{
                    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
                }
            }
            
        }
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        NSArray *tempArr = @[@[@"联系人姓名", SafeStr(self.detailModel.students_name)],@[@"手机号", SafeStr(self.detailModel.account_phone)]];
        NSInteger index = 0;
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
            
            if (index == 1) {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineRightImageCell className] title:@"phone" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineRightImageCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:menuCellConfig];
                model.rightColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
            }else {
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            index ++;
        }
        
        [self.cellConfigArr addObject:[self getLineWithHeight:CGFloatIn750(40)]];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        
        NSMutableArray *titleArr = @[@[@"退款原因",SafeStr(self.detailModel.refund_msg)],
                              @[@"退款编号",SafeStr(self.detailModel.out_refund_no)],
                              @[@"订单编号",SafeStr(self.detailModel.order_no)],
                              @[@"申请时间",[SafeStr(self.detailModel.refund_time) timeStringWithFormatter:@"yyyy-MM-dd HH:MM:ss"]]].mutableCopy;
        if (ValidStr(self.detailModel.refund_finish_time) && ![self.detailModel.refund_finish_time isEqualToString:@"0"]) {
            [titleArr addObject:@[@"退款时间",[SafeStr(self.detailModel.refund_finish_time) timeStringWithFormatter:@"yyyy-MM-dd HH:MM:ss"]]];
        }
        for (int i = 0; i < titleArr.count; i++) {
            if (i == 0) {
                ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
                model.leftTitle = titleArr[i][0];
                model.rightTitle = titleArr[i][1];
                model.isHiddenLine = YES;
                model.cellWidth = KScreenWidth;
                model.singleCellHeight = CGFloatIn750(60);
                model.lineLeftMargin = CGFloatIn750(30);
                model.lineRightMargin = CGFloatIn750(30);
                model.cellHeight = CGFloatIn750(62);
                model.leftFont = [UIFont boldFontSmall];
                model.rightFont = [UIFont fontSmall];
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMultiseriateContentLeftLineCell className] title:model.cellTitle showInfoMethod:@selector(setMModel:) heightOfCell:[ZMultiseriateContentLeftLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                
                [self.cellConfigArr addObject:menuCellConfig];
            }else{
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.leftTitle = titleArr[i][0];
                model.rightTitle = titleArr[i][1];
                model.isHiddenLine = YES;
                model.lineLeftMargin = CGFloatIn750(30);
                model.lineRightMargin = CGFloatIn750(30);
                model.cellHeight = CGFloatIn750(62);
                model.leftFont = [UIFont boldFontSmall];
                model.rightFont = [UIFont fontSmall];
                model.rightColor = [UIColor colorTextBlack];
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                
                [self.cellConfigArr addObject:menuCellConfig];
            }
        }
        
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        
        {
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineOrderDetailCell className] title:[ZMineOrderDetailCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMineOrderDetailCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
            [self.cellConfigArr addObject:orderCellConfig];
        }
    }
}

- (ZCellConfig *)getLineWithHeight:(CGFloat)height {
    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
    model.isHiddenLine = NO;
    model.lineLeftMargin = CGFloatIn750(30);
    model.lineRightMargin = CGFloatIn750(30);
    model.cellHeight = height;

    return [ZCellConfig cellConfigWithClassName:[ZSingleLeftRoundImageCell className] title:[ZSingleLeftRoundImageCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLeftRoundImageCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
}

#pragma mark - 网络数据
- (void)refreshData {
    self.loading = YES;
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = @{@"order_id":SafeStr(self.model.order_id)}.mutableCopy;
    if (self.model) {
        [params setObject:SafeStr(self.model.stores_id) forKey:@"stores_id"];
    }
    if (self.model.isRefund) {
        [ZOriganizationOrderViewModel getOrderRefundDetail:params completeBlock:^(BOOL isSuccess, id data) {
            weakSelf.loading = NO;
            if (isSuccess) {
                weakSelf.detailModel = data;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }else{
                [TLUIUtility showErrorHint:data];
            }
        }];
        
    }else{
        [ZOriganizationOrderViewModel getOrderDetail:params completeBlock:^(BOOL isSuccess, id data) {
            weakSelf.loading = NO;
            if (isSuccess) {
                weakSelf.detailModel = data;
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }else{
                [TLUIUtility showErrorHint:data];
            }
        }];
    }
}
@end

#pragma mark - RouteHandler
@interface ZOrganizationMineOrderDetailVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationMineOrderDetailVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_orderDetail;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationMineOrderDetailVC *routevc = [[ZOrganizationMineOrderDetailVC alloc] init];
    routevc.model = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
