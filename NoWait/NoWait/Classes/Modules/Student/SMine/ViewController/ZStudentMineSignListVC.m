//
//  ZStudentMineSignListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignListVC.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentMineSignListCell.h"

#import "ZStudentMineSignDetailVC.h"

@interface ZStudentMineSignListVC ()

@end
@implementation ZStudentMineSignListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSignListCell className] title:[ZStudentMineSignListCell className] showInfoMethod:nil heightOfCell:[ZStudentMineSignListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:orderCellConfig];
    [self.cellConfigArr addObject:orderCellConfig];
    [self.cellConfigArr addObject:orderCellConfig];
    [self.cellConfigArr addObject:orderCellConfig];
    [self.cellConfigArr addObject:orderCellConfig];
    [self.cellConfigArr addObject:orderCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员签课"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMineSignListCell"]){
        ZStudentMineSignListCell *enteryCell = (ZStudentMineSignListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger type) {
            ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
            
            [self.navigationController pushViewController:dvc animated:YES];
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZStudentMineSignListCell"]){
         ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
         
         [self.navigationController pushViewController:dvc animated:YES];
    }
}

@end
