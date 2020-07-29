//
//  ZOrganizationMineEvaListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineEvaListVC.h"
#import "ZOrganizationEvaListCell.h"
#import "ZOriganizationOrderViewModel.h"

@interface ZOrganizationMineEvaListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;

@end
@implementation ZOrganizationMineEvaListVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
//    [self setNavigation];
    [self initCellConfigArr];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationEvaListCell className] title:[ZOrganizationEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationEvaListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:evaCellConfig];
    }
    
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"评价管理"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}
- (NSMutableDictionary *)param {
    if (!_param) {
        _param = @{}.mutableCopy;
    }
    return _param;
}
#pragma mark lazy loading...
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListCell"]){
        ZOrganizationEvaListCell *enteryCell = (ZOrganizationEvaListCell *)cell;
        enteryCell.evaBlock = ^(NSInteger index) {
            routePushVC(ZRoute_org_evaDetail, cellConfig.dataModel, nil);
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListCell"]) {
        routePushVC(ZRoute_org_evaDetail, self.dataSources[indexPath.row], nil);
    }
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:_param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationOrderViewModel getMerchantsCommentListList:param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationOrderViewModel getMerchantsCommentListList:self.param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iTableView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iTableView tt_endLoadMore];
            }
        }else{
            [weakSelf.iTableView reloadData];
            [weakSelf.iTableView tt_endRefreshing];
            [weakSelf.iTableView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.replyType] forKey:@"is_reply"];
}
@end

#pragma mark - RouteHandler
@interface ZOrganizationMineEvaListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationMineEvaListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_addLabel;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationMineEvaListVC *routevc = [[ZOrganizationMineEvaListVC alloc] init];
    if (request.prts) {
        routevc.replyType = [request.prts intValue];
    }
    
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
