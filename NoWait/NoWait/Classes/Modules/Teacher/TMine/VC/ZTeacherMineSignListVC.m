//
//  ZTeacherMineSignListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineSignListVC.h"
#import "ZTeacherMineSignListCell.h"

#import "ZTeacherClassDetailSignDetailVC.h"
#import "ZTeacherClassDetailVC.h"
#import "ZOriganizationClassViewModel.h"
#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZAlertView.h"

@interface ZTeacherMineSignListVC ()

@end
@implementation ZTeacherMineSignListVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self setTableViewGaryBack];
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (ZOriganizationClassListModel *model in self.dataSources) {
        ZCellConfig *orderCellConfig = [ZCellConfig cellConfigWithClassName:[ZTeacherMineSignListCell className] title:[ZTeacherMineSignListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZTeacherMineSignListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:orderCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"我的签课"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}


#pragma mark tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZTeacherMineSignListCell"]){
        ZTeacherMineSignListCell *enteryCell = (ZTeacherMineSignListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index, ZOriganizationClassListModel *model) {
            if (index == 0) {
                ZOrganizationClassDetailStudentListVC *lvc = [[ZOrganizationClassDetailStudentListVC alloc] init];
                lvc.listModel = model;
//                lvc.type = 1;
                lvc.isEnd = [model.status intValue] == 3;
                [self.navigationController pushViewController:lvc animated:YES];
            }else if(index == 1){
                [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定此班级开课吗" leftBtnTitle:@"取消" rightBtnTitle:@"确定开课" handlerBlock:^(NSInteger index) {
                    if (index == 1) {
                        [weakSelf openClass:model];
                    }
                }];
            }else if (index == 2){
                ZOriganizationClassDetailModel *smodel = [[ZOriganizationClassDetailModel alloc] init];
                smodel.now_progress = model.now_progress;
                smodel.stores_courses_name = model.stores_courses_name;
                smodel.courses_name = model.courses_name;
                smodel.classID = model.classID;
                smodel.name = model.name;
                smodel.nums = model.nums;
                smodel.status = model.status;
                
                ZTeacherClassDetailSignDetailVC *sdvc = [[ZTeacherClassDetailSignDetailVC alloc] init];
                sdvc.isTeacher = YES;
                sdvc.model = smodel;
                
                [self.navigationController pushViewController:sdvc animated:YES];
            }
        };
    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"ZTeacherMineSignListCell"]){
         ZOriganizationClassListModel *model = cellConfig.dataModel;
         ZTeacherClassDetailVC *dvc = [[ZTeacherClassDetailVC alloc] init];
         dvc.model.courses_name = model.courses_name;
         dvc.model.classID = model.classID;
         dvc.model.name = model.name;
         dvc.model.nums = model.nums;
         dvc.model.status = model.status;
         [self.navigationController pushViewController:dvc animated:YES];
    }
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getTeacherClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
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
     [ZOriganizationClassViewModel getTeacherClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
            
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
    NSMutableDictionary *param = [self setPostCommonData];
    [param setObject:@"1" forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    [self refreshHeadData:param];
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:SafeStr([ZUserHelper sharedHelper].stores.stores_id) forKey:@"stores_id"];
    [param setObject:SafeStr([ZUserHelper sharedHelper].stores.teacher_id) forKey:@"teacher_id"];
    return param;
}


- (void)openClass:(ZOriganizationClassListModel*)model {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel openClass:@{@"courses_class_id":SafeStr(model.classID)} completeBlock:^(BOOL isSuccess, id message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            ZTeacherSignNetModel *model = message;
            if (model.code && [model.code intValue] == 1) {
                [ZAlertView setAlertWithTitle:@"提示" subTitle:model.notice_msg btnTitle:@"知道了" handlerBlock:^(NSInteger index) {
                    
                }];
            }else{
                [TLUIUtility showSuccessHint:model.notice_msg];
            }
            
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}

@end

