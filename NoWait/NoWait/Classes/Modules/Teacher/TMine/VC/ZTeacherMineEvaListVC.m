//
//  ZTeacherMineEvaListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineEvaListVC.h"
#import "ZOrganizationMineEvaDetailVC.h"
#import "ZOrganizationEvaListCell.h"
#import "ZOriganizationOrderViewModel.h"

@interface ZTeacherMineEvaListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;

@end
@implementation ZTeacherMineEvaListVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self setTableViewGaryBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOrderEvaListModel *model = self.dataSources[i];
        model.isTeacher = YES;
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
        make.top.equalTo(self.view.mas_top).offset(10);
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
            ZOrganizationMineEvaDetailVC *dvc = [[ZOrganizationMineEvaDetailVC alloc] init];
            dvc.listModel = cellConfig.dataModel;
            [self.navigationController pushViewController:dvc animated:YES];
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationEvaListCell"]) {
        ZOrganizationMineEvaDetailVC *dvc = [[ZOrganizationMineEvaDetailVC alloc] init];
        dvc.listModel = self.dataSources[indexPath.row];
        [self.navigationController pushViewController:dvc animated:YES];
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
    [ZOriganizationOrderViewModel getTeacherCommentListList:param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
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
    [ZOriganizationOrderViewModel getTeacherCommentListList:self.param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
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
    [self.param setObject:SafeStr([ZUserHelper sharedHelper].stores.stores_id) forKey:@"stores_id"];
    [self.param setObject:SafeStr([ZUserHelper sharedHelper].stores.teacher_id) forKey:@"teacher_id"];
}
@end

#pragma mark - RouteHandler
@interface ZTeacherMineEvaListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZTeacherMineEvaListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_teacherEvaList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZTeacherMineEvaListVC *routevc = [[ZTeacherMineEvaListVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
