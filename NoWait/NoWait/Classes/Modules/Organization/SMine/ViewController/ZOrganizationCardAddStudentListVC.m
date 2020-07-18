//
//  ZOrganizationCardAddStudentListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardAddStudentListVC.h"
#import "ZOrganizationSearchStudentVC.h"

#import "ZAlertDataModel.h"
#import "ZAlertDataPickerView.h"
#import "ZOriganizationStudentViewModel.h"
#import "ZAlertMoreView.h"
#import "ZOrganizationSendMessageVC.h"
#import "ZOrganizationCardAddStudentSearchListVC.h"

#import "ZOrganizationStudentTopFilterSeaarchView.h"
#import "ZOrganizationLessonTopSearchView.h"
#import "ZOriganizationModel.h"


@interface ZOrganizationCardAddStudentListVC ()
@property (nonatomic,strong) UIButton *navRightBtn;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) NSMutableDictionary *param;

//@property (nonatomic,strong) ZOrganizationStudentTopFilterSeaarchView *filterView;
@property (nonatomic,strong) ZOrganizationLessonTopSearchView *searchBtn;

@end

@implementation ZOrganizationCardAddStudentListVC

#pragma mark - vc delegate
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loading = YES;
    [self setTableViewWhiteBack];
    [self setTableViewRefreshHeader];
    [self setTableViewRefreshFooter];
    [self setTableViewEmptyDataDelegate];
}

- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZOriganizationStudentListModel *model = self.dataSources[i];
        ZLineCellModel *sModel = ZLineCellModel.zz_lineCellModel_create(@"stuentTitle")
        .zz_titleLeft([NSString stringWithFormat:@"%@ %@",model.name,model.phone])
        .zz_imageLeft(model.image)
        .zz_cellHeight(CGFloatIn750(90))
        .zz_imageLeftRadius(YES)
        .zz_imageLeftHeight(CGFloatIn750(60))
        .zz_imageRightHeight(CGFloatIn750(30))
        .zz_imageRight(model.isSelected ? @"selectedCycle":@"unSelectedCycle");
        
        ZCellConfig *titleCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:sModel.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:sModel] cellType:ZCellTypeClass dataModel:sModel];
        
        [self.cellConfigArr addObject:titleCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"选择学员"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];
}

- (void)setupMainView {
    [super setupMainView];

    [self setTableViewWhiteBack];
    
    [self.view addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(78));
    }];
    
//    [self.view addSubview:self.filterView];
//    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.searchBtn.mas_bottom).offset(CGFloatIn750(0));
//        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
//        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
//        make.height.mas_equalTo(CGFloatIn750(106));
//    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.sendBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.bottomView);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(self.view.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.bottomView.mas_top).offset(-CGFloatIn750(0));
        make.top.equalTo(self.searchBtn.mas_bottom).offset(CGFloatIn750(20));
    }];
}

#pragma mark - lazy loading...
- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        __weak typeof(self) weakSelf = self;
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
        [_navRightBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:[UIFont fontContent]];
        [_navRightBtn bk_addEventHandler:^(id sender) {
            [weakSelf selectAllData];
            [weakSelf initCellConfigArr];
            [weakSelf.iTableView reloadData];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _navRightBtn;
}

- (ZOrganizationLessonTopSearchView *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [[ZOrganizationLessonTopSearchView alloc] init];
        _searchBtn.title = @"搜索学员";
        __weak typeof(self) weakSelf = self;
        _searchBtn.handleBlock = ^{
            ZOrganizationCardAddStudentSearchListVC *svc = [[ZOrganizationCardAddStudentSearchListVC alloc] init];
            svc.title = @"搜索学员";
            svc.handleBlock = weakSelf.handleBlock;
            svc.studentArr = weakSelf.studentArr;
            [weakSelf.navigationController pushViewController:svc animated:YES];
        };
    }
    return _searchBtn;
}


- (UIButton *)sendBtn {
    if (!_sendBtn) {
        __weak typeof(self) weakSelf = self;
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sendBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:[UIFont fontContent]];
        [_sendBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_sendBtn bk_addEventHandler:^(id sender) {
            NSArray *ids = [weakSelf getSelectedData];
            if (ids && ids.count > 0) {
                if (weakSelf.handleBlock) {
                    weakSelf.handleBlock(ids);
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
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

//
//- (ZOrganizationStudentTopFilterSeaarchView *)filterView {
//    if (!_filterView) {
//        __weak typeof(self) weakSelf = self;
//        _filterView = [[ZOrganizationStudentTopFilterSeaarchView alloc] init];
//        _filterView.schoolID = [ZUserHelper sharedHelper].school.schoolID;
//        _filterView.filterBlock = ^(NSInteger index, id data) {
//            if (index == 1) {
//                if (data) {
//                    NSInteger tIndex = 0;
////                    0:全部 1：待排课 2：待开课 3：已开课 4：已结课 5：待补课 6：已过期
//                    NSArray *titleArr = @[@"全部",@"待排课",@"待开课",@"已开课",@"已结课",@"待补课",@"已过期"];
//                    if (ValidStr(data)) {
//                        [weakSelf.filterView setLeftName:nil right:SafeStr(data)];
//                        NSString *str = SafeStr(data);
//                        for (int i = 0; i < titleArr.count; i++) {
//                            if ([titleArr[i] isEqualToString:str]) {
//                                tIndex = i;
//                            }
//                        }
//                    }
//
//                    if (tIndex == 0) {
//                        [weakSelf.param removeObjectForKey:@"status"];
//                    }else{
//                        [weakSelf.param setObject:[NSString stringWithFormat:@"%ld",tIndex] forKey:@"status"];
//                    }
//                    [weakSelf refreshData];
//                }
//            }else if (index == 0){
//                if (data) {
//                    if ([data isKindOfClass:[ZOriganizationTeacherListModel class]]) {
//                        ZOriganizationTeacherListModel *model = data;
//                        NSString *tIndex;
//                        [weakSelf.filterView setLeftName:model.teacher_name right:nil];
//                        tIndex = model.teacherID;
//
//                        if (tIndex == 0) {
//                            [weakSelf.param removeObjectForKey:@"teacher_id"];
//                        }else{
//                            [weakSelf.param setObject:tIndex forKey:@"teacher_id"];
//                        }
//                        [weakSelf refreshData];
//                    }
//                }
//            }
//        };
//    }
//    return _filterView;
//}

#pragma mark - tableView -------datasource-----
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

#pragma mark - tableView datasource
-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"stuentTitle"]) {
        [self selectData:indexPath.row];
    }
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
    [ZOriganizationStudentViewModel getCartStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    [ZOriganizationStudentViewModel getCartStudentList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationStudentListNetModel *data) {
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
    
    if (ValidArray(self.studentArr)) {
        NSMutableArray *students = @[].mutableCopy;
        for (int i = 0; i < self.studentArr.count; i++) {
            ZOriganizationStudentListModel *model = self.studentArr[i];
            [students addObject:model.code_id];
        }
        [_param setObject:students forKey:@"student"];
    }
    
}

@end
