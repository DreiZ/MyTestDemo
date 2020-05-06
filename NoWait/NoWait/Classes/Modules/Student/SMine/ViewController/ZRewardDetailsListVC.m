//
//  ZRewardDetailsListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardDetailsListVC.h"
#import "ZRewardDetailsListCell.h"

@interface ZRewardDetailsListVC ()

@end

@implementation ZRewardDetailsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)setNavigation {
    [self.navigationItem setTitle:@"奖励明细"];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardDetailsListCell className] title:@"ZRewardDetailsListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZRewardDetailsListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];

    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    
}
@end
