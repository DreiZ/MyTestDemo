//
//  ZCollectionSearchVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCollectionSearchVC.h"
#import "ZSearchHistoryView.h"
#import "ZDBMainStore.h"

@interface ZCollectionSearchVC ()<UITextFieldDelegate>
@property (nonatomic,strong) ZSearchHistoryView *historyView;

@end

@implementation ZCollectionSearchVC

#pragma mark - vc delegate
#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.isHidenNaviBar = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self.iCollectionView) {
        [self.iCollectionView endEditing:YES];
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
    self.loading = NO;
}

- (void)initCellConfigArr {
    [_cellConfigArr removeAllObjects];
}


- (void)setupMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.iCollectionView];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
         make.left.right.equalTo(self.view);
         make.height.mas_equalTo(CGFloatIn750(88));
     }];
    
     [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
         make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
         make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
         make.top.equalTo(self.searchView.mas_bottom).offset(-CGFloatIn750(0));
     }];
     self.searchView.iTextField.placeholder = self.navTitle;
     
     [self.view addSubview:self.historyView];
     [self.historyView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.bottom.equalTo(self.view);
         make.top.equalTo(self.searchView.mas_bottom).offset(-CGFloatIn750(0));
     }];
}

- (void)setCollectionViewRefreshHeader {
    __weak typeof(self) weakSelf = self;
    [self.iCollectionView tt_addRefreshHeaderWithAction:^{
        [weakSelf refreshData];
    }];
}

- (void)setCollectionViewRefreshFooter {
    __weak typeof(self) weakSelf = self;
    
    [self.iCollectionView tt_addLoadMoreFooterWithAction:^{
        [weakSelf refreshMoreData];
    }];
    
    [self.iCollectionView tt_removeLoadMoreFooter];
}

- (void)setCollectionViewEmptyDataDelegate {
    self.iCollectionView.emptyDataSetSource = self;
    self.iCollectionView.emptyDataSetDelegate = self;
}

- (void)setLoading:(BOOL)loading {
    [super setLoading:loading];
    [self.iCollectionView reloadEmptyDataSet];
}

- (void)setCollectionViewGaryBack {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    _safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
}

- (void)setCollectionViewWhiteBack {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    _safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
}

#pragma mark - lazy loading...
- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = self.scrollDirection;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        _iCollectionView.showsVerticalScrollIndicator = NO;
        
//        [_iCollectionView registerClass:[ZStudentOrganizationLessonListCollectionCell class] forCellWithReuseIdentifier:[ZStudentOrganizationLessonListCollectionCell className]];
    }
    
    return _iCollectionView;
}

- (UIView *)safeFooterView {
    if (!_safeFooterView) {
        _safeFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, safeAreaBottom())];
        _safeFooterView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _safeFooterView;
}


- (void)setHotList:(NSArray *)hotList {
    _hotList = hotList;
    self.historyView.hotList = self.hotList;
}

#pragma mark lazy loading...
- (ZSearchFieldView *)searchView {
    if (!_searchView) {
        __weak typeof(self) weakSelf = self;
        _searchView = [[ZSearchFieldView alloc] init];
        _searchView.iTextField.delegate = self;
        _searchView.textChangeBlock = ^(NSString *text) {
            [weakSelf valueChange:text];
        };
        _searchView.backBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        _searchView.searchBlock = ^(NSString *text) {
            [weakSelf searchClick:weakSelf.searchView.iTextField.text];
        };
    }
    return _searchView;
}

- (void)cancleBtnOnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (ZSearchHistoryView *)historyView {
    if (!_historyView) {
        __weak typeof(self) weakSelf = self;
        _historyView = [[ZSearchHistoryView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenWidth, KScreenHeight - kTopHeight)];
        _historyView.searchType = self.searchType;
        _historyView.searchBlock = ^(NSString * text) {
            weakSelf.searchView.iTextField.text = text;
            [weakSelf searchClick:text];
        };
    }
    return _historyView;;
}

#pragma mark - -textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchClick:textField.text];
//    [self searchPoiByKeyword:textField.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.historyView.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason  API_AVAILABLE(ios(10.0)){
    self.historyView.hidden = YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    self.searhView.hidden = NO;
    self.historyView.hidden = NO;
    [self.historyView reloadHistoryData];
}

- (void)valueChange:(NSString *)text {
    
}

- (void)searchClick:(NSString *)text {
    [self.searchView.iTextField resignFirstResponder];
    
    if (ValidStr(text)) {
        __block ZHistoryModel *lmodel = [[ZHistoryModel alloc] init];
        lmodel.search_title = text;
        lmodel.search_type = self.searchType;
        __block BOOL isHad = NO;
        __block NSInteger index = 0;
        NSMutableArray *tempArr = [[ZDBMainStore shareManager] searchHistorysByID:self.searchType];
        [tempArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(ZHistoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.search_title isEqualToString:lmodel.search_title]) {
                isHad = YES;
                index = idx;
            }
        }];
        
        if (isHad) {
            [tempArr removeObjectAtIndex:index];
            [tempArr insertObject:lmodel atIndex:0];
        }else{
            [tempArr insertObject:lmodel atIndex:0];
        }
        
        if (tempArr.count > 9) {
            [tempArr removeLastObject];
        }
        [[ZDBMainStore shareManager] updateHistorySearchs:tempArr];
    }
}
#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellConfigArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCollectionViewCell *cell;
    cell = (ZBaseCollectionViewCell*)[cellConfig cellOfCellConfigWithCollection:collectionView indexPath:indexPath dataModel:cellConfig.dataModel];
    [self zz_collectionView:collectionView cell:cell cellForItemAtIndexPath:indexPath cellConfig:cellConfig];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    [self zz_collectionView:collectionView didSelectItemAtIndexPath:indexPath cellConfig:cellConfig];
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.edgeInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGSize cellSize =  cellConfig.sizeOfCell;
    return cellSize;
}

#pragma mark - collectionview handle
-(void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
    
}

- (void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig{
}

#pragma mark - 网络数据请求
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
//            [weakSelf.iCollectionView reloadData];
//
//            [weakSelf.iCollectionView tt_endRefreshing];
//            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
//                [weakSelf.iCollectionView tt_removeLoadMoreFooter];
//            }else{
//                [weakSelf.iCollectionView tt_endLoadMore];
//            }
//        }else{
//            [weakSelf.iCollectionView reloadData];
//            [weakSelf.iCollectionView tt_endRefreshing];
//            [weakSelf.iCollectionView tt_removeLoadMoreFooter];
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
//            [weakSelf.iCollectionView reloadData];
//
//            [weakSelf.iCollectionView tt_endRefreshing];
//            if (data && [data.pages integerValue] <= weakSelf.currentPage) {
//                [weakSelf.iCollectionView tt_removeLoadMoreFooter];
//            }else{
//                [weakSelf.iCollectionView tt_endLoadMore];
//            }
//        }else{
//            [weakSelf.iCollectionView reloadData];
//            [weakSelf.iCollectionView tt_endRefreshing];
//            [weakSelf.iCollectionView tt_removeLoadMoreFooter];
//        }
//    }];
}

@end



