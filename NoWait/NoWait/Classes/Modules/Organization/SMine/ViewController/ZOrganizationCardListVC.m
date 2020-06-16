//
//  ZOrganizationCardListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardListVC.h"
#import "ZOriganizationCartListCell.h"
#import "ZOriganizationCardViewModel.h"
#import "ZOrganizationCardLessonSeeListVC.h"
#import "ZAlertView.h"

@interface ZOrganizationCardListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZOrganizationCardListVC

#pragma mark - vc delegate
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setTableViewGary()
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_updateDataSource(^{
        self.loading = YES;
        self.param = @{}.mutableCopy;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        for (int i = 0; i < self.dataSources.count; i++) {
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationCartListCell className] title:[ZOriganizationCartListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationCartListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.dataSources[i]];

            [self.cellConfigArr addObject:progressCellConfig];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZOriganizationCartListCell"]){
            ZOriganizationCartListCell *enteryCell = (ZOriganizationCartListCell *)cell;
            enteryCell.handleBlock = ^(NSInteger index,ZOriganizationCardListModel *model) {
                if (index == 2) {
                    ZOrganizationCardLessonSeeListVC *svc = [[ZOrganizationCardLessonSeeListVC alloc] init];
                    svc.coupons_id = model.couponsID;
                    if ([model.type intValue] == 1) {
                        svc.isAll = YES;
                        svc.stores_id = model.stores_id;
                    }
                    [weakSelf.navigationController pushViewController:svc animated:YES];
                }else{
                    if ([weakSelf.status intValue] == 1) {
                        [ZAlertView setAlertWithTitle:@"小提醒" subTitle:@"确定停用此卡券吗？" leftBtnTitle:@"取消" rightBtnTitle:@"停用" handlerBlock:^(NSInteger index) {
                            if (index == 1) {
                                [weakSelf handleCard:model];
                            }
                        }];
                    }else{
                        [ZAlertView setAlertWithTitle:@"小提醒" subTitle:@"确定启用此卡券吗？" leftBtnTitle:@"取消" rightBtnTitle:@"启用" handlerBlock:^(NSInteger index) {
                            if (index == 1) {
                                [weakSelf handleCard:model];
                            }
                        }];
                    }
                }
            };
        }
    });
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
    [ZOriganizationCardViewModel getCardList:param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            weakSelf.zChain_reload_ui();
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
    [ZOriganizationCardViewModel getCardList:_param completeBlock:^(BOOL isSuccess, ZOriganizationCardListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            weakSelf.zChain_reload_ui();
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
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [_param setObject:self.status forKey:@"status"];
    [_param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
}

- (void)handleCard:(ZOriganizationCardListModel*)model {
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = @{@"id":model.couponsID}.mutableCopy;
    if ([self.status intValue]  == 1) {
        [params setObject:@"2" forKey:@"status"];
    }else{
        [params setObject:@"1" forKey:@"status"];
    }
    [TLUIUtility showLoading:@""];
    [ZOriganizationCardViewModel deleteCard:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}
@end
