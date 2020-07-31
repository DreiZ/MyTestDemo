//
//  ZReflectMoneyVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZReflectMoneyVC.h"
#import "ZTableViewListCell.h"
#import "ZBaseLineCell.h"
#import "ZRewardMoneyBottomBtnCell.h"
#import "ZRewardModel.h"
#import "ZRewardCenterViewModel.h"

#import "ZAlertView.h"

@interface ZReflectMoneyVC ()
@property (nonatomic,strong) ZRewardReflectHandleModel *handleModel;
@property (nonatomic,strong) ZBaseLineCell *hintCell;

@end

@implementation ZReflectMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"提现").zChain_setTableViewGary();
    self.zChain_updateDataSource(^{
        weakSelf.handleModel = [[ZRewardReflectHandleModel alloc] init];
        weakSelf.handleModel.realName = weakSelf.infoModel.real_name;
        weakSelf.handleModel.aliPay = weakSelf.infoModel.alipay;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];

         NSMutableArray *configArr = @[].mutableCopy;
         {
             ZCellConfig *lineCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor(HexAColor(0xf8f8f8,1.0), HexAColor(0x1c1c1c,1.0))];
             [configArr addObject:lineCellConfig];
             
             ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"type")
             .zz_titleLeft(@"提现到支付宝")
             .zz_lineHidden(YES)
             .zz_cellHeight(CGFloatIn750(50))
             .zz_fontLeft([UIFont boldFontContent]);
             
             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

             [configArr addObject:menuCellConfig];
         }
         {
             NSArray *textArr = @[@[@"真实姓名", @"必填", @"name",SafeStr(weakSelf.handleModel.realName),@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                                  @[@"支付宝账号", @"必填", @"account",SafeStr(weakSelf.handleModel.aliPay),@30,[NSNumber numberWithInt:ZFormatterTypeAny]]];
             
             for (int i = 0; i < textArr.count; i++) {
                 ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
                 cellModel.leftTitle = textArr[i][0];
                 cellModel.placeholder = textArr[i][1];
                 cellModel.cellTitle = textArr[i][2];
                 cellModel.content = textArr[i][3];
                 cellModel.max = [textArr[i][4] intValue];
                 cellModel.formatterType = [textArr[i][5] intValue];
                 cellModel.isHiddenLine = YES;
                 cellModel.cellHeight = CGFloatIn750(80);
                 cellModel.leftFont = [UIFont fontContent];
                 cellModel.textFont = [UIFont fontContent];
                 cellModel.textAlignment = NSTextAlignmentLeft;
                 cellModel.leftContentWidth = CGFloatIn750(160);
                 
                 
                 ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
                 [configArr addObject:textCellConfig];

                 ZCellConfig *lineCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor(HexAColor(0xf8f8f8,1.0), HexAColor(0x1c1c1c,1.0))];
                 [configArr addObject:lineCellConfig];
             }
         }
         
         {
             [configArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
             ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"hint")
             .zz_titleLeft(@"提现金额")
             .zz_lineHidden(YES)
             .zz_cellHeight(CGFloatIn750(30))
             .zz_fontLeft([UIFont boldFontContent]);
        
             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

             [configArr addObject:menuCellConfig];
         }
         {
             ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
             cellModel.leftTitle = @"￥";
             cellModel.placeholder = @"0";
             cellModel.cellTitle = @"money";
             cellModel.content = SafeStr(weakSelf.handleModel.amount);
             cellModel.max = 10;
             cellModel.formatterType = ZFormatterTypeDecimal;
             cellModel.isHiddenLine = YES;
             cellModel.cellHeight = CGFloatIn750(180);
             cellModel.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(60)];
             cellModel.textFont = [UIFont boldSystemFontOfSize:CGFloatIn750(60)];
             cellModel.textAlignment = NSTextAlignmentLeft;
             cellModel.leftContentWidth = CGFloatIn750(60);
             
             ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
             [configArr addObject:textCellConfig];
         }
         
         {
             ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"line")
             .zz_lineHidden(NO)
             .zz_marginLineLeft(CGFloatIn750(50))
             .zz_marginLineRight(CGFloatIn750(50))
             .zz_cellHeight(CGFloatIn750(2));
             
             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
             [configArr addObject:menuCellConfig];
         }
         
         {
             ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"last")
             .zz_lineHidden(YES)
             .zz_cellHeight(CGFloatIn750(100))
             .zz_fontLeft([UIFont fontSmall]);
             
             NSString *hintStr = [NSString stringWithFormat:@"剩余可提现余额%.2f",[weakSelf.infoModel.cash_out_amount doubleValue]];
             if ([weakSelf.infoModel.cash_out_amount doubleValue] < [SafeStr(weakSelf.handleModel.amount) doubleValue]) {
                 hintStr = @"超出可提现金额";
                 
                 model.zz_colorLeft([UIColor colorRedDefault]).zz_colorDarkLeft([UIColor colorRedDefault]).zz_titleLeft(hintStr);
             }else{
                 model.zz_colorLeft([UIColor colorTextGray]).zz_colorDarkLeft([UIColor colorTextGrayDark]).zz_titleLeft(hintStr);
             }

             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

             [configArr addObject:menuCellConfig];
         }
         
         {
             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardMoneyBottomBtnCell className] title:[ZRewardMoneyBottomBtnCell className] showInfoMethod:nil heightOfCell:[ZRewardMoneyBottomBtnCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];

             [configArr addObject:menuCellConfig];
         }
         
         ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
         [weakSelf.cellConfigArr addObject:bottomCellConfig];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]) {
            ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
            lcell.contTopView.hidden = NO;
            lcell.contBottomView.hidden = NO;
            lcell.contTopView.backgroundColor = adaptAndDarkColor(HexAColor(0xf8f8f8,1.0), HexAColor(0x1c1c1c,1.0));
            lcell.handleBlock = ^(ZCellConfig * lcellConfig) {
                
            };
            lcell.cellSetBlock = ^(UITableViewCell *lcell, NSIndexPath *index, ZCellConfig *lcellConfig) {
                if ([lcellConfig.title isEqualToString:@"type"]) {
                    lcell.contentView.backgroundColor = adaptAndDarkColor(HexAColor(0xf8f8f8,1.0), HexAColor(0x1c1c1c,1.0));
                }else if ([lcellConfig.title isEqualToString:@"name"] || [lcellConfig.title isEqualToString:@"account"]) {
                    lcell.contentView.backgroundColor = adaptAndDarkColor(HexAColor(0xf8f8f8,1.0), HexAColor(0x1c1c1c,1.0));
                    if ([lcellConfig.title isEqualToString:@"name"]) {
                        ZTextFieldCell *tcell = (ZTextFieldCell *)lcell;
                        tcell.valueChangeBlock = ^(NSString * text) {
                            weakSelf.handleModel.realName = text;
                        };
                    }else if ([lcellConfig.title isEqualToString:@"account"]) {
                        ZTextFieldCell *tcell = (ZTextFieldCell *)lcell;
                        tcell.valueChangeBlock = ^(NSString * text) {
                            weakSelf.handleModel.aliPay = text;
                        };
                    }
                }else if ([lcellConfig.title isEqualToString:@"money"]){
                    ZTextFieldCell *tcell = (ZTextFieldCell *)lcell;
                    tcell.valueChangeBlock = ^(NSString * text) {
                        weakSelf.handleModel.amount = text;
                        
                       ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"last")
                        .zz_lineHidden(YES)
                        .zz_cellHeight(CGFloatIn750(100))
                        .zz_fontLeft([UIFont fontSmall]);
                        
                        NSString *hintStr = [NSString stringWithFormat:@"可提现余额%.2f",[weakSelf.infoModel.cash_out_amount doubleValue]];
                        if ([weakSelf.infoModel.cash_out_amount doubleValue] < [SafeStr(weakSelf.handleModel.amount) doubleValue]) {
                            hintStr = @"超出可提现金额";
                            
                            model.zz_colorLeft([UIColor colorRedDefault]).zz_colorDarkLeft([UIColor colorRedDefault]).zz_titleLeft(hintStr);
                        }else{
                            model.zz_colorLeft([UIColor colorTextGray]).zz_colorDarkLeft([UIColor colorTextGrayDark]).zz_titleLeft(hintStr);
                        }
                        
                        if (weakSelf.hintCell) {
                            weakSelf.hintCell.model = model;
                        }
                    };
                }else if ([lcellConfig.title isEqualToString:@"last"]){
                    weakSelf.hintCell = (ZBaseLineCell *)lcell;
                }else if ([lcellConfig.title isEqualToString:@"ZRewardMoneyBottomBtnCell"]){
                    ZRewardMoneyBottomBtnCell *bcell = (ZRewardMoneyBottomBtnCell *)lcell;
                    bcell.handleBlock = ^(NSInteger index) {
                        [weakSelf handelReflect];
                    };
                }
            };
        }
    });
    
    self.zChain_reload_ui();
}

