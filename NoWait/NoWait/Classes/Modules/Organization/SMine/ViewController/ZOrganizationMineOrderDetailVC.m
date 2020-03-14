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

@interface ZOrganizationMineOrderDetailVC ()
@property (nonatomic,strong) ZStudentMineOrderDetailHandleBottomView *handleView;

@end
@implementation ZOrganizationMineOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
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
        case ZOrganizationOrderTypeForPay://待付款（去支付，取消）
            ;
        case ZStudentOrderTypeForPay://待付款（去支付，取消）
            {
                [self setTopStateCell];
                [self setOrderDetailCell];
                [self setUserCell];
                [self setOrderPriceCell];
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
            model.rightColor = [UIColor colorMain];
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
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
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
                model.rightColor = [UIColor colorMain];
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
        ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
        [self.cellConfigArr addObject:coachSpaceCellConfig];
        
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
            
            ZCellConfig *coachSpaceCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(40) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
            [self.cellConfigArr addObject:coachSpaceCellConfig];
        }
        
        {
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineOrderDetailCell className] title:[ZMineOrderDetailCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMineOrderDetailCell z_getCellHeight:self.model] cellType:ZCellTypeClass dataModel:self.model];
            [self.cellConfigArr addObject:orderCellConfig];
        }
    }
    
}
@end



