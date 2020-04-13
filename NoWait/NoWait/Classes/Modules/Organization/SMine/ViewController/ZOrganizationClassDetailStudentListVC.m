//
//  ZOrganizationClassDetailStudentListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassDetailStudentListVC.h"
#import "ZOriganizationClassStudentListCell.h"

#import "ZStudentMineSignDetailVC.h"
#import "ZOriganizationTopTitleView.h"
#import "ZOrganizationClassDetailStudentListAddVC.h"
#import "ZOriganizationClassViewModel.h"
#import "ZAlertView.h"
#import "ZTeacherSignStudentListBottomView.h"
#import "ZSignViewModel.h"

@interface ZOrganizationClassDetailStudentListVC ()
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) ZTeacherSignStudentListBottomView *bottomView;

@property (nonatomic,strong) ZOriganizationTopTitleView *topView;
@property (nonatomic,assign) BOOL isEdit;
@end

@implementation ZOrganizationClassDetailStudentListVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyDataStr = @"没有学员数据";
    self.isOpen = [self.model.status intValue] == 3 ? YES : NO;
    [self setNavigation];
    [self initCellConfigArr];
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    if (self.isOpen) {
        self.topView.titleArr = @[@"姓名", @"上课进度", @"签到详情"];
    }else{
        self.topView.titleArr = @[@"姓名", @"上课进度", @"签到详情" , @"操作"];
    }
    
    for (ZOriganizationStudentListModel *model in self.dataSources) {
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationClassStudentListCell className] title:@"ZOriganizationClassStudentListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationClassStudentListCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:textCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员列表"];
    
    if (self.isOpen) {
        [self.navigationItem setRightBarButtonItem:nil];
    }else{
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]] ;
    }
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    if (self.can_operation) {
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
            make.height.mas_equalTo(CGFloatIn750(90));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
         make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
         make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
         make.top.equalTo(self.topView.mas_bottom).offset(-CGFloatIn750(0));
        }];
    }else{
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
         make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
         make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
         make.top.equalTo(self.topView.mas_bottom).offset(-CGFloatIn750(0));
        }];
    }
    
    
}

#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(118), CGFloatIn750(50))];
        if (self.type == 2) {
            [_navLeftBtn setTitle:@"加入学员" forState:UIControlStateNormal];
        }else{
            [_navLeftBtn setTitle:@"多选" forState:UIControlStateNormal];
        }
        
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_navLeftBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        ViewRadius(_navLeftBtn, CGFloatIn750(25));
        [_navLeftBtn bk_whenTapped:^{
            if (self.type == 2) {
                ZOrganizationClassDetailStudentListAddVC *avc = [[ZOrganizationClassDetailStudentListAddVC alloc] init];
                avc.model = weakSelf.model;
                [weakSelf.navigationController pushViewController:avc animated:YES];
            }else{
                weakSelf.isEdit = !weakSelf.isEdit;
                [weakSelf changeType:weakSelf.isEdit];
                if (weakSelf.isEdit) {
                    [weakSelf.navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
                }else{
                    [weakSelf.navLeftBtn setTitle:@"多选" forState:UIControlStateNormal];
                }
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }
            
        }];
    }
    return _navLeftBtn;
}

- (ZOriganizationTopTitleView *)topView {
    if (!_topView) {
        _topView = [[ZOriganizationTopTitleView alloc] init];
    }
    return _topView;
}

- (ZTeacherSignStudentListBottomView *)bottomView {
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ZTeacherSignStudentListBottomView alloc] init];
        _bottomView.handleBlock = ^(NSInteger index) {
            [weakSelf teacherSign:index];
        };
    }
    return _bottomView;
}


- (void)teacherSign:(NSInteger)index {
    NSMutableDictionary *param = @{}.mutableCopy;
    if (self.listModel) {
        [param setObject:self.listModel.classID forKey:@"courses_class_id"];
    }
    
    if (self.model) {
        [param setObject:self.model.classID forKey:@"courses_class_id"];
    }
    
    if (index == 0) {
        [param setObject:@"2" forKey:@"type"];
    }else if (index == 1){
        [param setObject:@"4" forKey:@"type"];
    }else if (index == 2){
        [param setObject:@"5" forKey:@"type"];
    }else if (index == 3){
        [param setObject:@"3" forKey:@"type"];
    }
    
    
    
    NSMutableArray *ids = @[].mutableCopy;
    NSArray *studentlist = [self selectLessonOrderArr];
    
    
    if (studentlist.count == 0) {
        
        [TLUIUtility showErrorHint:@"您还没有选择学员"];
        return;
    }
    
    for (ZOriganizationStudentListModel *studentModel in studentlist) {
        [ids addObject:@{@"student_id":studentModel.studentID,@"course_num":SafeStr(studentModel.nums)}];
    }
    [param setObject:ids forKey:@"students"];
    [ZSignViewModel teacherSign:param completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess) {
            [TLUIUtility showSuccessHint:data];
            [self refreshData];
        }else{
            [TLUIUtility showErrorHint:data];
        }
    }];
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOriganizationClassStudentListCell"]) {
        ZOriganizationClassStudentListCell *lcell = (ZOriganizationClassStudentListCell *)cell;
        lcell.isOpen = self.isOpen;
        lcell.handleBlock = ^(NSInteger index,ZOriganizationStudentListModel *model) {
            if (index == 0) {
                ZStudentMineSignDetailVC *dvc = [[ZStudentMineSignDetailVC alloc] init];
                dvc.courses_class_id = self.model.classID;
                dvc.student_id = model.studentID;
                dvc.type = self.type;
//                dvc.stores_id = model.studentID;
                [self.navigationController pushViewController:dvc animated:YES];
            }else if(index == 1){
                //out
                [ZAlertView setAlertWithTitle:@"小提醒" subTitle:[NSString stringWithFormat:@"确定将\"%@\"移除班级",model.name] leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:^(NSInteger index) {
                    if (index == 1) {
                        [weakSelf deleteStudent:model];
                    }
                }];
            }
        };
    }
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

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationClassViewModel getClassStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
     [ZOriganizationClassViewModel getClassStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    if (self.listModel) {
        [param setObject:self.listModel.course_id forKey:@"stores_id"];
        [param setObject:self.listModel.classID forKey:@"courses_class_id"];
    }else if (self.model){
        [param setObject:self.model.stores_id forKey:@"stores_id"];
        [param setObject:self.model.classID forKey:@"courses_class_id"];
    }
   
    return param;
}


- (void)deleteStudent:(ZOriganizationStudentListModel *)model {
    __weak typeof(self) weakSelf = self;
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel delClassStudent:@{@"courses_class_id":SafeStr(self.model.classID),@"stores_id":SafeStr([ZUserHelper sharedHelper].school.schoolID ),@"student_ids":@[SafeStr(model.studentID)]} completeBlock:^(BOOL isSuccess, NSString *message) {
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
