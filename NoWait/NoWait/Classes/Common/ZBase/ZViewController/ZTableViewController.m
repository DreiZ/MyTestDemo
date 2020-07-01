//
//  ZTableViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewController.h"

@interface ZTableViewController ()
//刷新数据head
@property (nonatomic,strong) void (^zChain_block_refreshHeaderNet)(void);
//刷新数据footer
@property (nonatomic,strong) void (^zChain_block_refreshMoreNet)(void);
//更新cellConfigArr
@property (nonatomic,strong) void (^zChain_block_updateConfigArr)(void (^)(NSMutableArray *));

//tableview datasource block
@property (nonatomic,strong) NSInteger (^zChain_block_numberOfSectionsInTableView)(UITableView *);

@property (nonatomic,strong) NSInteger (^zChain_block_numberOfRowsInSection)(UITableView *, NSInteger);

@property (nonatomic,strong) UITableViewCell *(^zChain_block_cellForRowAtIndexPath)(UITableView *, NSIndexPath *);

@property (nonatomic,strong) UIView *(^zChain_block_viewForHeaderInSection)(UITableView *, NSInteger);

@property (nonatomic,strong) UIView *(^zChain_block_viewForFooterInSection)(UITableView *, NSInteger);

@property (nonatomic,strong) CGFloat (^zChain_block_heightForRowAtIndexPath)(UITableView *, NSIndexPath *);

@property (nonatomic,strong) CGFloat (^zChain_block_heightForHeaderInSection)(UITableView *, NSInteger);

@property (nonatomic,strong) CGFloat (^zChain_block_heightForFooterInSection)(UITableView *, NSInteger);

@property (nonatomic,strong) void (^zChain_block_didSelectRowAtIndexPath)(UITableView *, NSIndexPath *);

@property (nonatomic,strong) void (^zChain_block_configDidSelectRowAtIndexPath)(UITableView *, NSIndexPath *,  ZCellConfig *);

@property (nonatomic,strong) void (^zChain_block_cellConfigForRowAtIndexPath)(UITableView *, NSIndexPath *, UITableViewCell *, ZCellConfig *);
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

#pragma mark - 设置data
- (void)setDataSource {
    _dataSources = @[].mutableCopy;
    _cellConfigArr = @[].mutableCopy;
    
    self.currentPage = 1;
    self.loading = YES;
}

//设置列表 cellConfig
- (void)initCellConfigArr {
    if (_zChain_block_updateConfigArr) {
        _zChain_block_updateConfigArr(^(NSMutableArray *cellConfigArr) {
            self.cellConfigArr = cellConfigArr;
        });
    }
}

#pragma mark - 设置UI
- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.view addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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


#pragma mark - 设置 tableview refresh
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


#pragma mark - refresh data 网络数据请求
- (void)refreshData {
    if (_zChain_block_refreshHeaderNet) {
        _zChain_block_refreshHeaderNet();
    }
}

- (void)refreshMoreData {
    if (_zChain_block_refreshMoreNet) {
        _zChain_block_refreshMoreNet();
    }
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
    if (_zChain_block_numberOfSectionsInTableView) {
        return _zChain_block_numberOfSectionsInTableView(tableView);
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_zChain_block_numberOfRowsInSection) {
        return _zChain_block_numberOfRowsInSection(tableView, section);
    }
    return _cellConfigArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_zChain_block_cellForRowAtIndexPath) {
        return _zChain_block_cellForRowAtIndexPath(tableView, indexPath);
    }
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCell *cell;
    cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
    
    if (_zChain_block_cellConfigForRowAtIndexPath) {
        _zChain_block_cellConfigForRowAtIndexPath(tableView, indexPath, cell, cellConfig);
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_zChain_block_viewForHeaderInSection) {
        return _zChain_block_viewForHeaderInSection(tableView, section);
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_zChain_block_viewForFooterInSection) {
        return _zChain_block_viewForFooterInSection(tableView, section);
    }
    return nil;
}


#pragma mark - tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_zChain_block_heightForRowAtIndexPath) {
        return _zChain_block_heightForRowAtIndexPath(tableView, indexPath);
    }
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGFloat cellHeight =  cellConfig.heightOfCell;
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_zChain_block_heightForHeaderInSection) {
        return _zChain_block_heightForHeaderInSection(tableView, section);
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_zChain_block_heightForFooterInSection) {
        return _zChain_block_heightForFooterInSection(tableView, section);
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_zChain_block_didSelectRowAtIndexPath) {
        return _zChain_block_didSelectRowAtIndexPath(tableView, indexPath);
    }
    
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if (_zChain_block_configDidSelectRowAtIndexPath) {
        _zChain_block_configDidSelectRowAtIndexPath(tableView, indexPath, cellConfig);
    }
}




