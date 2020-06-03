//
//  ZReflectListLogVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZReflectListLogVC.h"
#import "ZReflectListLogCell.h"
#import "ZRewardCenterViewModel.h"
#import "ZRewardModel.h"

@interface ZReflectListLogVC ()

@end

@implementation ZReflectListLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.setNavTitle(@"提现记录").setEmptyDataDelegate()
    .setRefreshHeader().setRefreshFooter()
    .setUpdateConfigArr(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        [weakSelf.dataSources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZReflectListLogCell className] title:@"ZReflectListLogCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZReflectListLogCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
            
            [weakSelf.cellConfigArr addObject:menuCellConfig];
        }];
        update(weakSelf.cellConfigArr);
    }).setRefreshNet(^{
        weakSelf.currentPage = 1;
        weakSelf.loading = YES;
        [weakSelf refreshHeadData:[weakSelf setPostCommonData]];
    }).setRefreshMoreNet(^{
        [weakSelf refreshNetMoreData];
    });
    
    self.refreshNetData();
    self.reloadData();
}

#pragma mark - 数据处理
- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZRewardCenterViewModel refectList:param completeBlock:^(BOOL isSuccess, ZRewardReflectModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            weakSelf.reloadData();
            
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

- (void)refreshNetMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
     [ZRewardCenterViewModel refectList:param completeBlock:^(BOOL isSuccess, ZRewardReflectModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            weakSelf.reloadData();
            
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
