//
//  ZOrganizationTeachingScheduleNoVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeachingScheduleNoVC.h"
#import "ZOrganizationTeachingScheduleNoCell.h"
#import "ZOrganizationTeachingScheduleBuCell.h"

#import "ZOrganizationTrachingScheduleNewClassVC.h"
#import "ZOriganizationTeachingScheduleViewModel.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZOrganizationStudentDetailVC.h"

@interface ZOrganizationTeachingScheduleNoVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZOrganizationTeachingScheduleNoVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
//    for (int i = 0; i < 10; i++) {
//        ZOriganizationLessonOrderListModel *model = [[ZOriganizationLessonOrderListModel alloc] init];
//        model.lessonName = @"瑜伽课";
//        model.lessonDes = @"很好学但是很痛苦哇啊啊";
//        model.lessonNum = @"12";
//        model.lessonHadNum = @"2";
//        model.validity = @"2012.12.1";
//        model.teacherName = @"史蒂夫老师";
//        model.lessonImage = @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gci14eu0k1j30e609gmyj.jpg";
//        [self.dataSources addObject:model];
//    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        if (self.isBu) {
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeachingScheduleBuCell className] title:[ZOrganizationTeachingScheduleBuCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTeachingScheduleBuCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [self.cellConfigArr addObject:progressCellConfig];
        }else{
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeachingScheduleNoCell className] title:[ZOrganizationTeachingScheduleNoCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTeachingScheduleNoCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [self.cellConfigArr addObject:progressCellConfig];
        }
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程列表"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(96));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(-CGFloatIn750(0));
        make.top.equalTo(self.view.mas_top).offset(-CGFloatIn750(0));
    }];
}


#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"新建排课" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (weakSelf.isEdit) {
                NSArray *tempArr = [weakSelf selectLessonOrderArr];
                if (tempArr.count == 0) {
                    [TLUIUtility showErrorHint:@"你还没有选择学生"];
                    return ;
                }
                weakSelf.isEdit = NO;
                ZOrganizationTrachingScheduleNewClassVC *successvc = [[ZOrganizationTrachingScheduleNewClassVC alloc] init];
                successvc.lessonOrderArr = tempArr;
                successvc.school = weakSelf.school;
                successvc.isBu = weakSelf.isBu;
                [weakSelf.navigationController pushViewController:successvc animated:YES];
            }else{
                weakSelf.isEdit = YES;
                if (weakSelf.editChangeBlock) {
                    weakSelf.editChangeBlock(weakSelf.isEdit);
                }
            }
        }];
    }
    return _bottomBtn;
}

- (NSMutableArray *)selectLessonOrderArr {
    NSMutableArray *selectArr = @[].mutableCopy;
    for (ZOriganizationStudentListModel *model in self.dataSources) {
        if (model.isSelected) {
            [selectArr addObject:model];
        }
    }
    return selectArr;
}

- (void)changeType:(BOOL)type {
    for (ZOriganizationStudentListModel *model in self.dataSources) {
        model.isEdit = type;
    };
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (isEdit) {
        [self changeType:YES];
        NSInteger count = [self selectLessonOrderArr].count;
        [self.bottomBtn setTitle:[NSString stringWithFormat:@"下一步（%ld/%ld）",(long)count,(long)self.dataSources.count] forState:UIControlStateNormal];
    }else{
        [self changeType:NO];
        [_bottomBtn setTitle:@"新建排课" forState:UIControlStateNormal];
    }
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

#pragma mark - tableview datasource
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOrganizationTeachingScheduleNoCell"]){
        ZOrganizationTeachingScheduleNoCell *enteryCell = (ZOrganizationTeachingScheduleNoCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index) {
            if (weakSelf.isEdit) {
                if (index == 0) {
                    [weakSelf selectData:indexPath.row];
                }else if (index == 1){
                    
                }
                NSInteger count = [weakSelf selectLessonOrderArr].count;
                [weakSelf.bottomBtn setTitle:[NSString stringWithFormat:@"下一步（%ld/%ld）",(long)count,(long)weakSelf.dataSources.count] forState:UIControlStateNormal];
            }else{
                
            }
        };
        
    }
//    if ([cellConfig.title isEqualToString:@"ZOrganizationTeachingScheduleNoCell"]) {
//        ZOrganizationTeachingScheduleNoCell *ncell = (ZOrganizationTeachingScheduleNoCell *)cell;
//        ncell.handleBlock = ^(NSInteger index) {
////            ZOriganizationLessonOrderListModel *model = cellConfig.dataModel;
////            model.isSelected = !model.isSelected;
//            if (weakSelf.isEdit) {
//                NSInteger count = [weakSelf selectLessonOrderArr].count;
//                [weakSelf.bottomBtn setTitle:[NSString stringWithFormat:@"下一步（%ld/%ld）",(long)count,(long)weakSelf.dataSources.count] forState:UIControlStateNormal];
//            }
//        };
//    }
}
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if (!_isEdit) {
        ZOriganizationStudentListModel *listmodel = cellConfig.dataModel;
        ZOrganizationStudentDetailVC *dvc = [[ZOrganizationStudentDetailVC alloc] init];
        dvc.addModel.studentID = listmodel.studentID;
        dvc.addModel.name = listmodel.name;
        dvc.addModel.status = listmodel.status;
        dvc.addModel.teacher = listmodel.teacher_name;
        dvc.addModel.courses_name = listmodel.courses_name;
        dvc.addModel.total_progress = listmodel.total_progress;
        dvc.addModel.now_progress = listmodel.now_progress;
        dvc.addModel.stores_coach_id = listmodel.stores_coach_id;
        dvc.addModel.stores_courses_class_id = listmodel.stores_courses_class_id ;
        dvc.addModel.coach_img = listmodel.coach_img;
        dvc.addModel.teacher_id = listmodel.teacher_id;
        
        [self.navigationController pushViewController:dvc animated:YES];
    }
    
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
    [ZOriganizationStudentViewModel getStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    [ZOriganizationStudentViewModel getStudentList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    [_param setObject:SafeStr(self.school.schoolID) forKey:@"stores_id"];
    if (self.isBu) {
        [_param setObject:@"5" forKey:@"status"];
    }else{
        [_param setObject:@"1" forKey:@"status"];
    }
}


@end
