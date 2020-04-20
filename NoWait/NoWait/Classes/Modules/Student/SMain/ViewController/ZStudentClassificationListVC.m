//
//  ZStudentClassificationListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentClassificationListVC.h"
#import "ZStudentMainModel.h"
#import "ZStudentMainOrganizationListCell.h"
#import "ZStudentClassFiltrateSectionView.h"
#import "ZStudentMainViewModel.h"

#import "ZStudentOrganizationDetailDesVC.h"

@interface ZStudentClassificationListVC ()
@property (nonatomic,strong) ZStudentClassFiltrateSectionView *sectionView;
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZStudentClassificationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshData];
    [self setTableViewRefreshFooter];
    [self setTableViewRefreshHeader];
    [self setTableViewEmptyDataDelegate];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    
    [self.navigationItem setTitle:self.vcTitle];
}

- (void)setDataSource {
    [super setDataSource];
    _param = @{}.mutableCopy;
    self.loading = YES;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *orCellCon1fig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationListCell className] title:@"ZStudentMainOrganizationListCell" showInfoMethod:@selector(setModel:) heightOfCell:[ZStudentMainOrganizationListCell z_getCellHeight:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        [self.cellConfigArr addObject:orCellCon1fig];
    }
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.sectionView];
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.sectionView.mas_bottom);
    }];
}
#pragma mark - lazy loading
- (ZStudentClassFiltrateSectionView *)sectionView {
    if (!_sectionView) {
//        __weak typeof(self) weakSelf = self;
        _sectionView = [[ZStudentClassFiltrateSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        _sectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayLine]);
        _sectionView.titleSelect = ^(NSInteger index) {
            
        };
    }
    return _sectionView;
}

#pragma mark - tableview delegate
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMainOrganizationListCell"]) {
        ZStudentOrganizationDetailDesVC *dvc = [[ZStudentOrganizationDetailDesVC alloc] init];
        dvc.listModel = cellConfig.dataModel;
        [self.navigationController pushViewController:dvc animated:YES];
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
    [ZStudentMainViewModel getIndexList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
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
    [ZStudentMainViewModel getIndexList:self.param completeBlock:^(BOOL isSuccess, ZStoresListNetModel *data) {
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
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:self.type forKey:@"stores_type"];
}
@end
