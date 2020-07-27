//
//  ZStudentMineSignListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSignListVC.h"

#import "ZAlertQRCodeView.h"
#import "ZStudentMineSignListCell.h"

#import "ZStudentMineSignDetailVC.h"
#import "ZOriganizationClassViewModel.h"

@interface ZStudentMineSignListVC ()

@end
@implementation ZStudentMineSignListVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (ZOriganizationClassListModel *model in self.dataSources) {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSignListCell className] title:[ZStudentMineSignListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineSignListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:orderCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"我的签课"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
    [self setTableViewGaryBack];
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMineSignListCell"]){
        ZStudentMineSignListCell *enteryCell = (ZStudentMineSignListCell *)cell;
        enteryCell.handleBlock = ^(ZOriganizationClassListModel *model) {
            ZOriganizationClassListModel *cellmodel = cellConfig.dataModel;
            ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
//            dvc.type = 0;
            dvc.courses_class_id = cellmodel.courses_class_id;
            dvc.student_id = cellmodel.student_id;
            [self.navigationController pushViewController:dvc animated:YES];
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZStudentMineSignListCell"]){
         ZOriganizationClassListModel *cellmodel = cellConfig.dataModel;
         ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
//         dvc.type = 0;
         dvc.courses_class_id = cellmodel.courses_class_id;
         dvc.student_id = cellmodel.student_id;
         [self.navigationController pushViewController:dvc animated:YES];
    }
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getMyClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
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
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
     [ZOriganizationClassViewModel getMyClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
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
    NSMutableDictionary *param = [self setPostCommonData];
    [param setObject:@"1" forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    [self refreshHeadData:param];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    return param;
}

- (void)getSignQrcode:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getSignQrcode:param completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            ZOriganizationStudentCodeAddModel *model = data;
            [ZAlertQRCodeView setAlertWithTitle:@"请教师扫码完成签课" qrCode:model.url handlerBlock:^(NSInteger index) {
                
            }];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}
@end

#pragma mark - RouteHandler
@interface ZStudentMineSignListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentMineSignListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_mine_signList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentMineSignListVC *routevc = [[ZStudentMineSignListVC alloc] init];
    
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
