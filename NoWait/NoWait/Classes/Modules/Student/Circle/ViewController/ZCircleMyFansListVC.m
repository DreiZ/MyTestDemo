//
//  ZCircleMyFansListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMyFansListVC.h"
#import "ZCircleMyFocusCell.h"

#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"

#import "ZCircleMineCollectionVC.h"

@interface ZCircleMyFansListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZCircleMyFansListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle([[ZUserHelper sharedHelper].user.userCodeID isEqualToString:self.account]? @"粉丝列表":@"粉丝")
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
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMyFocusCell className] title:@"ZCircleMyFocusCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleMyFocusCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
            
            [self.cellConfigArr addObject:menuCellConfig];
        }];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleMyFocusCell"]) {
            ZCircleMyFocusCell *lcell = (ZCircleMyFocusCell *)cell;
            lcell.handleBlock = ^(ZCircleMinePersonModel *model, NSInteger index) {
                if (index == 1) {
                    if ([model.follow_status intValue] == 1) {
                        [weakSelf followAccount:model.account];
                    }else{
                        [weakSelf cancleFollowAccount:model.account];
                    }
                }else{
                    ZCircleMineCollectionVC *cvc = [[ZCircleMineCollectionVC alloc] init];
                    cvc.account = model.account;
                    [weakSelf.navigationController pushViewController:cvc animated:YES];
                }
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
//        if ([cellConfig.title isEqualToString:@"ZCircleMyFocusCell"]) {
//            ZCircleMineCollectionVC *mvc = [[ZCircleMineCollectionVC alloc] init];
//            [self.navigationController pushViewController:mvc animated:YES];
//        }
    });
    
    self.zChain_reload_Net();
    self.zChain_reload_ui();
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
    [ZCircleMineViewModel getFansList:param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
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
    [ZCircleMineViewModel getFansList:self.param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
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
    [self.param setObject:self.account forKey:@"account"];
}


- (void)followAccount:(NSString *)account {
    [TLUIUtility showLoading:nil];
    [ZCircleMineViewModel followUser:@{@"follow":SafeStr(account)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [self refreshAllData];
            self.zChain_reload_ui();
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}


- (void)cancleFollowAccount:(NSString *)account {
    [TLUIUtility showLoading:nil];
    [ZCircleMineViewModel cancleFollowUser:@{@"follow":SafeStr(account)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [self refreshAllData];
            self.zChain_reload_ui();
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}
@end

