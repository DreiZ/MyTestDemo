//
//  ZLChainTableVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLChainTableVC.h"

@interface ZLChainTableVC ()
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


@implementation ZLChainTableVC

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
    self.currentPage = 1;
    self.loading = YES;
}

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = @[].mutableCopy;
    }
    return _dataSources;
}

- (NSMutableArray *)cellConfigArr {
    if (!_cellConfigArr) {
        _cellConfigArr = @[].mutableCopy;
    }
    return _cellConfigArr;
}

- (NSMutableArray *)headSectionArr {
    if (!_headSectionArr) {
        _headSectionArr = @[].mutableCopy;
    }
    return _headSectionArr;
}

- (NSMutableArray *)footerSectionArr {
    if (!_footerSectionArr) {
        _footerSectionArr = @[].mutableCopy;
    }
    return _footerSectionArr;
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
    
    if (ValidArray(_cellConfigArr)) {
        id data = [_cellConfigArr objectAtIndex:0];
        if ([data isKindOfClass:[NSArray class]]) {
            
            return _cellConfigArr.count;
        }
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_zChain_block_numberOfRowsInSection) {
        return _zChain_block_numberOfRowsInSection(tableView, section);
    }
    
    if (ValidArray(_cellConfigArr)) {
        id data = [_cellConfigArr objectAtIndex:0];
        if ([data isKindOfClass:[NSArray class]]) {
            NSArray *cellConfigTempArr = _cellConfigArr[section];
            
            return cellConfigTempArr.count;
        }else if([data isKindOfClass:[ZCellConfig class]]){
            return _cellConfigArr.count;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_zChain_block_cellForRowAtIndexPath) {
        return _zChain_block_cellForRowAtIndexPath(tableView, indexPath);
    }
    ZBaseCell *cell;
    
    if (ValidArray(_cellConfigArr)) {
        id data = [_cellConfigArr objectAtIndex:0];
        
        if ([data isKindOfClass:[NSArray class]]) {
            NSArray *cellConfigTempArr = _cellConfigArr[indexPath.section];
            ZCellConfig *cellConfig = [cellConfigTempArr objectAtIndex:indexPath.row];
            
            cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
            
            if (_zChain_block_cellConfigForRowAtIndexPath) {
                _zChain_block_cellConfigForRowAtIndexPath(tableView, indexPath, cell, cellConfig);
            }
        }else if([data isKindOfClass:[ZCellConfig class]]){
            ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
            
            cell = (ZBaseCell*)[cellConfig cellOfCellConfigWithTableView:tableView dataModel:cellConfig.dataModel];
            
            if (_zChain_block_cellConfigForRowAtIndexPath) {
                _zChain_block_cellConfigForRowAtIndexPath(tableView, indexPath, cell, cellConfig);
            }
        }
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_zChain_block_viewForHeaderInSection) {
        return _zChain_block_viewForHeaderInSection(tableView, section);
    }
    if (ValidArray(self.headSectionArr)) {
        if (section < self.headSectionArr.count) {
            ZSectionConfig *sectionConfig = [self.headSectionArr objectAtIndex:section];
            
            return [sectionConfig sectionOfConfigWitDataModel:sectionConfig.dataModel];
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_zChain_block_viewForFooterInSection) {
        return _zChain_block_viewForFooterInSection(tableView, section);
    }
    if (ValidArray(self.footerSectionArr)) {
        if (section < self.footerSectionArr.count) {
            ZSectionConfig *sectionConfig = [self.footerSectionArr objectAtIndex:section];
            
            return [sectionConfig sectionOfConfigWitDataModel:sectionConfig.dataModel];
        }
    }
    return nil;
}

#pragma mark - tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_zChain_block_heightForRowAtIndexPath) {
        return _zChain_block_heightForRowAtIndexPath(tableView, indexPath);
    }
    
    if (ValidArray(_cellConfigArr)) {
        id data = [_cellConfigArr objectAtIndex:0];
        if ([data isKindOfClass:[NSArray class]]) {
            
            NSArray *cellConfigTempArr = _cellConfigArr[indexPath.section];
            ZCellConfig *cellConfig = [cellConfigTempArr objectAtIndex:indexPath.row];
            
            CGFloat cellHeight =  cellConfig.heightOfCell;
            return cellHeight;
        }else if([data isKindOfClass:[ZCellConfig class]]){
            
            ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
            CGFloat cellHeight =  cellConfig.heightOfCell;
            return cellHeight;
        }else{
            return 0;
        }
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_zChain_block_heightForHeaderInSection) {
        return _zChain_block_heightForHeaderInSection(tableView, section);
    }
    if (ValidArray(self.headSectionArr)) {
        if (section < self.headSectionArr.count) {
            ZSectionConfig *sectionConfig = [self.headSectionArr objectAtIndex:section];
            
            return sectionConfig.heightOfSection;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_zChain_block_heightForFooterInSection) {
        return _zChain_block_heightForFooterInSection(tableView, section);
    }
    if (ValidArray(self.footerSectionArr)) {
        if (section < self.footerSectionArr.count) {
            ZSectionConfig *sectionConfig = [self.footerSectionArr objectAtIndex:section];
            
            return sectionConfig.heightOfSection;
        }
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_zChain_block_didSelectRowAtIndexPath) {
        return _zChain_block_didSelectRowAtIndexPath(tableView, indexPath);
    }
    
    if (ValidArray(_cellConfigArr)) {
        id data = [_cellConfigArr objectAtIndex:0];
        if ([data isKindOfClass:[NSArray class]]) {
            NSArray *cellConfigTempArr = _cellConfigArr[indexPath.section];
            ZCellConfig *cellConfig = [cellConfigTempArr objectAtIndex:indexPath.row];
            if (_zChain_block_configDidSelectRowAtIndexPath) {
                _zChain_block_configDidSelectRowAtIndexPath(tableView, indexPath, cellConfig);
            }
        }else if([data isKindOfClass:[ZCellConfig class]]){
            ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
            if (_zChain_block_configDidSelectRowAtIndexPath) {
                _zChain_block_configDidSelectRowAtIndexPath(tableView, indexPath, cellConfig);
            }
        }
    }
}


#pragma mark - Chain function (设置数据、UI)********************************
-(ZLChainTableVC *(^)(void (^)(void)))zChain_updateDataSource {
    return ^ ZLChainTableVC *(void (^delegateBlock)(void)) {
        [self setDataSource];
        delegateBlock();
        return self;
    };
}

-(ZLChainTableVC *(^)(void (^)(void)))zChain_resetMainView {
    return ^ ZLChainTableVC *(void (^delegateBlock)(void)) {
        [self setupMainView];
        delegateBlock();
        return self;
    };
}

- (ZLChainTableVC *(^)(NSString *))zChain_setNavTitle {
    return ^ ZLChainTableVC *(NSString *text) {
        [self.navigationItem setTitle:text];
        return self;
    };
}

- (ZLChainTableVC *(^)(void))zChain_setTableViewGary {
    return ^ ZLChainTableVC *(void) {
        [self setTableViewGaryBack];
        return self;
    };
}

- (ZLChainTableVC *(^)(void))zChain_setTableViewWhite {
    return ^ ZLChainTableVC *(void) {
        [self setTableViewWhiteBack];
        return self;
    };
}

- (ZLChainTableVC *(^)(void))zChain_addRefreshHeader {
    return ^ ZLChainTableVC *(void) {
        [self setTableViewRefreshHeader];
        return self;
    };
}

- (ZLChainTableVC *(^)(void))zChain_addLoadMoreFooter {
    return ^ ZLChainTableVC *(void) {
        [self setTableViewRefreshFooter];
        return self;
    };
}

- (ZLChainTableVC *(^)(void))zChain_addEmptyDataDelegate {
    return ^ ZLChainTableVC *(void) {
        [self setTableViewEmptyDataDelegate];
        return self;
    };
}

#pragma mark - Chain function (刷新数据、UI)
- (ZLChainTableVC *(^)(void))zChain_reload_ui {
    return ^ ZLChainTableVC *(void) {
        [self initCellConfigArr];
        [self.iTableView reloadData];
        return self;
    };
}

- (ZLChainTableVC *(^)(void))zChain_reload_Net {
    return ^ ZLChainTableVC *(void) {
        [self refreshData];
        return self;
    };
}


#pragma mark - Chain block(获取数据header、获取数据footer)
ZCHAIN_BLOCK_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setRefreshHeaderNet, zChain_block_refreshHeaderNet, void, void)

