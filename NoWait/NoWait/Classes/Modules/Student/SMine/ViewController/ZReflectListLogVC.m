//
//  ZReflectListLogVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZReflectListLogVC.h"
#import "ZReflectListLogCell.h"
@interface ZReflectListLogVC ()

@end

@implementation ZReflectListLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)setNavigation {
    [self.navigationItem setTitle:@"提现记录"];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZReflectListLogCell className] title:@"ZReflectListLogCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZReflectListLogCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];

    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    
}
@end
