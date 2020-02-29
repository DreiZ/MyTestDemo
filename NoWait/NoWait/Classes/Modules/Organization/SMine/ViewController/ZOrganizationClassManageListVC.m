//
//  ZOrganizationClassManageListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassManageListVC.h"
#import "ZOrganizationClassManageListCell.h"
#import "ZAlertView.h"

#import "ZOrganizationClassManageDetailVC.h"

@interface ZOrganizationClassManageListVC ()

@end

@implementation ZOrganizationClassManageListVC

#pragma mark vc delegate-------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    [self initCellConfigArr];
}

#pragma mark - setdata mainview
- (void)setupMainView {
    
    [super setupMainView];
    
    self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationClassManageListCell className] title:[ZOrganizationClassManageListCell className] showInfoMethod:nil heightOfCell:[ZOrganizationClassManageListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"课程列表"];
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
       if ([cellConfig.title isEqualToString:@"ZOrganizationClassManageListCell"]) {
           ZOrganizationClassManageDetailVC *dvc = [[ZOrganizationClassManageDetailVC alloc] init];
           if (indexPath.row % 2 == 1) {
               dvc.isOpen = YES;
           }
           [self.navigationController pushViewController:dvc animated:YES];
       }else if ([cellConfig.title isEqualToString:@"address"]){
          
       }
}

@end
