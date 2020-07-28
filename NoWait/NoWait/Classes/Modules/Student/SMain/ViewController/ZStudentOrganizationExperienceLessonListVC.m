//
//  ZStudentOrganizationExperienceLessonListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationExperienceLessonListVC.h"
#import "ZStudentDetailModel.h"
#import "ZStudentExperienceLessonListItemCell.h"


#import "ZOriganizationLessonViewModel.h"
#import "ZOriganizationModel.h"
#import "ZOrganizationLessonTopSearchView.h"

#import "ZStudentExperienceLessonDetailVC.h"

@interface ZStudentOrganizationExperienceLessonListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) ZOrganizationLessonTopSearchView *searchBtn;
@end

@implementation ZStudentOrganizationExperienceLessonListVC

- (void)viewWillAppear:(BOOL)animated {
    self.zChain_block_setNotShouldDecompressImages(^{

    });
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
         
    self.loading = YES;
    [self.navigationItem setTitle:@"全部体验课"];
    [self setMainView];
    [self setCollectionViewRefreshFooter];
    [self setCollectionViewRefreshHeader];
    [self setCollectionViewEmptyDataDelegate];
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

- (void)setMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(78));
        make.top.equalTo(self.view.mas_top);
        make.left.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.searchBtn.mas_bottom);
    }];
}


#pragma mark - 懒加载
- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
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

- (ZOrganizationLessonTopSearchView *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[ZOrganizationLessonTopSearchView alloc] init];
        _searchBtn.title = @"搜索课程名称";
        _searchBtn.handleBlock = ^{
            routePushVC(ZRoute_main_searchOrderLesson, @{@"navTitle":@"搜索课程名称",@"stores_id":@"weakSelf.schoolID"}, nil);
        };
    }
    return _searchBtn;
}


- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = @[].mutableCopy;
    }
    return _dataSources;
}

#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZStudentExperienceLessonListItemCell *cell = [ZStudentExperienceLessonListItemCell z_cellWithCollection:collectionView indexPath:indexPath];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZStudentExperienceLessonDetailVC *dvc = [[ZStudentExperienceLessonDetailVC alloc] init];
    dvc.model = self.dataSources[indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(30), CGFloatIn750(30), CGFloatIn750(30), CGFloatIn750(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [ZStudentExperienceLessonListItemCell z_getCellSize:nil];
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getOrderLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf.iCollectionView reloadData];
            
            [weakSelf.iCollectionView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iCollectionView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iCollectionView tt_endLoadMore];
            }
        }else{
            [weakSelf.iCollectionView reloadData];
            [weakSelf.iCollectionView tt_endRefreshing];
            [weakSelf.iCollectionView tt_removeLoadMoreFooter];
        }
    }];
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getOrderLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf.iCollectionView reloadData];
            
            [weakSelf.iCollectionView tt_endRefreshing];
            if (data && [data.total integerValue] <= weakSelf.currentPage * 10) {
                [weakSelf.iCollectionView tt_removeLoadMoreFooter];
            }else{
                [weakSelf.iCollectionView tt_endLoadMore];
            }
        }else{
            [weakSelf.iCollectionView reloadData];
            [weakSelf.iCollectionView tt_endRefreshing];
            [weakSelf.iCollectionView tt_removeLoadMoreFooter];
        }
    }];
}


- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
    [param setObject:self.schoolID forKey:@"stores_id"];
    return param;
}
@end


