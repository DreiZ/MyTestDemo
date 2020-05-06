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

@interface ZReflectMoneyVC ()
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



- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSMutableArray *configArr = @[].mutableCopy;
    {
        [configArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZLineCellModel *model = [[ZLineCellModel alloc] init];
        model.leftTitle = @"提现到支付宝";
        model.cellTitle = @"type";
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(50);
        model.leftFont = [UIFont boldFontContent];

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [configArr addObject:menuCellConfig];
    }
    {
        NSArray *textArr = @[@[@"真实姓名", @"必填", @"name",@"zhang8520322@sina.com",@20,[NSNumber numberWithInt:ZFormatterTypeAny]],
                             @[@"支付宝账号", @"必填", @"account",@"zhang8520322@sina.com",@30,[NSNumber numberWithInt:ZFormatterTypeAny]]];
        
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

            [configArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        }
    }
    
    {
        [configArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
        ZLineCellModel *model = [[ZLineCellModel alloc] init];
        model.leftTitle = @"提现金额";
        model.cellTitle = @"hint";
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(30);
        model.leftFont = [UIFont boldFontContent];

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [configArr addObject:menuCellConfig];
    }
    {
        ZBaseTextFieldCellModel *cellModel = [[ZBaseTextFieldCellModel alloc] init];
        cellModel.leftTitle = @"￥";
        cellModel.placeholder = @"0";
        cellModel.cellTitle = @"money";
        cellModel.content = @"";
        cellModel.max = 10;
        cellModel.formatterType = ZFormatterTypeNumber;
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
        ZLineCellModel *model = [[ZLineCellModel alloc] init];
        model.leftTitle = @"可提现余额";
        model.cellTitle = @"lest";
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(100);
        model.leftFont = [UIFont fontSmall];
        model.leftColor = [UIColor colorTextGray];
        model.leftDarkColor = [UIColor colorTextGrayDark];

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
            }
            
            
        };
    }
}
@end
