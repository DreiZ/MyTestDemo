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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    [self setTableViewEmptyDataDelegate];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolListCell className] title:[ZOrganizationAccountSchoolListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationAccountSchoolListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.model];
    [self.cellConfigArr addObject:topCellConfig];
    [self.cellConfigArr addObject:getEmptyCellWithHeight(CGFloatIn750(20))];
    
    [self.model.logs enumerateObjectsUsingBlock:^(ZStoresAccountDetaliListLogModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationAccountSchoolListLogsCell className] title:[ZOrganizationAccountSchoolListLogsCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationAccountSchoolListLogsCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
//        [self.cellConfigArr addObject:topCellConfig];
        
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = obj.money;
        model.rightTitle = obj.created_at;
        model.isHiddenLine = YES;
        model.cellHeight = CGFloatIn750(96);
        model.leftFont = [UIFont fontContent];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }];
    
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"打款明细"];//已打款详情
}

@end


