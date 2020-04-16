//
//  ZOrganizationClassManageListSearchVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassManageListSearchVC.h"
#import "ZOrganizationClassManageListCell.h"
#import "ZAlertView.h"

#import "ZOrganizationClassManageDetailVC.h"
#import "ZOriganizationClassViewModel.h"

@interface ZOrganizationClassManageListSearchVC ()
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,assign) BOOL isEdit;
@end

@implementation ZOrganizationClassManageListSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewGaryBack];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
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

#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationClassManageListCell className] title:[ZOrganizationClassManageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationClassManageListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }

    if (self.cellConfigArr.count > 0) {
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else{
        self.isEdit = NO;
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
}

- (void)searchClick:(NSString *)text {
    [super valueChange:text];
    self.name = SafeStr(text);
    if (self.name.length > 0) {
        [self refreshData];
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
    [ZOriganizationClassViewModel searchClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
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
     [ZOriganizationClassViewModel searchClassList:param completeBlock:^(BOOL isSuccess, ZOriganizationClassListNetModel *data) {
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
       [param setObject:[ZUserHelper sharedHelper].school.schoolID forKey:@"stores_id"];
       [param setObject:self.name forKey:@"name"];
    return param;
}

#pragma mark - setdata
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
                [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"开课后不可以添加或者删除学员" leftBtnTitle:@"取消" rightBtnTitle:@"开课" handlerBlock:^(NSInteger index) {
                    if (index == 1) {
                        [weakSelf openClass:model];
                    }
                }];
                
            }
        };
    }
}

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

@end


