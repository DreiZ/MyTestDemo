//
//  ZOrganizationManagerSearchLessonListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/1.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationManagerSearchLessonListVC.h"
#import "ZOriganizationLessonViewModel.h"
#import "ZOrganizationLessonManageListCell.h"
//#import "ZStudentOrganizationLessonListCell.h"

#import "ZAlertView.h"

@interface ZOrganizationManagerSearchLessonListVC ()
@property (nonatomic,strong) NSString *name;

@end

@implementation ZOrganizationManagerSearchLessonListVC


- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchType = kSearchHistoryLessonSearch;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchView.iTextField) {
        [self.searchView.iTextField resignFirstResponder];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.searchView.iTextField && (self.searchView.iTextField.text.length == 0)) {
        [self.searchView.iTextField becomeFirstResponder];
    }
    self.loading = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyDataStr = @"暂无数据";
    self.loading = NO;
    self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
    self.iTableView.tableFooterView = nil;
}


#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *lessonCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationLessonManageListCell className] title:[ZOrganizationLessonManageListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationLessonManageListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:lessonCellConfig];
    }

    if (self.cellConfigArr.count > 0) {
        self.iTableView.tableFooterView = self.safeFooterView;
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else{
        self.iTableView.tableFooterView = nil;
        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
}

- (void)searchClick:(NSString *)text{
    [super searchClick:text];
    self.name = SafeStr(text);
    if (self.name.length > 0) {
        [self refreshData];
    }
}

#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    
    if ([cellConfig.title isEqualToString:@"ZOrganizationLessonManageListCell"]){
        ZOrganizationLessonManageListCell *enteryCell = (ZOrganizationLessonManageListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index, ZOriganizationLessonListModel *model) {
            if (index == 1) {
                [ZAlertView setAlertWithTitle:@"确定关闭课程？" subTitle:@"关闭的课程可编辑，或重新开启" leftBtnTitle:@"取消" rightBtnTitle:@"关闭课程" handlerBlock:^(NSInteger handle) {
                    if (handle == 1) {
                        [weakSelf closeLesson:model];
                    }
                }];
            }else if (index == 2) {
                [ZAlertView setAlertWithTitle:@"删除课程" subTitle:@"确定删除课程? 删除的课程不可恢复" leftBtnTitle:@"取消" rightBtnTitle:@"删除" handlerBlock:^(NSInteger handle) {
                    if (handle == 1) {
                        [weakSelf deleteLesson:model];
                    }
                }];
            }else if (index == 3) {
                [ZAlertView setAlertWithTitle:@"确定开放课程？" subTitle:@"开放课程后台审核后方可对学员可见" leftBtnTitle:@"取消" rightBtnTitle:@"开放课程" handlerBlock:^(NSInteger handle) {
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
    [ZOriganizationLessonViewModel searchLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    [ZOriganizationLessonViewModel searchLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    [param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    
    [param setObject:self.name forKey:@"name"];
    if (self.stores_id) {
        [param setObject:self.stores_id forKey:@"stores_id"];
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

#pragma mark - RouteHandler
@interface ZOrganizationManagerSearchLessonListVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZOrganizationManagerSearchLessonListVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_org_lessonSearch;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZOrganizationManagerSearchLessonListVC *routevc = [[ZOrganizationManagerSearchLessonListVC alloc] init];
    if (request.prts && [request.prts isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDict = request.prts;
        if ([tempDict objectForKey:@"stores_id"]) {
            routevc.stores_id = tempDict[@"stores_id"];
        }
        if ([tempDict objectForKey:@"navTitle"]) {
            routevc.navTitle = tempDict[@"navTitle"];
        }
    }
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
