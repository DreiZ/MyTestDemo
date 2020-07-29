//
//  ZStudentTeacherDetailEvaListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentTeacherDetailEvaListVC.h"
#import "ZOriganizationOrderViewModel.h"
#import "ZStudentEvaListCell.h"

@interface ZStudentTeacherDetailEvaListVC ()

@end

@implementation ZStudentTeacherDetailEvaListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(SafeStr(self.teacher_name))
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_updateDataSource(^{
        self.loading = YES;
    }).zChain_block_setRefreshHeaderNet(^{
        weakSelf.currentPage = 1;
        weakSelf.loading = YES;
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:SafeStr(weakSelf.teacher_id) forKey:@"teacher_id"];
        [param setObject:SafeStr(weakSelf.stores_id) forKey:@"stores_id"];
        [param setObject:[NSString stringWithFormat:@"%ld",weakSelf.currentPage] forKey:@"page"];
        [param setObject:@"10" forKey:@"page_size"];
        
        [ZOriganizationOrderViewModel getTeacherCommentListList:param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
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
    }).zChain_block_setRefreshMoreNet(^{
        weakSelf.currentPage++;
        weakSelf.loading = YES;
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:SafeStr(weakSelf.teacher_id) forKey:@"teacher_id"];
        [param setObject:SafeStr(weakSelf.stores_id) forKey:@"stores_id"];
        [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
        [param setObject:@"10" forKey:@"page_size"];
        
        [ZOriganizationOrderViewModel getTeacherCommentListList:param completeBlock:^(BOOL isSuccess, ZOrderEvaListNetModel *data) {
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
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];

        for (ZOrderEvaListModel *evaModel in self.dataSources) {
           ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
            [weakSelf.cellConfigArr addObject:evaCellConfig];
        }
    });
    
    self.zChain_reload_Net();
}
@end

#pragma mark - RouteHandler
@interface ZStudentTeacherDetailEvaListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZStudentTeacherDetailEvaListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_main_teacherEvaList;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZStudentTeacherDetailEvaListVC *routevc = [[ZStudentTeacherDetailEvaListVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = request.prts;
        if ([tempDict objectForKey:@"teacher_id"]) {
            routevc.teacher_id = tempDict[@"teacher_id"];
        }
        if ([tempDict objectForKey:@"stores_id"]) {
            routevc.stores_id = tempDict[@"stores_id"];
        }
        if ([tempDict objectForKey:@"teacher_name"]) {
            routevc.teacher_name = tempDict[@"teacher_name"];
        }
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