#pragma mark - Chain function (设置数据、UI)********************************
-(ZTableViewController *(^)(void (^)(void)))zChain_updateDataSource {
    return ^ ZTableViewController *(void (^delegateBlock)(void)) {
        [self setDataSource];
        delegateBlock();
        return self;
    };
}

-(ZTableViewController *(^)(void (^)(void)))zChain_resetMainView {
    return ^ ZTableViewController *(void (^delegateBlock)(void)) {
        [self setupMainView];
        delegateBlock();
        return self;
    };
}

- (ZTableViewController *(^)(NSString *))zChain_setNavTitle {
    return ^ ZTableViewController *(NSString *text) {
        [self.navigationItem setTitle:text];
        return self;
    };
}

- (ZTableViewController *(^)(void))zChain_setTableViewGary {
    return ^ ZTableViewController *(void) {
        [self setTableViewGaryBack];
        return self;
    };
}

- (ZTableViewController *(^)(void))zChain_setTableViewWhite {
    return ^ ZTableViewController *(void) {
        [self setTableViewWhiteBack];
        return self;
    };
}

- (ZTableViewController *(^)(void))zChain_addRefreshHeader {
    return ^ ZTableViewController *(void) {
        [self setTableViewRefreshHeader];
        return self;
    };
}

- (ZTableViewController *(^)(void))zChain_addLoadMoreFooter {
    return ^ ZTableViewController *(void) {
        [self setTableViewRefreshFooter];
        return self;
    };
}

- (ZTableViewController *(^)(void))zChain_addEmptyDataDelegate {
    return ^ ZTableViewController *(void) {
        [self setTableViewEmptyDataDelegate];
        return self;
    };
}

#pragma mark - Chain function (刷新数据、UI)
- (ZTableViewController *(^)(void))zChain_reload_ui {
    return ^ ZTableViewController *(void) {
        [self initCellConfigArr];
        [self.iTableView reloadData];
        return self;
    };
}

- (ZTableViewController *(^)(void))zChain_reload_Net {
    return ^ ZTableViewController *(void) {
        [self refreshData];
        return self;
    };
}

#pragma mark - Chain block(获取数据header、获取数据footer)
ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewController *, zChain_block_setRefreshHeaderNet, zChain_block_refreshHeaderNet, void, void)

ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewController *, zChain_block_setRefreshMoreNet, zChain_block_refreshMoreNet, void, void)


#pragma mark - Chain block (更新cell config)
- (ZTableViewController *(^)(void (^)(void (^)(NSMutableArray *))))zChain_block_setUpdateCellConfigData {
    return ^ ZTableViewController *(void (^value)(void (^)(NSMutableArray *))) {
            self.zChain_block_updateConfigArr = value;
            return self;
        };
}


#pragma mark - Chain block  (列表 tableview datasource block)
ZCHAIN_BLOCK_IMPLEMENTATION(ZTableViewController *, zChain_block_setNumberOfSectionsInTableView, zChain_block_numberOfSectionsInTableView, NSInteger, UITableView *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, zChain_block_setNumberOfRowsInSection, zChain_block_numberOfRowsInSection, NSInteger, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, zChain_block_setCellForRowAtIndexPath, zChain_block_cellForRowAtIndexPath, UITableViewCell *, UITableView *, NSIndexPath *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, zChain_block_setViewForHeaderInSection, zChain_block_viewForHeaderInSection, UIView *, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, zChain_block_setViewForFooterInSection, zChain_block_viewForFooterInSection, UIView *, UITableView *, NSInteger)

//设置tableViewCell block
ZCHAIN_BLOCKFOUR_IMPLEMENTATION(ZTableViewController *, zChain_block_setCellConfigForRowAtIndexPath, zChain_block_cellConfigForRowAtIndexPath, void, UITableView *, NSIndexPath *, UITableViewCell *, ZCellConfig *)

#pragma mark - Chain block (列表 tableview delegate block)
ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, zChain_block_setHeightForRowAtIndexPath, zChain_block_heightForRowAtIndexPath, CGFloat , UITableView *, NSIndexPath *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, zChain_block_setHeightForHeaderInSection, zChain_block_heightForHeaderInSection, CGFloat , UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, zChain_block_setHeightForFooterInSection, zChain_block_heightForFooterInSection, CGFloat , UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZTableViewController *, zChain_block_setDidSelectRowAtIndexPath, zChain_block_didSelectRowAtIndexPath, void, UITableView *, NSIndexPath *)

//设置tableView didSelect block
ZCHAIN_BLOCKTHREE_IMPLEMENTATION(ZTableViewController *, zChain_block_setConfigDidSelectRowAtIndexPath, zChain_block_configDidSelectRowAtIndexPath, void, UITableView *, NSIndexPath *, ZCellConfig *)
@end
