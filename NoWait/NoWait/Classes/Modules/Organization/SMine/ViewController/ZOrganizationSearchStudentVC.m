//
//  ZOrganizationSearchStudentVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSearchStudentVC.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZOriganizationStudentListCell.h"

#import "ZOrganizationSendMessageVC.h"

@interface ZOrganizationSearchStudentVC ()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) UIButton *allBtn;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) UIView *bottomView;


@property (nonatomic,assign) BOOL isEdit;
@end

@implementation ZOrganizationSearchStudentVC


- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchType = kSearchHistoryStudentSearch;
    }
    return self;
}

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
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
}
//
//- (void)cancleBtnOnClick {
//    if (_isEdit) {
//        self.isEdit = NO;
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

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
    
//    [self selectDataEdit:isEdit];
}

#pragma mark - lazy loading
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
               [weakSelf deleteLesson:ids];
           }else{
               [TLUIUtility showErrorHint:@"你还没有选中"];
           }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
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


- (UIButton *)allBtn {
    if (!_allBtn) {
        __weak typeof(self) weakSelf = self;
        _allBtn = [[UIButton alloc] initWithFrame:CGRectZero];
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

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_bottomView addSubview:self.sendBtn];
        [_bottomView addSubview:self.bottomBtn];
        [_bottomView addSubview:self.allBtn];
        
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.bottomView);
            make.width.mas_equalTo(KScreenWidth/3.f);
        }];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.bottomView);
            make.left.equalTo(self.sendBtn.mas_right);
            make.width.mas_equalTo(KScreenWidth/3.f);
        }];
        
        [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self.bottomView);
            make.width.mas_equalTo(KScreenWidth/3.f);
        }];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        [self.bottomView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sendBtn.mas_right);
            make.centerY.equalTo(self.bottomView.mas_centerY);
            make.height.mas_equalTo(CGFloatIn750(26));
            make.width.mas_equalTo(2);
        }];
        {
            UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
            bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
            [self.bottomView addSubview:bottomLineView];
            [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bottomBtn.mas_right);
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.height.mas_equalTo(CGFloatIn750(26));
                make.width.mas_equalTo(2);
            }];
        }
    }
    return _bottomView;
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


#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    self.isEdit = YES;
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *model= self.dataSources[i];
        model.isEdit = YES;
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationStudentListCell className] title:[ZOriganizationStudentListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationStudentListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:progressCellConfig];
    }
//
//    if (self.cellConfigArr.count > 0) {
//        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
//    }else{
//        self.isEdit = NO;
//        self.safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
//    }
}

- (void)searchClick:(NSString *)text{
    [super searchClick:text];
    self.name = SafeStr(text);
    if (self.name.length > 0) {
        [self refreshData];
    }
}


- (void)selectAllData {
    
    if ([self getSelectedData].count == self.dataSources.count) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationStudentListModel *model = self.dataSources[i];
            model.isSelected = NO;
        }
        [self.allBtn setTitle:@"全选" forState:UIControlStateNormal];
    }else{
        for (int i = 0; i < self.dataSources.count; i++) {
            ZOriganizationStudentListModel *model = self.dataSources[i];
            model.isSelected = YES;
        }
        [self.allBtn setTitle:@"全不选" forState:UIControlStateNormal];
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
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
     [ZOriganizationStudentViewModel getStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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

- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    [self.iTableView endEditing:YES];
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOriganizationStudentListCell"]){
        ZOriganizationStudentListCell *enteryCell = (ZOriganizationStudentListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index) {
            [weakSelf.searchView.iTextField resignFirstResponder];
            if (weakSelf.isEdit) {
                if (index == 0) {
                    ZOriganizationStudentListModel *listmodel = cellConfig.dataModel;
                    routePushVC(ZRoute_org_studentDetail, listmodel.studentID, nil);
                }else if (index == 1){
                    
                }else if(index == 10){
                    [weakSelf selectData:indexPath.row];
                }
            }else{
                if (index == 0) {
                    ZOriganizationStudentListModel *listmodel = cellConfig.dataModel;
                    routePushVC(ZRoute_org_studentDetail, listmodel.studentID, nil);
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
    if ([self getSelectedData].count == self.dataSources.count) {
        [self.allBtn setTitle:@"全不选" forState:UIControlStateNormal];
    }else {
        [self.allBtn setTitle:[NSString stringWithFormat:@"全选(%ld)",[self getSelectedData].count] forState:UIControlStateNormal];
    }
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}
@end