#pragma mark - tableview datasource
- (void)handelReflect {
    [self.iTableView endEditing:YES];
    if (!ValidStr(self.handleModel.realName)) {
        [TLUIUtility showErrorHint:@"请填写真实姓名"];
        return;
    }
    
    if (!ValidStr(self.handleModel.aliPay)) {
        [TLUIUtility showErrorHint:@"请填写支付宝账号"];
        return;
    }
    
    if (!ValidStr(self.handleModel.amount)) {
        [TLUIUtility showErrorHint:@"请填写提现金额"];
        return;
    }
    
    if ([self.infoModel.cash_out_amount doubleValue] < [SafeStr(self.handleModel.amount) doubleValue]) {
        [TLUIUtility showErrorHint:@"超出可提现金额"];
        return;
    }
    if ([SafeStr(self.handleModel.amount) doubleValue] < 0.1) {
        [TLUIUtility showErrorHint:@"最低可提现金不得少于0.1元"];
        return;
        
    }
    
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@"提交中..."];
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.handleModel.realName forKey:@"name"];
    [param setObject:self.handleModel.amount forKey:@"amount"];
    [param setObject:self.handleModel.aliPay forKey:@"phone"];
    [ZRewardCenterViewModel refectMoney:param completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [ZAlertView setAlertWithTitle:@"提现成功" subTitle:data btnTitle:@"我知道了" handlerBlock:^(NSInteger index) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }else {
            [TLUIUtility showErrorHint:data];
        }
    } ];
}
@end

#pragma mark - RouteHandler
@interface ZReflectMoneyVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZReflectMoneyVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_reflectMoney;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZReflectMoneyVC *routevc = [[ZReflectMoneyVC alloc] init];
    if (request.prts) {
        routevc.infoModel = request.prts;
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
