//
//  ZOrganizationTeachingScheduleLessonVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeachingScheduleLessonVC.h"
#import "ZOrganizationTeachingScheduleLessonCell.h"
#import "ZOriganizationLessonViewModel.h"

#import "ZOrganizationTeachingScheduleVC.h"
#import "ZOrganizationTrachingScheduleOutlineClassVC.h"
#import "ZStudentExperienceLessonDetailVC.h"

@interface ZOrganizationTeachingScheduleLessonVC ()
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) UIButton *navRightBtn;

@end

@implementation ZOrganizationTeachingScheduleLessonVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zChain_setNavTitle(@"待排课列表")
    .zChain_setTableViewWhite()
    .zChain_resetMainView(^{
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }).zChain_updateDataSource(^{
        self.param = @{}.mutableCopy;
    }).zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshHeaderNet(^{
        [self refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [self refreshMoreData];
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        for (int i = 0; i < self.dataSources.count; i++) {
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeachingScheduleLessonCell className] title:[ZOrganizationTeachingScheduleLessonCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTeachingScheduleLessonCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [self.cellConfigArr addObject:progressCellConfig];
        }
        if (self.cellConfigArr.count == 0) {
            self.zChain_setTableViewWhite();
        }else{
            self.zChain_setTableViewGary();
        }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZOrganizationTeachingScheduleLessonCell"]) {
            ZOrganizationTeachingScheduleLessonCell *lcell = (ZOrganizationTeachingScheduleLessonCell *)cell;
            lcell.handleBlock = ^(NSInteger index, ZOriganizationLessonScheduleListModel *model) {
                if (index == 0) {
                    ZOrganizationTeachingScheduleVC *svc = [[ZOrganizationTeachingScheduleVC alloc] init];
                    svc.stores_courses_id = model.lessonID;
                    svc.lessonModel = model;
                    [self.navigationController pushViewController:svc animated:YES];
                }else{
                    ZOriganizationLessonListModel *smodel = [[ZOriganizationLessonListModel alloc] init];
                    ZStudentExperienceLessonDetailVC *dvc = [[ZStudentExperienceLessonDetailVC alloc] init];
                    smodel.lessonID = model.lessonID;
                    dvc.model = smodel;
                    [self.navigationController pushViewController:dvc animated:YES];
                }
            };
        }
    });
}


#pragma mark - lazy loading
- (NSMutableArray *)selectLessonOrderArr {
    NSMutableArray *selectArr = @[].mutableCopy;
    for (ZOriganizationStudentListModel *model in self.dataSources) {
        if (model.isSelected) {
            [selectArr addObject:model];
        }
    }
    return selectArr;
}

- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navRightBtn setTitle:@"线下排课" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
        [_navRightBtn bk_addEventHandler:^(id sender) {
            ZOrganizationTrachingScheduleOutlineClassVC *ovc = [[ZOrganizationTrachingScheduleOutlineClassVC alloc] init];
            
            [weakSelf.navigationController pushViewController:ovc animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}

- (void)changeType:(BOOL)type {
    for (ZOriganizationStudentListModel *model in self.dataSources) {
        model.isEdit = type;
    };
}

- (void)selectData:(NSInteger)index {
//    for (int i = 0; i < self.dataSources.count; i++) {
//        ZOriganizationStudentListModel *model = self.dataSources[i];
//        if (i == index) {
//            model.isSelected = !model.isSelected;
//        }
//    }
//    [self initCellConfigArr];
//    [self.iTableView reloadData];
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
    [ZOriganizationLessonViewModel getCoursesLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonScheduleListNetModel *data) {
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
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getCoursesLessonList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationLessonScheduleListNetModel *data) {
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
}
@end

