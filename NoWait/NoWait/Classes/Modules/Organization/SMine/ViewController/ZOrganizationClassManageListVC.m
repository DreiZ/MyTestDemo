//
//  ZOrganizationClassManageListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassManageListVC.h"
#import "ZOrganizationClassManageListCell.h"
#import "ZAlertView.h"

#import "ZOrganizationClassManageDetailVC.h"
#import "ZOriganizationClassViewModel.h"

@interface ZOrganizationClassManageListVC ()

@end

@implementation ZOrganizationClassManageListVC

#pragma mark vc delegate-------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    [self initCellConfigArr];
}

#pragma mark - setdata mainview
- (void)setupMainView {
    
    [super setupMainView];
    
    self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < 10; i++) {
        ZOriganizationClassListModel *model = [[ZOriganizationClassListModel alloc] init];
        model.className = @"瑜伽课";
        model.classDes = @"很好学但是很痛苦哇啊啊";
        model.num = @"12";
        model.status = @"2";
        model.type = @"1";
        model.teacherName = @"史蒂夫老师";
        model.teacherImage = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gci14eu0k1j30e609gmyj.jpg";
        [self.dataSources addObject:model];
        
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationClassManageListCell className] title:[ZOrganizationClassManageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationClassManageListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"课程列表"];
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
       if ([cellConfig.title isEqualToString:@"ZOrganizationClassManageListCell"]) {
           ZOrganizationClassManageDetailVC *dvc = [[ZOrganizationClassManageDetailVC alloc] init];
           if (indexPath.row % 2 == 1) {
               dvc.isOpen = YES;
           }
           [self.navigationController pushViewController:dvc animated:YES];
       }else if ([cellConfig.title isEqualToString:@"address"]){
          
       }
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = @{@"page_index":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    
    [ZOriganizationClassViewModel getClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonOrderListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
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
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = @{@"page_index":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    
    [ZOriganizationClassViewModel getClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonOrderListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
            [weakSelf.iTableView tt_endRefreshing];
            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
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
@end
