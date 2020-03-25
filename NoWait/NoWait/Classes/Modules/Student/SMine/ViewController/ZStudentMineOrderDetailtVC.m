//
//  ZStudentMineOrderDetailtVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderDetailtVC.h"
#import "ZStudentMineOrderDetailHandleBottomView.h"

#import "ZStudentMineOrderTopStateCell.h"
#import "ZStudentMineOrderDetailCell.h"
#import "ZMultiseriateContentLeftLineCell.h"
#import "ZTableViewListCell.h"
#import "ZStudentMineSettingBottomCell.h"

#import "ZStudentOrderPayVC.h"

@interface ZStudentMineOrderDetailtVC ()
@property (nonatomic,strong) ZStudentMineOrderDetailHandleBottomView *handleView;

@end
@implementation ZStudentMineOrderDetailtVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    self.model.lessonNum = @"10";
    self.model.lessonSignleTime = @"45";
    self.model.lessonTime = @"450";
    self.model.lessonValidity = @"6";
    self.model.lessonFavourable = @"-6";
    self.model.lessonPrice = @"670";
    self.model.payLimit = 6000;
    
    switch (self.model.type) {
        case ZStudentOrderTypeForPay://待付款（去支付，取消）
            {
                [self setTopStateCell];
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
                [self setPayTypeCell];
            }
            break;
            case ZStudentOrderTypeHadPay://已付款（评价，退款，删除）
            {
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
                [self setPayDetailCell];
            }
            break;
            case ZStudentOrderTypeHadEva://完成已评价(删除)
            {
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
                [self setPayDetailCell];
            }
            break;
            case ZStudentOrderTypeOutTime://超时(删除)
            {
                [self setTopHintCell];
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
                [self setPayDetailCell];
            }
            break;
            case ZStudentOrderTypeCancel://已取消(删除)
            {
                [self setTopHintCell];
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
                [self setPayDetailCell];
            }
            break;
//            case ZStudentOrderTypeOrderForPay://待付款（去支付，取消）
//            {
//                [self setTopStateCell];
//                [self setOrderDetailCell];
//                [self setUserCell];
//                [self setOrderPriceCell];
//                [self setPayTypeCell];
//                [self setTipsCell];
//            }
//            break;
//            case ZStudentOrderTypeOrderForReceived://待接收（预约）
//            {
//                [self setTopHintCell];
//                [self setOrderDetailCell];
//                [self setUserCell];
//                [self setOrderPriceCell];
//                [self setPayDetailCell];
//                [self setTipsCell];
//            }
//            break;
//            case ZStudentOrderTypeOrderComplete://已完成（预约，删除）
//            {
//                [self setOrderDetailCell];
//                [self setUserCell];
//                [self setOrderPriceCell];
//                [self setPayDetailCell];
//                [self setTipsCell];
//            }
//            break;
//            case ZStudentOrderTypeOrderRefuse://已拒绝（预约）
//            {
//                [self setTopHintCell];
//                [self setOrderDetailCell];
//                [self setUserCell];
//                [self setOrderPriceCell];
//                [self setPayDetailCell];
//                [self setTipsCell];
//            }
//            break;
//            case ZStudentOrderTypeForRefuse://已拒绝（预约）
//            {
//                [self setOrderDetailCell];
//                [self setUserCell];
//                [self setOrderPriceCell];
//                [self setPayDetailCell];
//            }
//            break;
//            case ZStudentOrderTypeForRefuseComplete://已拒绝（预约）
//            {
//                [self setOrderDetailCell];
//                [self setUserCell];
//                [self setOrderPriceCell];
//                [self setPayDetailCell];
//            }
//            break;
        default:
            break;
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"订单详情"];
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

#pragma mark - lazy loading...
- (ZStudentMineOrderDetailHandleBottomView *)handleView {
    if (!_handleView) {
        __weak typeof(self) weakSelf = self;
        _handleView = [[ZStudentMineOrderDetailHandleBottomView alloc] init];
        _handleView.model = self.model;
        _handleView.handleBlock = ^(ZLessonOrderHandleType type) {
            if (type == ZLessonOrderHandleTypePay) {
                ZStudentOrderPayVC *pvc = [[ZStudentOrderPayVC alloc] init];
                [weakSelf.navigationController pushViewController:pvc animated:YES];
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
           ZStudentMineOrderDetailtVC *evc = [[ZStudentMineOrderDetailtVC alloc] init];
           [self.navigationController pushViewController:evc animated:YES];
       }
}


#pragma mark - set cell
- (void)setTopHintCell {
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:[ZStudentMineSettingBottomCell className] showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(48) cellType:ZCellTypeClass dataModel:self.model.state];
    [self.cellConfigArr addObject:orderCellConfig];
}

- (void)setTopStateCell {
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderTopStateCell className] title:[ZStudentMineOrderTopStateCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderTopStateCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.model];
    [self.cellConfigArr addObject:orderCellConfig];
}


- (void)setOrderDetailCell {
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderDetailCell className] title:[ZStudentMineOrderDetailCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderDetailCell z_getCellHeight:self.model] cellType:ZCellTypeClass dataModel:self.model];
    [self.cellConfigArr addObject:orderCellConfig];
}

- (void)setUserCell {
    NSArray *tempArr = @[@[@"联系人姓名", @"拜拜"],@[@"手机号", @"1882737332"]];
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

- (void)setOrderPriceCell {
    NSArray *tempArr = @[@[@"合计", @"￥320"],@[@"平台优惠", @"-￥3"],@[@"", @"合计订单：320.00"]];
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
    NSArray *tempArr = @[@[@"支付方式", @"微信"],@[@"订单号", @"34235234233"],@[@"创建时间", @"2019.10.21 12:21:22"],@[@"付款时间", @"2019.10.21 12:21:22"]];
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
    NSArray *tempArr = @[@[@"小提醒", @"支付后预约送达噶是的噶施工打三国杀的故事的归属感课程不可手动取消"]];
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

@end


