//
//  ZOrganizationSchoolAccountDetailListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountDetailListVC.h"
#import "ZOrganizationAccountSchoolListCell.h"
#import "ZOrganizationAccountSchoolListLogsCell.h"

@interface ZOrganizationSchoolAccountDetailListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZOrganizationSchoolAccountDetailListVC

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    [self setTableViewEmptyDataDelegate];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolListCell className] title:[ZOrganizationAccountSchoolListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationAccountSchoolListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.model];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(40))];
    [self.model.logs enumerateObjectsUsingBlock:^(ZStoresAccountDetaliListLogModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolListLogsCell className] title:[ZOrganizationAccountSchoolListLogsCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationAccountSchoolListLogsCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
        [self.cellConfigArr addObject:topCellConfig];
    }];
    
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"打开明细"];//已打款详情
}

@end


