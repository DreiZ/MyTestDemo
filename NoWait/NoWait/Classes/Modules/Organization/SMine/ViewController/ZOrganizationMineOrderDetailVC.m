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

#import "ZStudentOrderPayVC.h"
#import "ZBaseUnitModel.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZStudentMineEvaEditVC.h"

@interface ZOrganizationMineOrderDetailVC ()
@property (nonatomic,strong) ZStudentMineOrderDetailHandleBottomView *handleView;
@property (nonatomic,strong) ZOrderDetailModel *detailModel;
@property (nonatomic,strong) UIButton *navLeftBtn;

@end
@implementation ZOrganizationMineOrderDetailVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [self refreshData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    if (!self.detailModel) {
        return;
    }
    self.detailModel.isStudent = YES;
    switch (self.detailModel.type) {
        case ZOrganizationOrderTypeForPay://待付款（去支付，取消）
            ;
        case ZStudentOrderTypeForPay://待付款（去支付，取消）
            {
                [self setTopStateCell];
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
                [self setPayDetailCell];
                [self setPayTypeCell];
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
                [self setPayTypeCell];
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
                [self setPayDetailCell];
                [self setTipsCell];
            }
            break;
        case ZOrganizationOrderTypeOrderComplete://已完成（预约，删除）
            ;
        case ZStudentOrderTypeOrderComplete://已完成（预约，删除）
            {
                [self setOrderDetailCell];
                [self setUserCell];
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
                [self setPayDetailCell];
                [self setTipsCell];
            }
            break;
            
         case ZStudentOrderTypeForRefuse://退款（去支付，取消）
            {
                [self setTopStateCell];
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
                [self setPayTypeCell];
                [self setTipsCell];
            }
            break;
        case ZOrganizationOrderTypeForRefuse://退款（去支付，取消）
           {
               [self setTableViewWhiteBack];
               [self setRefuseCell];
           }
           break;
        case ZStudentOrderTypeForRefuseComplete://退款（去支付，取消）
            {
                [self setTopStateCell];
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
                [self setPayTypeCell];
                [self setTipsCell];
            }
            break;
        case ZOrganizationOrderTypeForRefuseComplete://退款（去支付，取消）
           {
               [self setTableViewWhiteBack];
               [self setRefuseCell];
           }
           break;
        default:
            break;
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
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_navLeftBtn setTitle:@"" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor blackColor], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontMaxTitle]];
        [_navLeftBtn setImage:isDarkModel() ? [UIImage imageNamed:@"navleftBackDark"] : [UIImage imageNamed:@"navleftBack"] forState:UIControlStateNormal];
        [_navLeftBtn bk_whenTapped:^{
             
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
               [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }];
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
}

