//
//  ZOrganizationStudentManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentManageVC.h"
#import "ZOrganizationSearchStudentVC.h"
#import "ZOrganizationStudentDetailVC.h"
#import "ZOrganizationStudentAddVC.h"

#import "ZOriganizationStudentListCell.h"

#import "ZAlertDataModel.h"
#import "ZAlertDataPickerView.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZAlertMoreView.h"
#import "ZOrganizationSendMessageVC.h"

@interface ZOrganizationStudentManageVC ()
@property (nonatomic,copy) NSString *total;

@end

@implementation ZOrganizationStudentManageVC

#pragma mark - vc delegate
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self setTableViewGaryBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
    self.isEdit = NO;
}

- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
    _total = @"0";
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    {
        ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"line")
        .zz_lineHidden(YES)
        .zz_titleLeft([NSString stringWithFormat:@"共:%@名学员",self.total])
        .zz_fontLeft([UIFont fontContent])
        .zz_colorLeft([UIColor colorMain])
        .zz_marginLeft(CGFloatIn750(50))
        .zz_colorDarkLeft([UIColor colorMain])
        .zz_cellHeight(CGFloatIn750(80));
        
         ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

         [self.cellConfigArr  addObject:menuCellConfig];
    }
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *model = self.dataSources[i];
        model.isEdit = self.isEdit;
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationStudentListCell className] title:[ZOriganizationStudentListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationStudentListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员管理"];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (isEdit) {
        _navRightBtn.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        [_navRightBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setImage:nil forState:UIControlStateNormal];
        

        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.bottom.equalTo(self.view.mas_bottom).offset(CGFloatIn750(-safeAreaBottom()));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
            make.top.equalTo(self.filterView.mas_bottom).offset(-CGFloatIn750(20));
        }];
    }else{
        [_navRightBtn setTitle:@"添加" forState:UIControlStateNormal];
        _navRightBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_navRightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        
        [_navLeftBtn setTitle:@"" forState:UIControlStateNormal];
        [_navLeftBtn setImage:[UIImage imageNamed:isDarkModel() ? @"navleftBackDark":@"navleftBack"] forState:UIControlStateNormal];
        
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.top.equalTo(self.view.mas_bottom).offset(CGFloatIn750(safeAreaBottom()));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
            make.top.equalTo(self.filterView.mas_bottom).offset(-CGFloatIn750(20));
        }];
    }
    
    [self selectDataEdit:isEdit];
}

- (void)setupMainView {
    [super setupMainView];
    
//    [self.view addSubview:self.switchView];
//    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(self.view);
//        make.height.mas_equalTo(CGFloatIn750(126));
//    }];
    
    [self.view addSubview:self.searchTopView];
    [self.searchTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(126));
    }];
    
    [self.view addSubview:self.filterView];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchTopView.mas_bottom).offset(CGFloatIn750(0));
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(106));
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.sendBtn];
    [self.bottomView addSubview:self.deleteBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_centerX);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView.mas_centerX);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
    [self.bottomView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView.mas_centerX);
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(26));
        make.width.mas_equalTo(2);
    }];
   
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
        make.top.equalTo(self.view.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
        make.top.equalTo(self.filterView.mas_bottom).offset(-CGFloatIn750(20));
    }];
}

#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(80), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            [weakSelf leftBtnOnClick];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
}

