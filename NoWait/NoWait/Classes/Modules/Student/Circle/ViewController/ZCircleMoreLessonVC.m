//
//  ZCircleMoreLessonVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMoreLessonVC.h"
#import "ZStudentDetailModel.h"
#import "ZStudentExperienceLessonListItemCell.h"
#import "ZOrganizationSearchExperienceLessonListVC.h"

#import "ZOriganizationLessonViewModel.h"
#import "ZOriganizationModel.h"
#import "ZOrganizationLessonTopSearchView.h"

#import "ZStudentExperienceLessonDetailVC.h"

@interface ZCircleMoreLessonVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ZCircleMoreLessonVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
         
    self.loading = YES;
    [self.navigationItem setTitle:@"发现课程"];
    [self setData];
    [self setCollectionViewRefreshFooter];
    [self setCollectionViewRefreshHeader];
    [self setCollectionViewEmptyDataDelegate];
}


- (void)setData {
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(30), CGFloatIn750(30), CGFloatIn750(30), CGFloatIn750(30));
    self.minimumLineSpacing = CGFloatIn750(30);
    self.minimumInteritemSpacing = CGFloatIn750(30);
    self.iCollectionView.scrollEnabled = YES;
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentExperienceLessonListItemCell className] title:[ZStudentExperienceLessonListItemCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZStudentExperienceLessonListItemCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
                       
        [self.cellConfigArr addObject:cellConfig];
    }
}


#pragma mark - collectionview delegate
-(void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentExperienceLessonListItemCell"]) {
        ZStudentExperienceLessonDetailVC *dvc = [[ZStudentExperienceLessonDetailVC alloc] init];
        dvc.model = self.dataSources[indexPath.row];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

- (void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel getLessonByNameList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources removeAllObjects];
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
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
    [ZOriganizationLessonViewModel getLessonByNameList:param completeBlock:^(BOOL isSuccess, ZOriganizationLessonListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.dataSources addObjectsFromArray:data.list];
            [weakSelf initCellConfigArr];
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
    [param setObject:self.name forKey:@"name"];
    return param;
}
@end



