//
//  ZRewardMyTeamListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardMyTeamListVC.h"
#import "ZRewardMyTeamListCell.h"
#import "ZRewardCenterViewModel.h"
#import "ZRewardModel.h"

@interface ZRewardMyTeamListVC ()

@end

@implementation ZRewardMyTeamListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewEmptyDataDelegate];
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self refreshData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"我的团队"];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self.dataSources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZRewardMyTeamListCell className] title:@"ZRewardMyTeamListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZRewardMyTeamListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
        
        [self.cellConfigArr addObject:menuCellConfig];
    }];
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZRewardCenterViewModel rewardTeamList:param completeBlock:^(BOOL isSuccess, ZRewardTeamModel *data) {
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
     [ZRewardCenterViewModel rewardTeamList:param completeBlock:^(BOOL isSuccess, ZRewardTeamModel *data) {
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
@end
