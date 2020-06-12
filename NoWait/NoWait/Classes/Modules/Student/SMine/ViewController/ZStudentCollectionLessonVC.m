//
//  ZStudentCollectionLessonVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentCollectionLessonVC.h"
#import "ZStudentLessonDetailVC.h"

#import "ZStudentOrganizationLessonListCell.h"
#import "ZStudentCollectionViewModel.h"
#import "ZAlertView.h"

@interface ZStudentCollectionLessonVC ()

@end
@implementation ZStudentCollectionLessonVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_addLoadMoreFooter()
    .zChain_addRefreshHeader()
    .zChain_addEmptyDataDelegate()
    .zChain_setNavTitle(@"我的收藏");
    
    self.zChain_resetMainView(^{
        [weakSelf.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.view.mas_top).offset(10);
        }];
    }).zChain_updateDataSource(^{
        weakSelf.loading = YES;
    }).zChain_block_setRefreshMoreNet(^{
        [self refreshMoreData];
    }).zChain_block_setRefreshHeaderNet(^{
        [self refreshData];
    });
    
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        for (ZOriganizationLessonListModel *model in self.dataSources) {
            model.isStudentCollection = YES;
            ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentOrganizationLessonListCell className] title:[ZStudentOrganizationLessonListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentOrganizationLessonListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:orderCellConfig];
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]){
            ZStudentOrganizationLessonListCell *lcell = (ZStudentOrganizationLessonListCell *)cell;
            lcell.handleBlock = ^(ZOriganizationLessonListModel * model) {
                [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定取消此课程？" leftBtnTitle:@"不取消" rightBtnTitle:@"取消课程" handlerBlock:^(NSInteger index) {
                    if (index == 1) {
                        [weakSelf collectionLesson:NO model:model];
                    }
                }];
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentOrganizationLessonListCell"]) {
             ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
             dvc.model = cellConfig.dataModel;
             [self.navigationController pushViewController:dvc animated:YES];
        }
    });
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZStudentCollectionViewModel getCollectionLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
     [ZStudentCollectionViewModel getCollectionLessonList:param completeBlock:^(BOOL isSuccess, id data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            ZOriganizationLessonListNetModel *sData = data;
            [weakSelf.dataSources addObjectsFromArray:sData.list];
            weakSelf.zChain_reload_ui();
            
            [weakSelf.iTableView tt_endRefreshing];
            if (sData && [sData.total integerValue] <= weakSelf.currentPage * 10) {
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

- (void)collectionLesson:(BOOL)isCollection model:(ZOriganizationLessonListModel *)model{
    [TLUIUtility showLoading:@""];
    __weak typeof(self) weakSelf = self;
    [ZStudentCollectionViewModel collectionLesson:@{@"course":SafeStr(model.lessonID),@"type":isCollection ? @"1":@"2"} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showInfoHint:data];
        }
    }];
}
@end
