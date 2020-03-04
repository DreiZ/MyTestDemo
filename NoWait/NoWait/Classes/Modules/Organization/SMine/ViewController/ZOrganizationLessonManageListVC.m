//
//  ZOrganizationLessonManageListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonManageListVC.h"
#import "ZOrganizationLessonManageListCell.h"
#import "ZAlertView.h"

#import "ZOrganizationLessonDetailVC.h"
#import "ZOriganizationLessonViewModel.h"

@interface ZOrganizationLessonManageListVC ()
@end

@implementation ZOrganizationLessonManageListVC

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
    
    ZOriganizationLessonListModel *model = [[ZOriganizationLessonListModel alloc] init];
    if (self.type == ZOrganizationLessonTypeAll) {
        model.type = ZOrganizationLessonTypeOpen;
    }else{
        model.type = self.type;
    }
    model.state = @"开放课程";
    model.name = @"多米一号";
    model.price = @"140.00";
    model.sale = @"32";
    model.score = @"4.0";
    model.image = @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcazaxshi9j30jg0tbwho.jpg";
    
    if (self.type == ZOrganizationLessonTypeExamineFail) {
        model.fail = @"梵蒂冈山东；联盟打了；买了；购买的法律梵蒂冈地方是；蓝湖；来的舒服了；好；六点十分";
    }
    
    ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonManageListCell className] title:[ZOrganizationLessonManageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonManageListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
    [self.cellConfigArr addObject:progressCellConfig];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程列表"];
}

- (void)setupMainView {
    [super setupMainView];
    self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
}



#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationLessonManageListCell"]){
        ZOrganizationLessonManageListCell *enteryCell = (ZOrganizationLessonManageListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index, ZOriganizationLessonListModel *model) {
            [ZAlertView setAlertWithTitle:@"确定关闭课程？" leftBtnTitle:@"取消" rightBtnTitle:@"关闭" handlerBlock:^(NSInteger index) {
                
            }];
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationLessonManageListCell"]) {
        ZOrganizationLessonDetailVC *dvc = [[ZOrganizationLessonDetailVC alloc] init];
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
    
    [ZOriganizationLessonViewModel getLessonlist:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    
    [ZOriganizationLessonViewModel getLessonlist:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
