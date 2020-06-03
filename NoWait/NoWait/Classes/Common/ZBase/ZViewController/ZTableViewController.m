//
//  ZTableViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewController.h"

@interface ZTableViewController ()

@end

@implementation ZTableViewController

#pragma mark - vc delegate
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_iTableView) {
        [self.iTableView endEditing:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self setupMainView];
}

#pragma mark - setdata
- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    self.currentPage = 1;
    self.loading = YES;
}

- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - handle
- (void)initCellConfigArr {
    if (_updateConfigArr) {
        _updateConfigArr(^(NSMutableArray *cellConfigArr) {
            self.cellConfigArr = cellConfigArr;
        });
    }
}

- (void)setTableViewRefreshHeader {
    __weak typeof(self) weakSelf = self;
    [self.iTableView tt_addRefreshHeaderWithAction:^{
        [weakSelf refreshData];
    }];
}

- (void)setTableViewRefreshFooter {
    __weak typeof(self) weakSelf = self;
    [self.iTableView tt_addLoadMoreFooterWithAction:^{
        [weakSelf refreshMoreData];
    }];
    
    [self.iTableView tt_removeLoadMoreFooter];
}

- (void)setTableViewEmptyDataDelegate {
    self.iTableView.emptyDataSetSource = self;
    self.iTableView.emptyDataSetDelegate = self;
}

- (void)setLoading:(BOOL)loading {
    [super setLoading:loading];
    [self.iTableView reloadEmptyDataSet];
}

- (void)setTableViewGaryBack {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    _safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
}

- (void)setTableViewWhiteBack {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    _safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
}


#pragma mark - lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
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
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iTableView.tableFooterView = self.safeFooterView;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _iTableView;
}

- (UIView *)safeFooterView {
    if (!_safeFooterView) {
        _safeFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, safeAreaBottom())];
        _safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _safeFooterView;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_numberOfSectionsInTableView) {
        return _numberOfSectionsInTableView(tableView);
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_numberOfRowsInSection) {
        return _numberOfRowsInSection(tableView, section);
    }
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellForRowAtIndexPath) {
        return _cellForRowAtIndexPath(tableView, indexPath);
    }
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    [self zz_tableView:tableView cell:cell cellForRowAtIndexPath:indexPath cellConfig:cellConfig];
    return cell;
}

#pragma mark - tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_heightForRowAtIndexPath) {
        return _heightForRowAtIndexPath(tableView, indexPath);
    }
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_viewForHeaderInSection) {
        return _viewForHeaderInSection(tableView, section);
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_viewForFooterInSection) {
        return _viewForFooterInSection(tableView, section);
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_heightForHeaderInSection) {
        return _heightForHeaderInSection(tableView, section);
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_heightForFooterInSection) {
        return _heightForFooterInSection(tableView, section);
    }
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_didSelectRowAtIndexPath) {
        return _didSelectRowAtIndexPath(tableView, indexPath);
    }
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    [self zz_tableView:tableView didSelectRowAtIndexPath:indexPath cellConfig:cellConfig];
}


#pragma mark - tableview 数据处理
-(void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
}


-(void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    
}

#pragma mark - 网络数据请求
- (void)refreshData {
    if (_refreshHead) {
        _refreshHead();
    }
}

- (void)refreshMoreData {
    if (_refreshMore) {
        _refreshMore();
    }
}

#pragma mark - refresh data
- (ZTableViewController *(^)(void))refreshNetData {
    return ^ ZTableViewController *(void) {
        [self refreshData];
        return self;
    };
}

- (ZTableViewController *(^)(void))reloadData {
    return ^ ZTableViewController *(void) {
        [self initCellConfigArr];
        [self.iTableView reloadData];
        return self;
    };
}

ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewController *, setRefreshNet, refreshHead, void, void)

ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewController *, setRefreshMoreNet, refreshMore, void, void)

#pragma mark - handle- set view
- (ZTableViewController *(^)(NSString *))setNavTitle {
    return ^ ZTableViewController *(NSString *text) {
        [self.navigationItem setTitle:text];
        return self;
    };
}

- (ZTableViewController *(^)(void))setTableViewGary {
    return ^ ZTableViewController *(void) {
        [self setTableViewGaryBack];
        return self;
    };
}

- (ZTableViewController *(^)(void))setTableViewWhite {
    return ^ ZTableViewController *(void) {
        [self setTableViewWhiteBack];
        return self;
    };
}

- (ZTableViewController *(^)(void))setRefreshHeader {
    return ^ ZTableViewController *(void) {
        [self setTableViewRefreshHeader];
        return self;
    };
}

- (ZTableViewController *(^)(void))setRefreshFooter {
    return ^ ZTableViewController *(void) {
        [self setTableViewRefreshFooter];
        return self;
    };
}

- (ZTableViewController *(^)(void))setEmptyDataDelegate {
    return ^ ZTableViewController *(void) {
        [self setTableViewEmptyDataDelegate];
        return self;
    };
}

#pragma mark - block set
- (ZTableViewController *(^)(void (^)(void (^)(NSMutableArray *))))setUpdateConfigArr {
    return ^ ZTableViewController *(void (^value)(void (^)(NSMutableArray *))) {
            self.updateConfigArr = value;
            return self;
        };
}

#pragma mark - tableview block - datasource
ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewController *, setNumberOfSectionsInTableView, numberOfSectionsInTableView, NSInteger, UITableView *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, setNumberOfRowsInSection, numberOfRowsInSection, NSInteger, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, setCellForRowAtIndexPath, cellForRowAtIndexPath, UITableViewCell *, UITableView *, NSIndexPath *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, setViewForHeaderInSection, viewForHeaderInSection, UIView *, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, setViewForFooterInSection, viewForFooterInSection, UIView *, UITableView *, NSInteger)


#pragma mark - tableview block - delegate
ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, setHeightForRowAtIndexPath, heightForRowAtIndexPath, CGFloat , UITableView *, NSIndexPath *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, setHeightForHeaderInSection, heightForHeaderInSection, CGFloat , UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, setHeightForFooterInSection, heightForFooterInSection, CGFloat , UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, setDidSelectRowAtIndexPath, didSelectRowAtIndexPath, void, UITableView *, NSIndexPath *)
@end
