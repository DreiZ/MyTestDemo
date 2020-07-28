//
//  ZCircleMyFansNewListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMyFansNewListVC.h"
#import "ZCircleMyFocusCell.h"

#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"

@interface ZCircleMyFansNewListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZCircleMyFansNewListVC

- (void)viewWillAppear:(BOOL)animated {
    self.zChain_block_setNotShouldDecompressImages(^{

    });
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"新增粉丝")
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_updateDataSource(^{
        self.param = @{}.mutableCopy;
    }).zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        [weakSelf.dataSources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMyFocusCell className] title:@"ZCircleMyFocusCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZCircleMyFocusCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:obj];
            
            [weakSelf.cellConfigArr addObject:menuCellConfig];
        }];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleMyFocusCell"]) {
            ZCircleMyFocusCell *lcell = (ZCircleMyFocusCell *)cell;
            lcell.handleBlock = ^(ZCircleMinePersonModel *model, NSInteger index) {
                if (index == 1) {
                    [[ZUserHelper sharedHelper] checkLogin:^{
                        if ([model.follow_status intValue] == 1) {
                            [weakSelf followAccount:model];
                        }else{
                            [weakSelf cancleFollowAccount:model];
                        }
                    }];
                }else{
                    routePushVC(ZRoute_circle_mine, model.account, nil);
                }
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        
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
    [ZCircleMineViewModel getNewFansList:param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
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
    [ZCircleMineViewModel getNewFansList:self.param completeBlock:^(BOOL isSuccess, ZCircleMinePersonNetModel *data) {
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

- (void)followAccount:(ZCircleMinePersonModel *)account {
    [TLUIUtility showLoading:nil];
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel followUser:@{@"follow":SafeStr(account.account)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
//            [TLUIUtility showSuccessHint:data];
//            [self refreshAllData];
            account.follow_status = data;
            weakSelf.zChain_reload_ui();
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}


- (void)cancleFollowAccount:(ZCircleMinePersonModel *)account {
    [TLUIUtility showLoading:nil];
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel cancleFollowUser:@{@"follow":SafeStr(account.account)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
//            [TLUIUtility showSuccessHint:data];
//            [self refreshAllData];
            account.follow_status = data;
            weakSelf.zChain_reload_ui();
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}
@end

#pragma mark - RouteHandler
@interface ZCircleMyFansNewListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZCircleMyFansNewListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_newFans;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZCircleMyFansNewListVC *routevc = [[ZCircleMyFansNewListVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
