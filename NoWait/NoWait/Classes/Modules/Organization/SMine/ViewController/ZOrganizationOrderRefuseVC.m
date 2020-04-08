//
//  ZOrganizationOrderRefuseVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationOrderRefuseVC.h"
#import "ZStudentMineOrderListCell.h"
#import "ZOrganizationMineOrderDetailVC.h"
#import "ZOriganizationOrderViewModel.h"

@interface ZOrganizationOrderRefuseVC ()
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZOrganizationOrderRefuseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
    
    [self refreshData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOrderListModel *model = self.dataSources[i];
        model.isStudent = self.isStudent;
        model.isRefund = YES;
        
//        model.refund_status = @"1";
//        if (i == 1) {
//            model.refund_status = @"2";
//        }
        
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderListCell className] title:[ZStudentMineOrderListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:orderCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"退款"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

- (void)setDataSource {
    [super setDataSource];
    self.param = @{}.mutableCopy;
    
    [[kNotificationCenter rac_addObserverForName:KNotificationPayBack object:nil] subscribeNext:^(NSNotification *notfication) {
            if (notfication.object && [notfication.object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *backDict = notfication.object;
                if (backDict && [backDict objectForKey:@"payState"]) {
                    if ([backDict[@"payState"] integerValue] == 0) {
                        [self refreshAllData];
                    }else if ([backDict[@"payState"] integerValue] == 1) {
                        if (backDict && [backDict objectForKey:@"msg"]) {
                            [TLUIUtility showAlertWithTitle:@"支付结果" message:backDict[@"msg"]];
                        }
                    }else if ([backDict[@"payState"] integerValue] == 2) {

                    }else if ([backDict[@"payState"] integerValue] == 3) {
                        if (backDict && [backDict objectForKey:@"msg"]) {
                            [TLUIUtility showAlertWithTitle:@"支付结果" message:backDict[@"msg"]];
                        }
                    }
                }
            }
        }];

}

#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    ZStudentMineOrderListCell *enteryCell = (ZStudentMineOrderListCell *)cell;
    enteryCell.handleBlock = ^(NSInteger index, ZOrderListModel *model) {
        [ZOriganizationOrderViewModel handleOrderWithIndex:index data:model completeBlock:^(BOOL isSuccess, id data) {
            if (isSuccess) {
                [TLUIUtility showSuccessHint:data];
                [weakSelf refreshAllData];
            }else{
                [TLUIUtility showErrorHint:data];
            }
        }];
    };
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
    [ZOriganizationOrderViewModel getRefundOrderList:param completeBlock:^(BOOL isSuccess, ZOrderListNetModel *data) {
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
    [ZOriganizationOrderViewModel getRefundOrderList:self.param completeBlock:^(BOOL isSuccess, ZOrderListNetModel *data) {
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
    [_param setObject:[NSString stringWithFormat:@"%d",7] forKey:@"status"];
    if (self.isStudent) {
        [self.param setObject:@"0" forKey:@"type"];
    }else{
        [self.param setObject:@"1" forKey:@"type"];
    }
    
}


@end