ZCHAIN_BLOCK_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setRefreshMoreNet, zChain_block_refreshMoreNet, void, void)


#pragma mark - Chain block (更新cell config)
- (ZLChainTableVC *(^)(void (^)(void (^)(NSMutableArray *))))zChain_block_setUpdateCellConfigData {
    return ^ ZLChainTableVC *(void (^value)(void (^)(NSMutableArray *))) {
            self.zChain_block_updateConfigArr = value;
            return self;
        };
}

#pragma mark - Chain block  (列表 tableview datasource block)
ZCHAIN_BLOCK_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setNumberOfSectionsInTableView, zChain_block_numberOfSectionsInTableView, NSInteger, UITableView *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setNumberOfRowsInSection, zChain_block_numberOfRowsInSection, NSInteger, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setCellForRowAtIndexPath, zChain_block_cellForRowAtIndexPath, UITableViewCell *, UITableView *, NSIndexPath *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setViewForHeaderInSection, zChain_block_viewForHeaderInSection, UIView *, UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setViewForFooterInSection, zChain_block_viewForFooterInSection, UIView *, UITableView *, NSInteger)

//设置tableViewCell block
ZCHAIN_BLOCKFOUR_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setCellConfigForRowAtIndexPath, zChain_block_cellConfigForRowAtIndexPath, void, UITableView *, NSIndexPath *, UITableViewCell *, ZCellConfig *)