- (void)updateBottom {
    self.handleView.model = self.detailModel;
    if (self.detailModel.isStudent) {
        if (self.detailModel.type == ZStudentOrderTypeForPay
            || self.detailModel.type == ZStudentOrderTypeHadEva
            || self.detailModel.type == ZStudentOrderTypeHadPay
            || self.detailModel.type == ZStudentOrderTypeOrderForPay
            || self.detailModel.type == ZStudentOrderTypeOrderOutTime
            || self.detailModel.type == ZStudentOrderTypeOutTime
            || self.detailModel.type == ZStudentOrderTypeOrderComplete
            || self.detailModel.type == ZStudentOrderTypeCancel
            || self.detailModel.type == ZStudentOrderTypeOrderForReceived
            || self.detailModel.type == ZStudentOrderTypeOrderRefuse) {
            
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
            
            return;
        }
    }else{
        if (self.detailModel.type == ZOrganizationOrderTypeOrderForReceived
            || self.detailModel.type == ZOrganizationOrderTypeOutTime
            || self.detailModel.type == ZOrganizationOrderTypeCancel) {
            
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
}

#pragma mark - lazy loading...
- (ZStudentMineOrderDetailHandleBottomView *)handleView {
    if (!_handleView) {
        __weak typeof(self) weakSelf = self;
        _handleView = [[ZStudentMineOrderDetailHandleBottomView alloc] init];
        _handleView.handleBlock = ^(ZLessonOrderHandleType type) {
            if (type == ZLessonOrderHandleTypePay) {
                ZStudentOrderPayVC *pvc = [[ZStudentOrderPayVC alloc] init];
                [weakSelf.navigationController pushViewController:pvc animated:YES];
            }else if (type == ZLessonOrderHandleTypeEva) {
                ZStudentMineEvaEditVC *evc = [[ZStudentMineEvaEditVC alloc] init];
                evc.detailModel = weakSelf.detailModel;
                [weakSelf.navigationController pushViewController:evc animated:YES];
            }else if (type == ZLessonOrderHandleTypeTel) {
                [ZPublicTool callTel:weakSelf.detailModel.account_phone];
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
    if ([cellConfig.title isEqualToString:@"ZStudentMineSettingBottomCell"]) {
        ZStudentMineSettingBottomCell *lcell = (ZStudentMineSettingBottomCell *)cell;
        lcell.titleLabel.font = [UIFont fontContent];
        lcell.titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        lcell.contentView.backgroundColor = HexAColor(0xf4f4f4, 1);
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
          
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
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineRightImageCell className] title:@"phobe" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineRightImageCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
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
    NSArray *tempArr = @[@[@"wechatPay", @"微信", @"selectedCycle"],@[@"alipay", @"支付宝", @"unSelectedCycle"]];
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
    if (self.detailModel.type == ZStudentOrderTypeForPay
        || self.detailModel.type == ZOrganizationOrderTypeForPay
        || self.detailModel.type == ZOrganizationOrderTypeOrderForPay
        || self.detailModel.type == ZStudentOrderTypeOrderForPay
        || self.detailModel.type == ZStudentOrderTypeOutTime
        || self.detailModel.type == ZOrganizationOrderTypeOutTime) {
        tempArr = @[@[@"订单号", SafeStr(self.detailModel.order_no)],@[@"创建时间", SafeStr(self.detailModel.create_at)]];
    }else{
        tempArr = @[@[@"支付方式", [SafeStr(self.detailModel.pay_type) intValue] == 1 ? @"微信":@"支付宝"],@[@"订单号", SafeStr(self.detailModel.order_no)],@[@"创建时间", SafeStr(self.detailModel.create_at)],@[@"付款时间", SafeStr(self.detailModel.pay_time)]];
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
    {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = @"方慧生";
        model.leftImage = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gctegplj2aj30u0187wq5.jpg";
        model.isHiddenLine = YES;
        model.lineLeftMargin = CGFloatIn750(30);
        model.lineRightMargin = CGFloatIn750(30);
        model.cellHeight = CGFloatIn750(84);
        model.leftFont = [UIFont fontSmall];
        model.isHiddenLine = NO;
        
        ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLeftRoundImageCell className] title:[ZSingleLeftRoundImageCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLeftRoundImageCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:bottomCellConfig];
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        {
            NSArray *titleArr = @[@[@"交易金额", @"lessonName",@"",@8,[NSNumber numberWithInt:ZFormatterTypeAny],@NO,@"￥50"],@[@"退款金额",@"lessonIntro",@"填写退款金额",@6,[NSNumber numberWithInt:ZFormatterTypeAny],@YES,@""]];
            
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

                ZCellConfig *nameCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:nameCellConfig];
            }
            
            {
                ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                model.leftTitle = @"交易凭证";
                model.isHiddenLine = YES;
                model.lineLeftMargin = CGFloatIn750(30);
                model.lineRightMargin = CGFloatIn750(30);
                model.cellHeight = CGFloatIn750(62);
                model.leftFont = [UIFont boldFontSmall];
                
                ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:menuCellConfig];
            }
            {
                ZBaseMenuModel *model = [[ZBaseMenuModel alloc] init];
                NSMutableArray *menulist = @[].mutableCopy;

                for (int j = 0; j < 3; j++) {
                    ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
                    model.uid = [NSString stringWithFormat:@"%d", j];
                    model.name = @"必选";
                    [menulist addObject:model];
                }

                model.units = menulist;

                ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonAddPhotosCell className] title:[ZOrganizationLessonAddPhotosCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonAddPhotosCell z_getCellHeight:menulist] cellType:ZCellTypeClass dataModel:model];
                [self.cellConfigArr addObject:progressCellConfig];
                
            }
        }
        NSArray *tempArr = @[@[@"联系人姓名", @"拜拜"],@[@"手机号", @"1882737332"]];
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
        
        {
            ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
            model.isHiddenLine = NO;
            model.lineLeftMargin = CGFloatIn750(30);
            model.lineRightMargin = CGFloatIn750(30);
            model.cellHeight = CGFloatIn750(20);
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [self.cellConfigArr addObject:menuCellConfig];
        }
    }
    
    {
        [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        
        NSArray *titleArr = @[@[@"退款原因",@"代理费公司的感觉哦我机构我就撒机构评价说破大家佛牌靳绥东评价哦赔付搜大家佛牌 "],
                              @[@"退款编号",@"2342390523092342342"],
                              @[@"订单编号",@"2342332232332323323"],
                              @[@"申请时间",@"223333333333333333"]];
        for (int i = 0; i < titleArr.count; i++) {
            if (i == 0) {
                ZBaseMultiseriateCellModel *model = [[ZBaseMultiseriateCellModel alloc] init];
                model.leftTitle = titleArr[i][0];
                model.rightTitle = titleArr[i][1];
                model.isHiddenLine = YES;
                model.cellWidth = KScreenWidth - CGFloatIn750(60);
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
            [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
        }
        
        {
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineOrderDetailCell className] title:[ZMineOrderDetailCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMineOrderDetailCell z_getCellHeight:self.detailModel] cellType:ZCellTypeClass dataModel:self.detailModel];
            [self.cellConfigArr addObject:orderCellConfig];
        }
    }
}

- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = @{@"order_id":SafeStr(self.model.order_id)}.mutableCopy;
    if (self.model) {
        [params setObject:SafeStr(self.model.stores_id) forKey:@"stores_id"];
    }
    [ZOriganizationOrderViewModel getOrderDetail:params completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            weakSelf.detailModel = data;
            weakSelf.detailModel.isStudent = weakSelf.model.isStudent;
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}
@end
