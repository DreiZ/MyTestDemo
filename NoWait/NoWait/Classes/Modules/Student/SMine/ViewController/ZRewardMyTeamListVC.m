//
//  ZRewardMyTeamListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardMyTeamListVC.h"
#import "ZRewardMyTeamListCell.h"

@interface ZRewardMyTeamListVC ()

@end

@implementation ZRewardMyTeamListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"我的团队"];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardMyTeamListCell className] title:@"ZRewardMyTeamListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZRewardMyTeamListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];

    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    [self.cellConfigArr addObject:menuCellConfig];
    
}
@end
