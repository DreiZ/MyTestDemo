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
    
    self.zChain_setNavTitle(SafeStr(self.teacher_name))
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_updateDataSource(^{
        self.loading = YES;
    }).zChain_block_setRefreshHeaderNet(^{
        self.currentPage = 1;
        self.loading = YES;
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:SafeStr(self.teacher_id) forKey:@"teacher_id"];
        [param setObject:SafeStr(self.stores_id) forKey:@"stores_id"];
        [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
        [param setObject:@"10" forKey:@"page_size"];
        __weak typeof(self) weakSelf = self;
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
        self.currentPage++;
        self.loading = YES;
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:SafeStr(self.teacher_id) forKey:@"teacher_id"];
        [param setObject:SafeStr(self.stores_id) forKey:@"stores_id"];
        [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
        [param setObject:@"10" forKey:@"page_size"];
        __weak typeof(self) weakSelf = self;
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
        [self.cellConfigArr removeAllObjects];

        for (ZOrderEvaListModel *evaModel in self.dataSources) {
           ZCellConfig *evaCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentEvaListCell className] title:[ZStudentEvaListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentEvaListCell z_getCellHeight:evaModel] cellType:ZCellTypeClass dataModel:evaModel];
            [self.cellConfigArr addObject:evaCellConfig];
        }
    });
    
    self.zChain_reload_Net();
}
@end
