//
//  ZCircleMyEvaListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMyEvaListVC.h"
#import "ZMessageEvaListCell.h"

#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"

@interface ZCircleMyEvaListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZCircleMyEvaListVC

- (void)viewWillAppear:(BOOL)animated {
    self.zChain_block_setNotShouldDecompressImages(^{

    });
    [super viewWillAppear:animated];
}

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
        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        
        [weakSelf.dataSources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageEvaListCell className] title:@"ZMessageEvaListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZMessageEvaListCell z_getCellHeight:obj] cellType:ZCellTypeClass dataModel:obj];
            
            [weakSelf.cellConfigArr addObject:menuCellConfig];
        }];
        
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageEvaListCell"]) {
            ZMessageEvaListCell *lcell = (ZMessageEvaListCell *)cell;
            lcell.handleBlock = ^(ZCircleMineDynamicEvaModel *model, NSInteger index) {
                if (index == 0) {
                    routePushVC(ZRoute_circle_mine, @{@"id":SafeStr(model.account)}, nil);
                }else{
                    routePushVC(ZRoute_circle_detial, @{@"id":SafeStr(model.dynamic)}, nil);
                }
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageEvaListCell"]) {
            ZCircleMineDynamicEvaModel *model = cellConfig.dataModel;
            routePushVC(ZRoute_circle_detial, @{@"id":SafeStr(model.dynamic)}, nil);
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
            
            if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            
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
            if (weakSelf) {
                    weakSelf.zChain_reload_ui();
                }
            
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

#pragma mark - RouteHandler
@interface ZCircleMyEvaListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZCircleMyEvaListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_evaList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZCircleMyEvaListVC *routevc = [[ZCircleMyEvaListVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
