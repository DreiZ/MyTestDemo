//
//  ZOrganizationMineOrderListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineOrderListVC.h"

#import "ZStudentMineOrderListCell.h"
#import "ZOrganizationMineOrderDetailVC.h"
#import "ZOriganizationOrderViewModel.h"

@interface ZOrganizationMineOrderListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,assign) NSInteger tt;
@end

@implementation ZOrganizationMineOrderListVC


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _tt = 1;
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOrderListModel *model = self.dataSources[i];
        model.isStudent = NO;
        model.orderType = @"1";
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderListCell className] title:[ZStudentMineOrderListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:orderCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"订单"];
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

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
        ZStudentMineOrderListCell *enteryCell = (ZStudentMineOrderListCell *)cell;
//        enteryCell.handleBlock = ^(NSInteger index, ZStudentOrderListModel *model) {
//            ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
//            [self.navigationController pushViewController:evc animated:YES];
//        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
        ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
        evc.model = cellConfig.dataModel;
        [self.navigationController pushViewController:evc animated:YES];
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
    [ZOriganizationOrderViewModel getOrderList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    [ZOriganizationOrderViewModel getOrderList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    
    switch (self.type) {
        case ZOrganizationOrderTypeAll:
            //全部
            [_param setObject:[NSString stringWithFormat:@"%ld",_tt] forKey:@"status"];
            break;
        case ZOrganizationOrderTypeForPay:
            //@"待支付";
            [_param setObject:@"1" forKey:@"status"];
            break;
        case ZOrganizationOrderTypeOrderForReceived:
            //预约待支付
            [_param setObject:@"4" forKey:@"status"];
            break;
        case ZStudentOrderTypeHadEva:
            //已完成
            [_param setObject:@"12" forKey:@"status"];
            break;
        default:
            break;
    }
    [self.param setObject:@"1" forKey:@"type"];
    _tt++;
}

@end
