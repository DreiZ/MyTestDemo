//
//  ZOrganizationSearchTeachingScheduleVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSearchTeachingScheduleVC.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZOriganizationStudentListCell.h"
#import "ZOrganizationTeachingScheduleBuCell.h"
#import "ZOrganizationTeachingScheduleNoCell.h"
#import "ZOrganizationTrachingScheduleNewClassVC.h"

#import "ZOrganizationStudentDetailVC.h"

@interface ZOrganizationSearchTeachingScheduleVC ()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableDictionary *param;

@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,assign) BOOL isEdit;
@end

@implementation ZOrganizationSearchTeachingScheduleVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _param = @{}.mutableCopy;
    [self setTableViewGaryBack];
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
}


- (void)searchClick:(NSString *)text {
    [super searchClick:text];
    self.name = SafeStr(text);
    if (self.name.length > 0) {
        [self refreshData];
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *lmodel = self.dataSources[i];
        if ([lmodel.status intValue] == 5) {
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeachingScheduleBuCell className] title:[ZOrganizationTeachingScheduleBuCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTeachingScheduleBuCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [self.cellConfigArr addObject:progressCellConfig];
        }else{
            ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationTeachingScheduleNoCell className] title:[ZOrganizationTeachingScheduleNoCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOrganizationTeachingScheduleNoCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            [self.cellConfigArr addObject:progressCellConfig];
        }
    }
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
        make.top.equalTo(self.searchView.mas_bottom).offset(-CGFloatIn750(0));
    }];
}


#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"新建排课" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            if (!ValidArray(weakSelf.dataSources)) {
                return ;
            }
            if (weakSelf.isEdit) {
                NSArray *tempArr = [weakSelf selectLessonOrderArr];
                if (tempArr.count == 0) {
                    [TLUIUtility showErrorHint:@"你还没有选择学生"];
                    return ;
                }
                weakSelf.isEdit = NO;
                ZOrganizationTrachingScheduleNewClassVC *successvc = [[ZOrganizationTrachingScheduleNewClassVC alloc] init];
                successvc.lessonOrderArr = tempArr;
                successvc.isBu = weakSelf.type == 2 ? YES:NO;
                [weakSelf.navigationController pushViewController:successvc animated:YES];
            }else{
                weakSelf.isEdit = YES;
            }
        } forControlEvents:UIControlEventTouchUpInside];
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
        enteryCell.handleBlock = ^BOOL(NSInteger index) {
            if (weakSelf.isEdit) {
                if (index == 0) {
                    [weakSelf selectData:indexPath.row];
                }else if (index == 1){
                    
                }
                NSInteger count = [weakSelf selectLessonOrderArr].count;
                [weakSelf.bottomBtn setTitle:[NSString stringWithFormat:@"下一步（%ld/%@）",(long)count,weakSelf.lessonModel.course_class_number] forState:UIControlStateNormal];
            }else{
                
            }
            return YES;
//             NSInteger allcount = [weakSelf selectLessonOrderArr].count;
//             if (allcount < [weakSelf.lessonModel.course_class_number intValue]) {
//                 if (weakSelf.isEdit) {
//                     if (index == 0) {
//                         [weakSelf selectData:indexPath.row];
//                     }else if (index == 1){
//
//                     }
//                     NSInteger count = [weakSelf selectLessonOrderArr].count;
//                     [weakSelf.bottomBtn setTitle:[NSString stringWithFormat:@"下一步（%ld/%@）",(long)count,weakSelf.lessonModel.course_class_number] forState:UIControlStateNormal];
//                 }else{
//
//                 }
//                 return YES;
//             }
//             if (weakSelf.isEdit) {
//                 NSInteger count = [weakSelf selectLessonOrderArr].count;
//                 [weakSelf.bottomBtn setTitle:[NSString stringWithFormat:@"下一步（%ld/%@）",(long)count,weakSelf.lessonModel.course_class_number] forState:UIControlStateNormal];
//             }
//             [TLUIUtility showErrorHint:[NSString stringWithFormat:@"人数已达到上线（%@人）",weakSelf.lessonModel.course_class_number]];
//             return NO;
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
    [ZOriganizationStudentViewModel getStudentLessonFromList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    [ZOriganizationStudentViewModel getStudentLessonFromList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    
    [_param setObject:self.stores_courses_id forKey:@"stores_courses_id"];
    [_param setObject:SafeStr(self.name) forKey:@"search_name"];
}
@end
