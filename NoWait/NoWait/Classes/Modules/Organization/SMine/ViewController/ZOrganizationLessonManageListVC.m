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

#import "ZOriganizationLessonViewModel.h"

@interface ZOrganizationLessonManageListVC ()
@end

@implementation ZOrganizationLessonManageListVC

#pragma mark - vc delegate
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonManageListCell className] title:[ZOrganizationLessonManageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonManageListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }

    if (self.cellConfigArr.count > 0) {
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else{
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
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
    __weak typeof(self) weakSelf = self;
    
    if ([cellConfig.title isEqualToString:@"ZOrganizationLessonManageListCell"]){
        ZOrganizationLessonManageListCell *enteryCell = (ZOrganizationLessonManageListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index, ZOriganizationLessonListModel *model) {
            if (index == 1) {
                [ZAlertView setAlertWithTitle:@"确定关闭课程？" subTitle:@"课程关闭后,学员将不能在平台上查看和购买" leftBtnTitle:@"取消" rightBtnTitle:@"关闭课程" handlerBlock:^(NSInteger handle) {
                    if (handle == 1) {
                        [weakSelf closeLesson:model];
                    }
                }];
            }else if (index == 2) {
                [ZAlertView setAlertWithTitle:@"小提示" subTitle:[NSString stringWithFormat:@"确定删除%@?",model.name] leftBtnTitle:@"取消" rightBtnTitle:@"删除" handlerBlock:^(NSInteger handle) {
                    if (handle == 1) {
                        [weakSelf deleteLesson:model];
                    }
                }];
            }else if (index == 3) {
                [ZAlertView setAlertWithTitle:@"确定开放课程？" subTitle:@"课程开放后,学员将可以在平台上查看和购买" leftBtnTitle:@"取消" rightBtnTitle:@"开放课程" handlerBlock:^(NSInteger handle) {
                    if (handle == 1) {
                        [weakSelf openLesson:model];
                    }
                }];
            }else if (index == 0){
                [ZOriganizationLessonViewModel getLessonDetail:@{@"id":SafeStr(model.lessonID)} completeBlock:^(BOOL isSuccess, ZOriganizationLessonAddModel *addModel) {
                    if (isSuccess) {
                        routePushVC(ZRoute_org_lessonAdd, addModel, nil);
                    }
                }];
            }
        };
    }
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZOrganizationLessonManageListCell"]) {
        ZOriganizationLessonListModel  *listmodel = cellConfig.dataModel;
        routePushVC(ZRoute_org_lessonDetail, listmodel.lessonID, nil);
    }else if ([cellConfig.title isEqualToString:@"address"]){
       
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
    [ZOriganizationLessonViewModel getLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    [ZOriganizationLessonViewModel getLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    if (self.stores_id) {
        [param setObject:self.stores_id forKey:@"stores_id"];
    }else{
        [param setObject:[ZUserHelper sharedHelper].school.schoolID forKey:@"stores_id"];
    }
       
    switch (self.type) {
       case ZOrganizationLessonTypeOpen:
           [param setObject:@"1" forKey:@"status"];
           break;
           case ZOrganizationLessonTypeClose:
           [param setObject:@"2" forKey:@"status"];
           break;
           case ZOrganizationLessonTypeExamineFail:
           [param setObject:@"3" forKey:@"status"];
           break;
           case ZOrganizationLessonTypeAll:
           [param setObject:@"0" forKey:@"status"];
           break;
           
       default:
           break;
    }
    return param;
}


- (void)closeLesson:(ZOriganizationLessonListModel *)model {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationLessonViewModel closeLesson:@{@"id":SafeStr(model.lessonID),@"status":@"2"} completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}


- (void)openLesson:(ZOriganizationLessonListModel *)model {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationLessonViewModel closeLesson:@{@"id":SafeStr(model.lessonID),@"status":@"1"} completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}


- (void)deleteLesson:(ZOriganizationLessonListModel *)model {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationLessonViewModel deleteLesson:@{@"id":SafeStr(model.lessonID)} completeBlock:^(BOOL isSuccess, NSString *message) {
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
