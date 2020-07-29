//
//  ZOrganizationTeacherManageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTeacherManageVC.h"
#import "ZOrganizationTeacherSearchVC.h"
#import "ZOrganizationTeacherAddVC.h"

#import "ZOriganizationTeachListCell.h"
#import "ZOriganizationTeachSearchTopHintView.h"

#import "ZOrganizationTeacherDetailVC.h"

@interface ZOrganizationTeacherManageVC ()
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,strong) NSString *total;

@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UILabel *totalLabel;

@property (nonatomic,strong) ZOriganizationTeachSearchTopHintView *searchTopView;

@end

@implementation ZOrganizationTeacherManageVC

#pragma mark - vc delegate
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"教师管理")
    .zChain_setTableViewWhite()
    .zChain_addLoadMoreFooter()
    .zChain_addRefreshHeader()
    .zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshHeaderNet(^{
        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
        [weakSelf refreshMoreData];
    }).zChain_updateDataSource(^{
        self.loading = YES;
        self.param = @{}.mutableCopy;
    }).zChain_resetMainView(^{
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn]];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
        
        [self.view addSubview:self.searchTopView];
        [self.searchTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(126));
        }];
        
        [self.view addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.top.equalTo(self.view.mas_bottom).offset(CGFloatIn750(20));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
            make.top.equalTo(self.searchTopView.mas_bottom).offset(-CGFloatIn750(20));
        }];
        
        self.iTableView.tableHeaderView = self.headView;
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
//        {
//            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(@"line")
//            .zz_lineHidden(YES)
//            .zz_titleLeft([NSString stringWithFormat:@"共:%@名教师",ValidStr(self.total)? self.total:@"0"])
//            .zz_fontLeft([UIFont fontContent])
//            .zz_colorLeft([UIColor colorMain])
//            .zz_marginLeft(CGFloatIn750(50))
//            .zz_colorDarkLeft([UIColor colorMain])
//            .zz_cellHeight(CGFloatIn750(80));
//
//             ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
//
//             [self.cellConfigArr  addObject:menuCellConfig];
//        }
        self.totalLabel.text = [NSString stringWithFormat:@"共:%@名教师",ValidStr(self.total)? self.total:@"0"];
       for (int i = 0; i < weakSelf.dataSources.count; i++) {
           ZOriganizationTeacherListModel *model = weakSelf.dataSources[i];
           model.isEdit = weakSelf.isEdit;
           ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachListCell className] title:[ZOriganizationTeachListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationTeachListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:weakSelf.dataSources[i]];
           [weakSelf.cellConfigArr addObject:progressCellConfig];
       }
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZOriganizationTeachListCell"]){
            ZOriganizationTeachListCell *enteryCell = (ZOriganizationTeachListCell *)cell;
            enteryCell.handleBlock = ^(NSInteger index) {
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
                        
                    }else if(index == 10){
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
    });
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.isEdit = NO;
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (isEdit) {
        _navRightBtn.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        [_navRightBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setImage:nil forState:UIControlStateNormal];
        

        [self.bottomBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.bottom.equalTo(self.view.mas_bottom).offset(CGFloatIn750(-safeAreaBottom()));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.bottomBtn.mas_top).offset(-CGFloatIn750(0));
            make.top.equalTo(self.searchTopView.mas_bottom).offset(-CGFloatIn750(20));
        }];
    }else{
        [_navRightBtn setTitle:@"添加" forState:UIControlStateNormal];
        _navRightBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_navRightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        
        [_navLeftBtn setTitle:@"   " forState:UIControlStateNormal];
        [_navLeftBtn setImage:[UIImage imageNamed:isDarkModel() ? @"navleftBackDark":@"navleftBack"] forState:UIControlStateNormal];
        
        [self.bottomBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(CGFloatIn750(88));
            make.top.equalTo(self.view.mas_bottom).offset(CGFloatIn750(safeAreaBottom()));
        }];
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
            make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
            make.top.equalTo(self.searchTopView.mas_bottom).offset(-CGFloatIn750(20));
        }];
    }
    
    [self selectDataEdit:isEdit];
}


#pragma mark - lazy loading...
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        __weak typeof(self) weakSelf = self;
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navLeftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:[UIFont fontContent]];
        [_navLeftBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.isEdit) {
                weakSelf.isEdit = NO;
            }else{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navLeftBtn;
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
                
                weakSelf.zChain_reload_ui();
            }else{
                ZOrganizationTeacherAddVC *avc = [[ZOrganizationTeacherAddVC alloc] init];
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
        _searchTopView.hint = @"搜索教师";
        _searchTopView.handleBlock = ^(NSInteger index) {
            ZOrganizationTeacherSearchVC *svc = [[ZOrganizationTeacherSearchVC alloc] init];
            svc.navTitle = @"搜索教师";
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
    }
    return _searchTopView;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
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


-(UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(80))];
        _headView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _totalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _totalLabel.textColor = [UIColor colorMain];
        _totalLabel.text = @"";
        _totalLabel.numberOfLines = 0;
        _totalLabel.textAlignment = NSTextAlignmentLeft;
        [_totalLabel setFont:[UIFont fontContent]];
        [_headView addSubview:_totalLabel];
        [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView.mas_left).offset(CGFloatIn750(30));
            make.centerY.equalTo(self.headView.mas_centerY);
        }];
    }
    return _headView;
}



- (void)selectDataEdit:(BOOL)isEdit {
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationTeacherListModel *model = self.dataSources[i];
        model.isEdit = isEdit;
    }
    
    self.zChain_reload_ui();
}

- (void)selectData:(NSInteger)index {
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationTeacherListModel *model = self.dataSources[i];
        if (i == index) {
            model.isSelected = !model.isSelected;
        }
    }
    
    self.zChain_reload_ui();
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
            ZOriganizationTeacherListModel *model = self.dataSources[i];
            model.isSelected = NO;
        }
        [_navRightBtn setTitle:@"全选" forState:UIControlStateNormal];
    }else{
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationTeacherListModel *model = self.dataSources[i];
            model.isSelected = YES;
        }
        [_navRightBtn setTitle:@"全不选" forState:UIControlStateNormal];
    }
    
    self.zChain_reload_ui();
}

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

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:_param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationTeacherViewModel getTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.total = data.total;
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            
            self.zChain_reload_ui();
            
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
    [ZOriganizationTeacherViewModel getTeacherList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            weakSelf.total = data.total;
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

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [_navLeftBtn setImage:[UIImage imageNamed:isDarkModel() ? @"navleftBackDark":@"navleftBack"] forState:UIControlStateNormal];
}
@end
