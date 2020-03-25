//
//  ZOrganizationClassDetailStudentListAddListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationClassDetailStudentListAddListVC.h"
#import "ZOriganizationStudentListCell.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZOrganizationStudentDetailVC.h"

@interface ZOrganizationClassDetailStudentListAddListVC ()
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZOrganizationClassDetailStudentListAddListVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewEmptyDataDelegate];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
}

- (void)setDataSource {
    [super setDataSource];
    self.param = @{}.mutableCopy;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (ZOriganizationStudentListModel *model in self.dataSources) {
        model.isEdit = YES;
        ZCellConfig *textCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationStudentListCell className] title:[ZOriganizationStudentListCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZOriganizationStudentListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:textCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"学员列表"];
}

- (void)setupMainView {
    [super setupMainView];
    
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(140));
        make.left.bottom.right.equalTo(self.view);
    }];
    [bottomView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(bottomView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
     make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
     make.bottom.equalTo(bottomView.mas_top).offset(-CGFloatIn750(0));
     make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(1));
    }];
}

#pragma mark lazy loading...
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = CGFloatIn750(40);
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if ([weakSelf getSelectedData] > 0) {
                [weakSelf addStudent];
            }else{
                [TLUIUtility showInfoHint:@"您还没有选择学员"];
            }
        }];
    }
    return _bottomBtn;
}


#pragma mark - tableView -------datasource-----
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZOriganizationStudentListCell"]){
        ZOriganizationStudentListCell *enteryCell = (ZOriganizationStudentListCell *)cell;
        enteryCell.handleBlock = ^(NSInteger index) {
            if (index == 0) {
               [weakSelf selectData:indexPath.row];
            }else if (index == 1){
//                weakSelf.isEdit = YES;
            }
        };
    }
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
    [_param setObject:SafeStr(self.model.courses_id) forKey:@"stores_courses_id"];
    [_param setObject:[NSString stringWithFormat:@"%ld",(long)self.type] forKey:@"type"];
}



- (void)addStudent{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:SafeStr(self.model.classID) forKey:@"courses_class_id"];
    [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
                             
    NSMutableArray *studentArr = @[].mutableCopy;
    NSArray *temp = [self getSelectedData];
    for (ZOriganizationStudentListModel *model in temp) {
        [studentArr addObject:SafeStr(model.studentID)];
    }
                        
    [params setObject:studentArr forKey:@"student_ids"];
    
    [TLUIUtility showLoading:@""];
    [ZOriganizationClassViewModel addClassStudent:params completeBlock:^(BOOL isSuccess, NSString *message) {
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
