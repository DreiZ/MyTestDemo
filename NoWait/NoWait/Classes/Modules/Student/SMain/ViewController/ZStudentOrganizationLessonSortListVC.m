//
//  ZStudentOrganizationLessonSortListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationLessonSortListVC.h"
#import "ZStudentDetailModel.h"
#import "ZStudentOrganizationLessonListCollectionCell.h"

#import "ZOriganizationLessonViewModel.h"
#import "ZOriganizationModel.h"

#import "ZStudentLessonDetailVC.h"

@interface ZStudentOrganizationLessonSortListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *dataSources;

@end

@implementation ZStudentOrganizationLessonSortListVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
         
    self.loading = YES;
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
    
    [self.view addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
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
    ZStudentOrganizationLessonListCollectionCell *cell = [ZStudentOrganizationLessonListCollectionCell z_cellWithCollection:collectionView indexPath:indexPath];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
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
    return [ZStudentOrganizationLessonListCollectionCell z_getCellSize:nil];
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    [ZOriganizationLessonViewModel getLessonList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
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
    [param setObject:self.detailModel.schoolID forKey:@"stores_id"];
    [param setObject:[NSString stringWithFormat:@"%ld",(long)self.type] forKey:@"status"];
    return param;
}
@end

