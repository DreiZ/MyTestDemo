//
//  ZCircleMyEvaListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMyEvaListVC.h"
#import "ZMessageEvaListCell.h"

#import "ZCircleMineCollectionVC.h"
#import "ZCircleDetailVC.h"
#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"

@interface ZCircleMyEvaListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZCircleMyEvaListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    self.zChain_setNavTitle(@"评论")
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_updateDataSource(^{
        self.param = @{}.mutableCopy;
    }).zChain_block_setRefreshHeaderNet(^{
        [self refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [self refreshMoreData];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        [self.dataSources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageEvaListCell className] title:@"ZMessageEvaListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZMessageEvaListCell z_getCellHeight:obj] cellType:ZCellTypeClass dataModel:obj];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }];
        
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageEvaListCell"]) {
            ZMessageEvaListCell *lcell = (ZMessageEvaListCell *)cell;
            lcell.handleBlock = ^(ZCircleMineDynamicEvaModel *model, NSInteger index) {
                if (index == 0) {
                    ZCircleMineCollectionVC *mvc = [[ZCircleMineCollectionVC alloc] init];
                    mvc.account = model.account;
                    [weakSelf.navigationController pushViewController:mvc animated:YES];
                }else{
                    ZCircleDetailVC *dvc = [[ZCircleDetailVC alloc] init];
                    dvc.dynamic = model.dynamic;
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageEvaListCell"]) {
            ZCircleDetailVC *dvc = [[ZCircleDetailVC alloc] init];
            [self.navigationController pushViewController:dvc animated:YES];
        }
    });
    
    self.zChain_reload_Net();
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
    [ZCircleMineViewModel getEvaNewsList:param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
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
    [ZCircleMineViewModel getEvaNewsList:self.param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
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
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:@"10" forKey:@"page_size"];
    [self.param setObject:[ZUserHelper sharedHelper].user.userCodeID forKey:@"account"];
}

@end
