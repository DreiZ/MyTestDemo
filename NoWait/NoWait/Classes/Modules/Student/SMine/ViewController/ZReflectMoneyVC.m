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

@interface ZReflectMoneyVC ()
@property (nonatomic,strong) ZRewardReflectHandleModel *handleModel;
@property (nonatomic,strong) ZBaseLineCell *hintCell;

@end

@implementation ZReflectMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self setTableViewGaryBack];
}


- (void)setNavigation {
    [self.navigationItem setTitle:@"提现"];
}

- (void)setDataSource {
    [super setDataSource];
    _handleModel = [[ZRewardReflectHandleModel alloc] init];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSMutableArray *configArr = @[].mutableCopy;
    {
        {
            ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor(HexAColor(0xf8f8f8,1.0), HexAColor(0x1c1c1c,1.0))];
            [configArr addObject:cellConfig];
        }
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"type")
        .titleLeft(@"提现到支付宝")
        .lineHidden(YES)
        .height(CGFloatIn750(50))
        .fontLeft([UIFont boldFontContent]);
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [configArr addObject:menuCellConfig];
    }
    {
        NSArray *textArr = @[@[@"真实姓名", @"必填", @"name",SafeStr(self.handleModel.realName),@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                             @[@"支付宝账号", @"必填", @"account",SafeStr(self.handleModel.aliPay),@30,[NSNumber numberWithInt:ZFormatterTypeAny]]];
        
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

            {
                ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor(HexAColor(0xf8f8f8,1.0), HexAColor(0x1c1c1c,1.0))];
                [configArr addObject:cellConfig];
            }
        }
    }
    
    {
        [configArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"hint")
        .titleLeft(@"提现金额")
        .lineHidden(YES)
        .height(CGFloatIn750(30))
        .fontLeft([UIFont boldFontContent]);
   
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [configArr addObject:menuCellConfig];
    }
    {
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = @"￥";
        cellModel.placeholder = @"0";
        cellModel.cellTitle = @"money";
        cellModel.content = SafeStr(self.handleModel.amount);
        cellModel.max = 10;
        cellModel.formatterType = ZFormatterTypeDecimal;
        cellModel.isHiddenLine = NO;
        cellModel.cellHeight = CGFloatIn750(180);
        cellModel.leftFont = [UIFont boldSystemFontOfSize:CGFloatIn750(60)];
        cellModel.textFont = [UIFont boldSystemFontOfSize:CGFloatIn750(60)];
        cellModel.textAlignment = NSTextAlignmentLeft;
        cellModel.leftContentWidth = CGFloatIn750(60);
        
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZTextFieldCell className] title:cellModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZTextFieldCell z_getCellHeight:cellModel] cellType:ZCellTypeClass dataModel:cellModel];
        [configArr addObject:textCellConfig];
        
    }
    
    {
        [configArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"last")
        .lineHidden(YES)
        .height(CGFloatIn750(100))
        .fontLeft([UIFont fontSmall]);
        
        NSString *hintStr = [NSString stringWithFormat:@"可提现余额%.2f",[self.infoModel.cash_out_amount doubleValue]];
        if ([self.infoModel.cash_out_amount doubleValue] < [SafeStr(self.handleModel.amount) doubleValue]) {
            hintStr = @"超出可提现金额";
            
            model.colorLeft([UIColor colorRedDefault]).colorDarkLeft([UIColor colorRedDefault]).titleLeft(hintStr);
        }else{
            model.colorLeft([UIColor colorTextGray]).colorDarkLeft([UIColor colorTextGrayDark]).titleLeft(hintStr);
        }

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [configArr addObject:menuCellConfig];
    }
    
    {
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardMoneyBottomBtnCell className] title:[ZRewardMoneyBottomBtnCell className] showInfoMethod:nil heightOfCell:[ZRewardMoneyBottomBtnCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];

        [configArr addObject:menuCellConfig];
        
    }
    
    ZCellConfig *bottomCellConfig = [ZCellConfig cellConfigWithClassName:[ZTableViewListCell className] title:[ZTableViewListCell className] showInfoMethod:@selector(setConfigList:) heightOfCell:[ZTableViewListCell z_getCellHeight:configArr] cellType:ZCellTypeClass dataModel:configArr];
    [self.cellConfigArr addObject:bottomCellConfig];
}

#pragma mark - tableview datasource
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZTableViewListCell"]) {
        ZTableViewListCell *lcell = (ZTableViewListCell *)cell;
        lcell.contView.backgroundColor = adaptAndDarkColor(HexAColor(0xf8f8f8,1.0), HexAColor(0x1c1c1c,1.0));
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
                    .lineHidden(YES)
                    .height(CGFloatIn750(100))
                    .fontLeft([UIFont fontSmall]);
                    
                    NSString *hintStr = [NSString stringWithFormat:@"可提现余额%.2f",[self.infoModel.cash_out_amount doubleValue]];
                    if ([self.infoModel.cash_out_amount doubleValue] < [SafeStr(self.handleModel.amount) doubleValue]) {
                        hintStr = @"超出可提现金额";
                        
                        model.colorLeft([UIColor colorRedDefault]).colorDarkLeft([UIColor colorRedDefault]).titleLeft(hintStr);
                    }else{
                        model.colorLeft([UIColor colorTextGray]).colorDarkLeft([UIColor colorTextGrayDark]).titleLeft(hintStr);
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
}

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
    
    [TLUIUtility showLoading:@"提交中..."];
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.handleModel.realName forKey:@"name"];
    [param setObject:self.handleModel.amount forKey:@"amount"];
    [param setObject:self.handleModel.aliPay forKey:@"phone"];
    [ZRewardCenterViewModel refectMoney:param completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [TLUIUtility showErrorHint:data];
        }
    } ];
}
@end
