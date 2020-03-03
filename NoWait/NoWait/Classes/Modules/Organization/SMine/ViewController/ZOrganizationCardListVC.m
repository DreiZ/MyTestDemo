//
//  ZOrganizationCardListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardListVC.h"
#import "ZOriganizationCartListCell.h"


@interface ZOrganizationCardListVC ()
@end

@implementation ZOrganizationCardListVC

#pragma mark - vc delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    [self initCellConfigArr];
}

#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationCartListCell className] title:[ZOriganizationCartListCell className] showInfoMethod:nil heightOfCell:[ZOriganizationCartListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];

    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"卡券列表"];
}


#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOriganizationCartListCell"]){
        ZOriganizationCartListCell *enteryCell = (ZOriganizationCartListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index) {
            
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOriganizationCartListCell"]) {
        
    }else if ([cellConfig.title isEqualToString:@"address"]){
       
    }
}

//#pragma mark - 数据处理
//- (void)refreshData {
//    self.currentPage = 1;
//    self.loading = YES;
//    __weak typeof(self) weakSelf = self;
//    NSMutableDictionary *param = @{@"page_index":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
//
//    [ZOriganizationLessonViewModel getLessonlist:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
//        weakSelf.loading = NO;
//        if (isSuccess && data) {
//            [weakSelf.dataSources removeAllObjects];
//            [weakSelf.dataSources addObjectsFromArray:data.list];
//            [weakSelf initCellConfigArr];
//            [weakSelf.iTableView reloadData];
//
//            [weakSelf.iTableView tt_endRefreshing];
//            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
//                [weakSelf.iTableView tt_removeLoadMoreFooter];
//            }else{
//                [weakSelf.iTableView tt_endLoadMore];
//            }
//        }else{
//            [weakSelf.iTableView reloadData];
//            [weakSelf.iTableView tt_endRefreshing];
//            [weakSelf.iTableView tt_removeLoadMoreFooter];
//        }
//    }];
//}
//
//- (void)refreshMoreData {
//    self.currentPage++;
//    self.loading = YES;
//    __weak typeof(self) weakSelf = self;
//    NSMutableDictionary *param = @{@"page_index":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
//
//    [ZOriganizationLessonViewModel getLessonlist:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
//        weakSelf.loading = NO;
//        if (isSuccess && data) {
//            [weakSelf.dataSources addObjectsFromArray:data.list];
//            [weakSelf initCellConfigArr];
//            [weakSelf.iTableView reloadData];
//
//            [weakSelf.iTableView tt_endRefreshing];
//            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
//                [weakSelf.iTableView tt_removeLoadMoreFooter];
//            }else{
//                [weakSelf.iTableView tt_endLoadMore];
//            }
//        }else{
//            [weakSelf.iTableView reloadData];
//            [weakSelf.iTableView tt_endRefreshing];
//            [weakSelf.iTableView tt_removeLoadMoreFooter];
//        }
//    }];
//}
@end

