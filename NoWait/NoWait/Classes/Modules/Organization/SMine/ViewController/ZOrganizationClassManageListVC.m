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
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZOrganizationClassManageListVC

#pragma mark vc delegate-------------------
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

#pragma mark - setdata mainview
- (void)setupMainView {
    [super setupMainView];
    
    self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
}

- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationClassManageListCell className] title:[ZOrganizationClassManageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationClassManageListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"课程列表"];
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOrganizationClassManageListCell"]) {
        ZOriganizationClassListModel *model = cellConfig.dataModel;
        ZOrganizationClassManageListCell *lcell = (ZOrganizationClassManageListCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            if (index == 0) {
                [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"删除后学员可以从新排课" leftBtnTitle:@"取消" rightBtnTitle:@"删除" handlerBlock:^(NSInteger index) {
                    if (index == 1) {
                        [weakSelf deleteClass:model];
                    }
                }];
            }else if (index == 1){
//                [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"开课后不可以添加或者删除学员" leftBtnTitle:@"取消" rightBtnTitle:@"开课" handlerBlock:^(NSInteger index) {
//                    if (index == 1) {
//                        [weakSelf openClass:model];
//                    }
//                }];
                ZOriganizationClassListModel *model = cellConfig.dataModel;
                
                ZOrganizationClassManageDetailVC *dvc = [[ZOrganizationClassManageDetailVC alloc] init];
                dvc.model.courses_name = model.courses_name;
                dvc.model.classID = model.classID;
                dvc.model.name = model.name;
                dvc.model.nums = model.nums;
                dvc.model.status = model.status;
                dvc.model.teacher_id = model.teacher_id;
                dvc.model.teacher_image = model.teacher_image;
                dvc.model.teacher_name = model.teacher_name;
                dvc.model.type = model.type;
                [self.navigationController pushViewController:dvc animated:YES];
            }
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
       if ([cellConfig.title isEqualToString:@"ZOrganizationClassManageListCell"]) {
           ZOriganizationClassListModel *model = cellConfig.dataModel;
           
           ZOrganizationClassManageDetailVC *dvc = [[ZOrganizationClassManageDetailVC alloc] init];
           dvc.model.courses_name = model.courses_name;
           dvc.model.classID = model.classID;
           dvc.model.name = model.name;
           dvc.model.nums = model.nums;
           dvc.model.status = model.status;
           dvc.model.teacher_id = model.teacher_id;
           dvc.model.teacher_image = model.teacher_image;
           dvc.model.teacher_name = model.teacher_name;
           dvc.model.type = model.type;
           [self.navigationController pushViewController:dvc animated:YES];
       }
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
    [ZOriganizationClassViewModel getClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
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
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getClassList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
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
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [_param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [_param setObject:SafeStr(self.type) forKey:@"type"];
}




- (void)deleteClass:(ZOriganizationClassListModel*)model {
    __weak typeof(self) weakSelf = self;
 
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel deleteClass:@{@"stores_id":SafeStr([ZUserHelper sharedHelper].school.schoolID),@"id":SafeStr(model.classID)} completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}


- (void)openClass:(ZOriganizationClassListModel*)model {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel openClass:@{@"stores_id":SafeStr([ZUserHelper sharedHelper].school.schoolID),@"id":SafeStr(model.classID)} completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}

@end
