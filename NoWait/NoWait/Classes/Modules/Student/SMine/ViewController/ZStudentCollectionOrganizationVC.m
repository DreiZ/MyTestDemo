//
//  ZStudentCollectionOrganizationVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentCollectionOrganizationVC.h"

#import "ZStudentOrganizationListCell.h"
#import "ZStudentCollectionViewModel.h"
#import "ZLocationManager.h"
#import "ZAlertView.h"

@interface ZStudentCollectionOrganizationVC ()

@end
@implementation ZStudentCollectionOrganizationVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"机构收藏")
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_updateDataSource(^{
        weakSelf.loading = YES;
    }).zChain_resetMainView(^{
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.view.mas_top).offset(10);
        }];
    });
    
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        for (ZStoresListModel *model in weakSelf.dataSources) {
            model.isStudentCollection = YES;
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationListCell className] title:[ZStudentOrganizationListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:orderCellConfig];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentOrganizationListCell"]){
            ZStudentOrganizationListCell *lcell = (ZStudentOrganizationListCell *)cell;
            lcell.handleBlock = ^(ZStoresListModel *model) {
                [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定取消此机构？" leftBtnTitle:@"不取消" rightBtnTitle:@"取消机构" handlerBlock:^(NSInteger index) {
                    if (index == 1) {
                        [weakSelf collectionStore:NO model:model];
                    }
                }];
            };
            lcell.moreBlock = ^(ZStoresListModel *model) {
                model.isMore = !model.isMore;
                weakSelf.zChain_reload_ui();
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentOrganizationListCell"]) {
            ZStoresListModel *model = cellConfig.dataModel;
            routePushVC(ZRoute_main_organizationDetail, @{@"id":model.stores_id}, nil);
        }
    });
    
    self.zChain_block_setRefreshHeaderNet(^{
        weakSelf.currentPage = 1;
        weakSelf.loading = YES;
        [weakSelf refreshHeadData:[weakSelf setPostCommonData]];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshTableMoreData];
    });
}


#pragma mark - 数据处理
- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZStudentCollectionViewModel getCollectionOrganizationList:param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
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

- (void)refreshTableMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
     [ZStudentCollectionViewModel getCollectionOrganizationList:param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
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
    NSMutableDictionary *param = [self setPostCommonData];
    [param setObject:@"1" forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    [self refreshHeadData:param];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    if ([ZLocationManager shareManager].location) {
        [param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].location.coordinate.longitude] forKey:@"longitude"];
        [param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].location.coordinate.latitude] forKey:@"latitude"];
    }
    return param;
}


- (void)collectionStore:(BOOL)isCollection model:(ZStoresListModel *)model{
    [TLUIUtility showLoading:@""];
    __weak typeof(self) weakSelf = self;
    [ZStudentCollectionViewModel collectionStore:@{@"store":SafeStr(model.stores_id),@"type":isCollection ? @"1":@"2"} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showInfoHint:data];
        }
    }];
}
@end
