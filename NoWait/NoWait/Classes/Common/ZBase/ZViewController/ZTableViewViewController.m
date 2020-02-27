//
//  ZTableViewViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"

@interface ZTableViewViewController ()

@end

@implementation ZTableViewViewController

#pragma mark - vc delegate
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDataSource];
    [self setupMainView];
}

#pragma mark - setdata
- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    self.currentPage = 1;
    self.loading = NO;
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
}


- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}



#pragma mark - lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        __weak typeof(self) weakSelf = self;
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iTableView.showsVerticalScrollIndicator = NO;
        _iTableView.showsHorizontalScrollIndicator = NO;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _iTableView.emptyDataSetSource = self;
        _iTableView.emptyDataSetDelegate = self;
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        
        [_iTableView tt_addRefreshHeaderWithAction:^{
            [weakSelf refreshData];
        }];
        [_iTableView tt_addLoadMoreFooterWithAction:^{
            [weakSelf refreshMoreData];
        }];
        [_iTableView tt_removeLoadMoreFooter];
    }
    return _iTableView;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    [self zz_tableView:tableView cellForRowAtIndexPath:indexPath cellConfig:cellConfig];
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    [self zz_tableView:tableView didSelectRowAtIndexPath:indexPath cellConfig:cellConfig];
}


#pragma mark - 数据处理
-(void)zz_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
}


-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    
}

- (void)refreshData {
//    self.currentPage = 1;
//    self.loading = YES;
//    __weak typeof(self) weakSelf = self;
//    NSMutableDictionary *param = @{@"page_index":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
//
//    [ZOriganizationLessonViewModel getLessonlist:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
//        weakSelf.loading = NO;
//        if (isSuccess && data) {
//            [weakSelf.dataSources removeAllObjects];
//            [weakSelf.dataSources addObjectsFromArray:data.list];
//            [weakSelf initCellConfigArr];
//            [weakSelf.iTableView reloadData];
//
//            [weakSelf.iTableView tt_endRefreshing];
//            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
//                [weakSelf.iTableView tt_removeLoadMoreFooter];
//            }else{
//                [weakSelf.iTableView tt_endLoadMore];
//            }
//        }else{
//            [weakSelf.iTableView reloadData];
//            [weakSelf.iTableView tt_endRefreshing];
//            [weakSelf.iTableView tt_removeLoadMoreFooter];
//        }
//    }];
}

- (void)refreshMoreData {
//    self.currentPage++;
//    self.loading = YES;
//    __weak typeof(self) weakSelf = self;
//    NSMutableDictionary *param = @{@"page_index":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
//
//    [ZOriganizationLessonViewModel getLessonlist:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
//        weakSelf.loading = NO;
//        if (isSuccess && data) {
//            [weakSelf.dataSources addObjectsFromArray:data.list];
//            [weakSelf initCellConfigArr];
//            [weakSelf.iTableView reloadData];
//
//            [weakSelf.iTableView tt_endRefreshing];
//            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
//                [weakSelf.iTableView tt_removeLoadMoreFooter];
//            }else{
//                [weakSelf.iTableView tt_endLoadMore];
//            }
//        }else{
//            [weakSelf.iTableView reloadData];
//            [weakSelf.iTableView tt_endRefreshing];
//            [weakSelf.iTableView tt_removeLoadMoreFooter];
//        }
//    }];
}
@end