- (void)leftBtnOnClick {
    if (self.isEdit) {
        self.isEdit = NO;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        _navRightBtn.layer.masksToBounds = YES;
        _navRightBtn.layer.cornerRadius = CGFloatIn750(25);
        _navRightBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_navRightBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
        [_navRightBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.isEdit) {
                [weakSelf selectAllData];
                [weakSelf initCellConfigArr];
                [weakSelf.iTableView reloadData];
            }else{
                ZOrganizationStudentAddVC *avc = [[ZOrganizationStudentAddVC alloc] init];
                [weakSelf.navigationController pushViewController:avc animated:YES];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}

- (ZOriganizationTeachSearchTopHintView *)searchTopView {
    if (!_searchTopView) {
        __weak typeof(self) weakSelf = self;
        _searchTopView = [[ZOriganizationTeachSearchTopHintView alloc] init];
        _searchTopView.hint = @"搜索学员";
        _searchTopView.handleBlock = ^(NSInteger index) {
            ZOrganizationSearchStudentVC *svc = [[ZOrganizationSearchStudentVC alloc] init];
            svc.navTitle = @"搜索学员";
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
    }
    return _searchTopView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        __weak typeof(self) weakSelf = self;
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:[UIFont fontContent]];
        [_deleteBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_deleteBtn bk_addEventHandler:^(id sender) {
            NSArray *ids = [weakSelf getSelectedData];
            if (ids && ids.count > 0) {
                [weakSelf deleteLesson:ids];
            }else{
                [TLUIUtility showErrorHint:@"你还没有选中"];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}


- (UIButton *)sendBtn {
    if (!_sendBtn) {
        __weak typeof(self) weakSelf = self;
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sendBtn setTitle:@"发通知" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:[UIFont fontContent]];
        [_sendBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_sendBtn bk_addEventHandler:^(id sender) {
            NSArray *ids = [weakSelf getSelectedData];
            if (ids && ids.count > 0) {
                ZOrganizationSendMessageVC *mvc = [[ZOrganizationSendMessageVC alloc] init];
                mvc.type = @"2";
                mvc.storesName = [ZUserHelper sharedHelper].school.name;
                mvc.studentList = [[NSMutableArray alloc] initWithArray:ids];
                [weakSelf.navigationController pushViewController:mvc animated:YES];
            }else{
                [TLUIUtility showErrorHint:@"你还没有选中"];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    return _bottomView;
}


- (ZOrganizationStudentTopFilterSeaarchView *)filterView {
    if (!_filterView) {
        __weak typeof(self) weakSelf = self;
        _filterView = [[ZOrganizationStudentTopFilterSeaarchView alloc] init];
        _filterView.schoolID = [ZUserHelper sharedHelper].school.schoolID;
        _filterView.filterBlock = ^(NSInteger index, id data) {
            if (index == 1) {
                if (data) {
                    NSInteger tIndex = 0;
//                    0:全部 1：待排课 2：待开课 3：已开课 4：已结课 5：待补课 6：已过期
                    NSArray *titleArr = @[@"全部",@"待排课",@"待开课",@"已开课",@"已结课",@"待补课",@"已过期"];
                    if (ValidStr(data)) {
                        [weakSelf.filterView setLeftName:nil right:SafeStr(data)];
                        NSString *str = SafeStr(data);
                        for (int i = 0; i < titleArr.count; i++) {
                            if ([titleArr[i] isEqualToString:str]) {
                                tIndex = i;
                            }
                        }
                    }
                    
                    if (tIndex == 0) {
                        [weakSelf.param removeObjectForKey:@"status"];
                    }else{
                        [weakSelf.param setObject:[NSString stringWithFormat:@"%ld",tIndex] forKey:@"status"];
                    }
                    [weakSelf refreshData];
                }
            }else if (index == 0){
                if (data) {
                    if ([data isKindOfClass:[ZOriganizationTeacherListModel class]]) {
                        ZOriganizationTeacherListModel *model = data;
                        NSString *tIndex;
                        [weakSelf.filterView setLeftName:model.teacher_name right:nil];
                        tIndex = model.teacherID;
                        
                        if (tIndex == 0) {
                            [weakSelf.param removeObjectForKey:@"teacher_id"];
                        }else{
                            [weakSelf.param setObject:tIndex forKey:@"teacher_id"];
                        }
                        [weakSelf refreshData];
                    }
                }
            }
        };
    }
    return _filterView;
}


#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOriganizationStudentListCell"]){
        ZOriganizationStudentListCell *enteryCell = (ZOriganizationStudentListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index) {
            if (weakSelf.isEdit) {
                if (index == 0) {
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
                    
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }else if (index == 1){
                    
                }else if(index == 10){
                    [weakSelf selectData:indexPath.row];
                }
            }else{
                if (index == 0) {
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
                    
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }else if (index == 1){
                    weakSelf.isEdit = YES;
                }
            }
        };
        
    }
}



- (void)selectDataEdit:(BOOL)isEdit {
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *model = self.dataSources[i];
        model.isEdit = isEdit;
    }
    [self initCellConfigArr];
    [self.iTableView reloadData];
    
}

- (void)selectData:(NSInteger)index {
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *model = self.dataSources[i];
        if (i == index) {
            model.isSelected = !model.isSelected;
        }
    }
    [self initCellConfigArr];
    [self.iTableView reloadData];
    if ([self getSelectedData].count == self.dataSources.count) {
        [_navRightBtn setTitle:@"全不选" forState:UIControlStateNormal];
    }else{
        [_navRightBtn setTitle:@"全选" forState:UIControlStateNormal];
    }
}

- (void)selectAllData {
    if (!_isEdit) {
        return;
    }
    if ([self getSelectedData].count == self.dataSources.count) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationStudentListModel *model = self.dataSources[i];
            model.isSelected = NO;
        }
        [_navRightBtn setTitle:@"全选" forState:UIControlStateNormal];
    }else{
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationStudentListModel *model = self.dataSources[i];
            model.isSelected = YES;
        }
        [_navRightBtn setTitle:@"全不选" forState:UIControlStateNormal];
    }
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (NSMutableArray *)getSelectedData {
    NSMutableArray *temp = @[].mutableCopy;
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *model = self.dataSources[i];
        if (model.isSelected) {
            [temp addObject:model];
        }
    }
    return temp;
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
            weakSelf.total = data.total;
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
            weakSelf.total = data.total;
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
}



- (void)deleteLesson:(NSArray <ZOriganizationStudentListModel *>*)studentArr {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *params = @[].mutableCopy;
    for (ZOriganizationStudentListModel *model in studentArr) {
//        NSMutableDictionary *para = @{}.mutableCopy;
        if (model && model.studentID) {
            [params addObject:model.studentID];
        }
    }
    [TLUIUtility showLoading:@""];
    [ZOriganizationStudentViewModel deleteStudent:@{@"ids":params} completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [TLUIUtility showSuccessHint:message];
            [weakSelf refreshAllData];
        }else{
            [TLUIUtility showErrorHint:message];
        };
    }];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [_navLeftBtn setImage:[UIImage imageNamed:isDarkModel() ? @"navleftBackDark":@"navleftBack"] forState:UIControlStateNormal];
}
@end
