//
//  ZOrganizationTeacherSearchVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//
#import "ZOrganizationTeacherSearchVC.h"

#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeacherViewModel.h"

#import "ZOrganizationTeacherDetailVC.h"

@interface ZOrganizationTeacherSearchVC ()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *allBtn;
@property (nonatomic,assign) BOOL isEdit;
@end

@implementation ZOrganizationTeacherSearchVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.searchView.iTextField && self.searchView.iTextField.text.length == 0) {
        [self.searchView.iTextField becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = NO;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
        make.top.equalTo(self.view.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    self.isEdit = YES;
    
    [self setTableViewEmptyDataDelegate];
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self.iTableView reloadData];
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (isEdit) {
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.bottom.equalTo(self.view.mas_bottom).offset(CGFloatIn750(-safeAreaBottom()));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
            make.top.equalTo(self.searchView.mas_bottom).offset(0);
        }];
    }else{
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.top.equalTo(self.view.mas_bottom).offset(CGFloatIn750(safeAreaBottom()));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
            make.top.equalTo(self.searchView.mas_bottom).offset(0);
        }];
    }
    
    [self selectDataEdit:isEdit];
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _bottomView.layer.masksToBounds = YES;
        [_bottomView addSubview:self.bottomBtn];
        [_bottomView addSubview:self.allBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.bottomView);
            make.right.equalTo(self.bottomView.mas_centerX).offset(0);
        }];
        
        [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self.bottomView);
            make.left.equalTo(self.bottomView.mas_centerX).offset(0);
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
    }
    return _bottomView;
}
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_addEventHandler:^(id sender) {
            NSArray *ids = [weakSelf getSelectedData];
            if (ids && ids.count > 0) {
                [weakSelf deleteTeacher:ids];
            }else{
                [TLUIUtility showErrorHint:@"你还没有选中"];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}


- (UIButton *)allBtn {
    if (!_allBtn) {
        __weak typeof(self) weakSelf = self;
        _allBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_allBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_allBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_allBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_allBtn bk_addEventHandler:^(id sender) {
            [weakSelf selectAllData];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _allBtn;
}

#pragma mark - fun
- (NSMutableArray *)getSelectedData {
    NSMutableArray *temp = @[].mutableCopy;
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationTeacherListModel *model = self.dataSources[i];
        if (model.isSelected) {
            [temp addObject:model];
        }
    }
    return temp;
}

- (void)selectAllData {
    if (!_isEdit) {
        return;
    }
    if ([self getSelectedData].count == self.dataSources.count) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationTeacherListModel *model = self.dataSources[i];
            model.isSelected = NO;
        }
        [self.allBtn setTitle:@"全选" forState:UIControlStateNormal];
    }else{
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationTeacherListModel *model = self.dataSources[i];
            model.isSelected = YES;
        }
        [self.allBtn setTitle:@"全不选" forState:UIControlStateNormal];
    }
}


- (void)deleteTeacher:(NSArray <ZOriganizationTeacherListModel *>*)studentArr {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *params = @[].mutableCopy;
    for (ZOriganizationTeacherListModel *model in studentArr) {
//        NSMutableDictionary *para = @{}.mutableCopy;
        if (model && model.teacherID) {
            [params addObject:model.teacherID];
        }
    }
    [TLUIUtility showLoading:@""];
    [ZOriganizationTeacherViewModel deleteTeacher:@{@"ids":params} completeBlock:^(BOOL isSuccess, NSString *message) {
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
        ZOriganizationTeacherListModel *model = self.dataSources[i];
        model.isEdit = YES;
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachListCell className] title:[ZOriganizationTeachListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationTeachListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

-(void)searchClick:(NSString *)text {
    [super searchClick:text];
    self.name = SafeStr(text);
    if (self.name.length > 0) {
        [self refreshData];
    }
}

#pragma mark - tableview
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    [self.iTableView endEditing:YES];
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOriganizationTeachListCell"]){
        ZOriganizationTeachListCell *enteryCell = (ZOriganizationTeachListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index) {
            [weakSelf.searchView.iTextField resignFirstResponder];
            if (weakSelf.isEdit) {
                if (index == 0) {
                    
                    ZOriganizationTeacherListModel *listmodel = cellConfig.dataModel;
                    ZOrganizationTeacherDetailVC *dvc = [[ZOrganizationTeacherDetailVC alloc] init];
                    dvc.addModel.account_id = listmodel.account_id;
                    dvc.addModel.c_level = listmodel.c_level;
                    dvc.addModel.teacherID = listmodel.teacherID;
                    dvc.addModel.image = listmodel.image;
                    dvc.addModel.nick_name = listmodel.nick_name;
                    dvc.addModel.phone = listmodel.phone;
                    dvc.addModel.position = listmodel.position;
                    dvc.addModel.real_name = listmodel.teacher_name;
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }else if (index == 1){
                    
                }else if (index == 10){
                    [weakSelf selectData:indexPath.row];
                }
            }else{
                if (index == 0) {
                    ZOriganizationTeacherListModel *listmodel = cellConfig.dataModel;
                    ZOrganizationTeacherDetailVC *dvc = [[ZOrganizationTeacherDetailVC alloc] init];
                    dvc.addModel.account_id = listmodel.account_id;
                    dvc.addModel.c_level = listmodel.c_level;
                    dvc.addModel.teacherID = listmodel.teacherID;
                    dvc.addModel.image = listmodel.image;
                    dvc.addModel.nick_name = listmodel.nick_name;
                    dvc.addModel.phone = listmodel.phone;
                    dvc.addModel.position = listmodel.position;
                    dvc.addModel.real_name = listmodel.teacher_name;
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }else if (index == 1){
                    weakSelf.isEdit = YES;
                }
            }
        };
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
    [ZOriganizationTeacherViewModel getTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
     [ZOriganizationTeacherViewModel getTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
       [param setObject:SafeStr(self.name) forKey:@"name"];
    return param;
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
    [self.allBtn setTitle:[NSString stringWithFormat:@"全选(%ld)",[self getSelectedData].count] forState:UIControlStateNormal];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end

