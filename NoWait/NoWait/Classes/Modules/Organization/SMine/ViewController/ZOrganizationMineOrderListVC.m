//
//  ZOrganizationMineOrderListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMineOrderListVC.h"

#import "ZStudentMineOrderListCell.h"
#import "ZOriganizationOrderViewModel.h"

@interface ZOrganizationMineOrderListVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZOrganizationMineOrderListVC


-(void)viewDidAppear:(BOOL)animated {
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
    .zChain_updateDataSource(^{
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
    }).zChain_resetMainView(^{
        self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.view.mas_top).offset(10);
        }];
    }).zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        for (int i = 0; i < weakSelf.dataSources.count; i++) {
    //        ZOrderListModel *model = self.dataSources[i];
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineOrderListCell className] title:[ZStudentMineOrderListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMineOrderListCell z_getCellHeight:weakSelf.dataSources[i]] cellType:ZCellTypeClass dataModel:weakSelf.dataSources[i]];
            [weakSelf.cellConfigArr addObject:orderCellConfig];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
            ZStudentMineOrderListCell *enteryCell = (ZStudentMineOrderListCell *)cell;
            enteryCell.handleBlock = ^(NSInteger index, ZOrderListModel *model) {
                if (index == ZLessonOrderHandleTypeEva) {
                    routePushVC(ZRoute_mine_evaEdit, model, nil);
                }else{
                    [ZOriganizationOrderViewModel handleOrderWithIndex:index data:model completeBlock:^(BOOL isSuccess, id data) {
                        if (isSuccess) {
                            [TLUIUtility showSuccessHint:data];
                            [weakSelf refreshData];
                        }else{
                            [TLUIUtility showErrorHint:data];
                        }
                    }];
                }
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentMineOrderListCell"]){
            routePushVC(ZRoute_org_orderDetail, cellConfig.dataModel, nil);
        }
    });
}

- (NSMutableDictionary *)param {
    if (!_param) {
        _param = @{}.mutableCopy;
    }
    return _param;
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
    [ZOriganizationOrderViewModel getOrderList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    [ZOriganizationOrderViewModel getOrderList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    [self.param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    
    switch (self.type) {
        case ZOrganizationOrderTypeAll:
            //全部
            [_param setObject:[NSString stringWithFormat:@"%d",0] forKey:@"status"];
            break;
        case ZOrganizationOrderTypeForPay:
            //@"待支付";
            [_param setObject:@"1" forKey:@"status"];
            break;
        case ZOrganizationOrderTypeOrderForReceived:
            //预约待支付
            [_param setObject:@"4" forKey:@"status"];
            break;
        case ZOrganizationOrderTypeHadEva:
            //已完成
            [_param setObject:@"3" forKey:@"status"];
            break;
        default:
            break;
    }
    [self.param setObject:@"1" forKey:@"type"];
}

@end
