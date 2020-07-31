//
//  ZOrganizationSchoolAccountDetailListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSchoolAccountDetailListVC.h"
#import "ZOrganizationAccountSchoolListCell.h"

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


#pragma mark - RouteHandler
@interface ZOrganizationSchoolAccountDetailListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationSchoolAccountDetailListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_schoolAccountList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationSchoolAccountDetailListVC *routevc = [[ZOrganizationSchoolAccountDetailListVC alloc] init];
    if (request.prts) {
        routevc.model = request.prts;
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
