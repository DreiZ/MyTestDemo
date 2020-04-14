//
//  ZCollectionVIewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCollectionViewController.h"

@interface ZCollectionViewController ()

@end

@implementation ZCollectionViewController

#pragma mark - vc delegate
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
    
    [self.view addSubview:self.iCollectionView];
    [_iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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


