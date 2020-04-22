//
//  ZStudentStarStudentListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarStudentListVC.h"
#import "ZStudentDetailModel.h"
#import "ZStudentStarListCollectionViewCell.h"
#import "ZStudentStarNewListCollectionViewCell.h"

#import "ZStudentStarStudentInfoVC.h"
#import "ZOriganizationTeacherViewModel.h"
#import "ZOriganizationStudentViewModel.h"

#import "ZStudentTeacherDetailVC.h"
#import "ZStudentStudentDetailVC.h"

@interface ZStudentStarStudentListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;

@end

@implementation ZStudentStarStudentListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
         
    self.loading = YES;
    [self setCollectionViewRefreshFooter];
    [self setCollectionViewRefreshHeader];
    [self setCollectionViewEmptyDataDelegate];
}

- (void)setDataSource {
    [super setDataSource];
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(30), CGFloatIn750(20), CGFloatIn750(30));
    self.minimumLineSpacing = CGFloatIn750(20);
    self.minimumInteritemSpacing = CGFloatIn750(20);
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    if (self.type == 0) {
        [self.navigationItem setTitle:@"学员"];
    }else{
        [self.navigationItem setTitle:@"教师"];
    }
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    for (ZOriganizationTeacherListModel *model in self.dataSources) {
        if (self.type == 0) {
            model.isStarStudent = YES;
        }
        
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentStarNewListCollectionViewCell className] title:[ZStudentStarNewListCollectionViewCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZStudentStarNewListCollectionViewCell zz_getCollectionCellSize] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:cellConfig];
    }
}

#pragma mark collectionview delegate
- (void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    __weak typeof(self) weakSelf = self;
    if ([cellConfig.title isEqualToString:@"ZStudentStarNewListCollectionViewCell"]) {
        ZStudentStarNewListCollectionViewCell *lcell = (ZStudentStarNewListCollectionViewCell *)cell;
        lcell.detailBlock = ^(UIImageView * imageView) {
            ZOriganizationTeacherListModel *listModel = cellConfig.dataModel;
            if (weakSelf.type == 0) {
                ZStudentStudentDetailVC *dvc = [[ZStudentStudentDetailVC alloc] init];
                dvc.student_id = listModel.teacherID;
                [weakSelf.navigationController pushViewController:dvc animated:YES];
            }else{
                ZStudentTeacherDetailVC *dvc = [[ZStudentTeacherDetailVC alloc] init];
                dvc.teacher_id = listModel.teacherID;
                dvc.stores_id = weakSelf.stores_id;
                [weakSelf.navigationController pushViewController:dvc animated:YES];
            }
            
//            ZStudentStarStudentInfoVC *ivc = [[ZStudentStarStudentInfoVC alloc] init];
//            [self.navigationController pushViewController:ivc animated:YES];
        };
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZStudentStarStudentInfoVC *ivc = [[ZStudentStarStudentInfoVC alloc] init];
    [self.navigationController pushViewController:ivc animated:YES];
}

#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self refreshHeadData:[self setPostCommonData]];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    if (self.type == 0) {
        [ZOriganizationStudentViewModel getStarStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
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
    }else{
        [ZOriganizationTeacherViewModel getTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
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
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    NSMutableDictionary *param = [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    if (self.type == 0) {
        [ZOriganizationStudentViewModel getStarStudentList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
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
    }else{
        [ZOriganizationTeacherViewModel getTeacherList:param completeBlock:^(BOOL isSuccess, ZOriganizationTeacherListNetModel *data) {
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
}

- (NSMutableDictionary *)setPostCommonData {
    NSMutableDictionary *param = @{@"page":[NSString stringWithFormat:@"%ld",self.currentPage]}.mutableCopy;
       [param setObject:self.stores_id forKey:@"stores_id"];
//       [param setObject:@"0" forKey:@"status"];
    return param;
}
@end
