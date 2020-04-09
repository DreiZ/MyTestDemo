//
//  ZOrganizationSchoolAccountDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountDetailVC.h"
#import "ZOrganizationAccountSchoolListCell.h"

@interface ZOrganizationSchoolAccountDetailVC ()

@end

@implementation ZOrganizationSchoolAccountDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolListCell className] title:[ZOrganizationAccountSchoolListCell className] showInfoMethod:nil heightOfCell:[ZOrganizationAccountSchoolListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:topCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"详情"];//已打款详情
}


@end

