//
//  ZOrganizationOrderRefuseVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationOrderRefuseVC.h"
#import "ZStudentMineOrderListCell.h"
#import "ZOriganizationOrderViewModel.h"

@interface ZOrganizationOrderRefuseVC ()
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZOrganizationOrderRefuseVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.isStudent = [[ZUserHelper sharedHelper].user.type intValue] == 1? YES:NO;
    self.zChain_setNavTitle(@"退款")
    .zChain_setTableViewGary()
    .zChain_addLoadMoreFooter()
    .zChain_addRefreshHeader()
    .zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_updateDataSource(^{
        weakSelf.param = @{}.mutableCopy;
        [[kNotificationCenter rac_addObserverForName:KNotificationPayBack object:nil] subscribeNext:^(NSNotification *notfication) {
            if (notfication.object && [notfication.object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *backDict = notfication.object;
                if (backDict && [backDict objectForKey:@"payState"]) {
                    if ([backDict[@"payState"] integerValue] == 0) {
                        [weakSelf refreshAllData];
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
    }).zChain_resetMainView(^{
        weakSelf.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.view.mas_top).offset(10);
        }];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];

        for (int i = 0; i < weakSelf.dataSources.count; i++) {
            ZOrderListModel *model = weakSelf.dataSources[i];
            model.isStudent = weakSelf.isStudent;
            model.isRefund = YES;
            
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderListCell className] title:[ZStudentMineOrderListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderListCell z_getCellHeight:weakSelf.dataSources[i]] cellType:ZCellTypeClass dataModel:weakSelf.dataSources[i]];
            [weakSelf.cellConfigArr addObject:orderCellConfig];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        ZStudentMineOrderListCell *enteryCell = (ZStudentMineOrderListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index, ZOrderListModel *model) {
            if (index == ZLessonOrderHandleTypeORefundReject || index == ZLessonOrderHandleTypeSRefundReject) {
                routePushVC(ZRoute_org_orderDetail, model, nil);
            }else{
                [ZOriganizationOrderViewModel handleOrderWithIndex:index data:model completeBlock:^(BOOL isSuccess, id data) {
                    if (isSuccess) {
                        [TLUIUtility showSuccessHint:data];
                        [weakSelf refreshAllData];
                    }else{
                        [TLUIUtility showErrorHint:data];
                    }
                }];
            }
        };
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
            routePushVC(ZRoute_org_orderDetail, cellConfig.dataModel, nil);
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
    [ZOriganizationOrderViewModel getRefundOrderList:param completeBlock:^(BOOL isSuccess, ZOrderListNetModel *data) {
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
    [ZOriganizationOrderViewModel getRefundOrderList:self.param completeBlock:^(BOOL isSuccess, ZOrderListNetModel *data) {
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
    if (self.isStudent) {
        [self.param setObject:@"0" forKey:@"type"];
    }else{
        [self.param setObject:@"1" forKey:@"type"];
        [self.param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    }
}
@end

#pragma mark - RouteHandler
@interface ZOrganizationOrderRefuseVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationOrderRefuseVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_orderRefuse;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationOrderRefuseVC *routevc = [[ZOrganizationOrderRefuseVC alloc] init];
    if (request.prts) {
        routevc.isStudent = [request.prts boolValue];
    }
    
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
