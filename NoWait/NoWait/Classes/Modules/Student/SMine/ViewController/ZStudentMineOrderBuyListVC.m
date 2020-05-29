//
//  ZStudentMineOrderBuyListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderBuyListVC.h"

#import "ZStudentMineOrderListCell.h"
#import "ZOrganizationMineOrderDetailVC.h"
#import "ZOriganizationOrderViewModel.h"

#import "ZStudentMineEvaEditVC.h"
#import "ZStudentOrganizationDetailDesVC.h"

@interface ZStudentMineOrderBuyListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZStudentMineOrderBuyListVC

-(void)viewDidAppear:(BOOL)animated {
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
        ZOrderListModel *model = self.dataSources[i];
        model.isStudent = YES;
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
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
        ZStudentMineOrderListCell *enteryCell = (ZStudentMineOrderListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index, ZOrderListModel *model) {
            if (index == ZLessonOrderHandleTypeEva) {
                ZStudentMineEvaEditVC *evc = [[ZStudentMineEvaEditVC alloc] init];
                evc.listModel = model;
                [self.navigationController pushViewController:evc animated:YES];
            }else if (index == 100){
                ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
                ZStoresListModel *lmodel = [[ZStoresListModel alloc] init];
                lmodel.stores_id = model.stores_id;
                lmodel.name = model.stores_name;
                dvc.listModel = lmodel;
                [self.navigationController pushViewController:dvc animated:YES];
            }else{
                [ZOriganizationOrderViewModel handleOrderWithIndex:index data:model completeBlock:^(BOOL isSuccess, id data) {
                    if (isSuccess) {
                        [TLUIUtility showSuccessHint:data];
                        [weakSelf refreshData];
                    }else{
                        [TLUIUtility showErrorHint:data];
                    }
                }];
            }
//            ZOrganizationMineOrderDetailVC *evc = [[ZOrganizationMineOrderDetailVC alloc] init];
//            [self.navigationController pushViewController:evc animated:YES];
        };
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
    [ZOriganizationOrderViewModel getOrderList:param completeBlock:^(BOOL isSuccess, ZOrderListNetModel *data) {
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
    [ZOriganizationOrderViewModel getOrderList:self.param completeBlock:^(BOOL isSuccess, ZOrderListNetModel *data) {
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
    
    switch (self.type) {
        case ZStudentOrderTypeAll:
            //全部
            [_param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"status"];
            break;
        case ZStudentOrderTypeForPay:
            //@"待支付";
//            [_param setObject:@"7" forKey:@"status"];
            [_param setObject:@"1" forKey:@"status"];
            break;
        case ZStudentOrderTypeHadPay:
            //待评价
//            [_param setObject:@"8" forKey:@"status"];
            [_param setObject:@"2" forKey:@"status"];
            break;
        case ZStudentOrderTypeHadEva:
            //已完成
            [_param setObject:@"3" forKey:@"status"];
            break;
        default:
            break;
    }
//    [self.param setObject:@"0" forKey:@"type"];
}

@end