#pragma mark - Chain block (列表 tableview delegate block)
ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setHeightForRowAtIndexPath, zChain_block_heightForRowAtIndexPath, CGFloat , UITableView *, NSIndexPath *)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setHeightForHeaderInSection, zChain_block_heightForHeaderInSection, CGFloat , UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setHeightForFooterInSection, zChain_block_heightForFooterInSection, CGFloat , UITableView *, NSInteger)

ZCHAIN_BLOCKTWO_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setDidSelectRowAtIndexPath, zChain_block_didSelectRowAtIndexPath, void, UITableView *, NSIndexPath *)

//设置tableView didSelect block
ZCHAIN_BLOCKTHREE_IMPLEMENTATION(ZLChainTableVC *, zChain_block_setConfigDidSelectRowAtIndexPath, zChain_block_configDidSelectRowAtIndexPath, void, UITableView *, NSIndexPath *, ZCellConfig *)


#pragma mark - cell config
- (ZCellConfig *(^)(NSString *))addCell{
    return ^ ZCellConfig *(NSString *cellTitle) {
        ZCellConfig *cellConfig = ZCellConfig.zChain_create(cellTitle);
        [self.cellConfigArr addObject:cellConfig];
        return cellConfig;
    };
}

- (ZCellConfig *(^)(NSString *, NSInteger))addSectionCell {
    return ^ ZCellConfig *(NSString *cellTitle, NSInteger section) {
        if (section < 0) {
            return nil;
        }
        
        ZCellConfig *cellConfig = ZCellConfig.zChain_create(cellTitle);
        //错误section 将在最后section添加新的sectionList
        if (self.cellConfigArr.count <= section) {
            NSMutableArray *section = @[].mutableCopy;
            [section addObject:cellConfig];
            [self.cellConfigArr addObject:section];
        }else{
            NSMutableArray *sectionArr = self.cellConfigArr[section];
            [sectionArr addObject:cellConfig];
        }
        return cellConfig;
    };
}

#pragma mark - section config
- (ZSectionConfig *(^)(NSString *))addHeaderSection {
    return ^ ZSectionConfig *(NSString *title) {
        ZSectionConfig *sectionConfig = ZSectionConfig.zChain_section_create(title);
        [self.headSectionArr addObject:sectionConfig];
        return sectionConfig;
    };
}

- (ZSectionConfig *(^)(NSString *))addFooterSection {
    return ^ ZSectionConfig *(NSString *title) {
        ZSectionConfig *sectionConfig = ZSectionConfig.zChain_section_create(title);
        [self.footerSectionArr addObject:sectionConfig];
        return sectionConfig;
    };
}
@end

