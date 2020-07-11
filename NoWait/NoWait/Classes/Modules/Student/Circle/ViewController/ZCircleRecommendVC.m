//
//  ZCircleRecommendVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleRecommendVC.h"
#import "ZCircleRecommendCollectionCell.h"
#import "ZCircleDetailVC.h"
#import "ZJWaterLayout.h"

#import "ZCircleMineModel.h"
#import "ZCircleMineViewModel.h"

@interface ZCircleRecommendVC ()<ZJWaterLayoutDelegate>
/** ZJWaterLayout */
@property (nonatomic, strong) ZJWaterLayout *layout;
@property (nonatomic, strong) NSMutableDictionary *param;

@end

@implementation ZCircleRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCollectionViewEmptyDataDelegate];
    [self setCollectionViewRefreshFooter];
    [self setCollectionViewRefreshHeader];
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
    [self setCollectionViewGaryBack];
    
    [self refreshData];
}

- (void)setDataSource {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    [super setDataSource];

    self.param = @{}.mutableCopy;
    
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(10), CGFloatIn750(20), CGFloatIn750(10));
    
    self.iCollectionView.scrollEnabled = YES;
    self.iCollectionView.backgroundView.backgroundColor = adaptAndDarkColor([UIColor colorRedDefault], [UIColor colorGrayBGDark]);
    
    _layout = [[ZJWaterLayout alloc] init];
    _layout.delegate = self;
    _layout.waterDirection = ZJWaterVertical;
    
    self.iCollectionView.collectionViewLayout = _layout;
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    [self.cellConfigArr removeAllObjects];
    for (int i = 0; i < self.dataSources.count; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleRecommendCollectionCell className] title:[ZCircleRecommendCollectionCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZCircleRecommendCollectionCell z_getCellSize:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
        
        [self.cellConfigArr addObject:cellConfig];
    }
    
}

#pragma mark - ZJWaterLayoutDelegate
/** 几列 */
-(NSInteger)waterFlowLayoutColumnCount:(ZJWaterLayout *)layout
{
    return 2;
}

-(CGFloat)waterFlowLayout:(ZJWaterLayout *)layout hieghtForItemAtIndex:(NSUInteger)index itemwidth:(CGFloat)itemwidth
{
    ZCellConfig *cellconfig = self.cellConfigArr[index];
    return cellconfig.sizeOfCell.height;
}
/** 边距 */
- (UIEdgeInsets)waterFlowLayoutEdgeInsets:(ZJWaterLayout *)layout
{
    return UIEdgeInsetsMake(CGFloatIn750(10), CGFloatIn750(30), CGFloatIn750(10), CGFloatIn750(30));
}


- (void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZCircleRecommendCollectionCell"]) {
        ZCircleRecommendCollectionCell *lcell = (ZCircleRecommendCollectionCell *)cell;
        lcell.handleBlock = ^(NSInteger index) {
            DLog(@"-----%ld", (long)index);
            ZCircleDetailVC *dvc = [[ZCircleDetailVC alloc] init];
            [self.navigationController pushViewController:dvc animated:YES];
        };
        
    }
}

-(void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZCircleRecommendCollectionCell"]) {
        ZCircleDetailVC *dvc = [[ZCircleDetailVC alloc] init];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}


#pragma mark - 数据处理
- (void)refreshData {
    self.currentPage = 1;
    self.loading = YES;
    [self setPostCommonData];
    [self refreshHeadData:_param];
}

- (void)refreshHeadData:(NSDictionary *)param {
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel getRecommondDynamicsList:param completeBlock:^(BOOL isSuccess, ZCircleMineDynamicNetModel *data) {
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
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel getRecommondDynamicsList:self.param completeBlock:^(BOOL isSuccess, ZCircleMineDynamicNetModel *data) {
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

- (void)refreshAllData {
    self.loading = YES;
    
    [self setPostCommonData];
    [_param setObject:@"1" forKey:@"page"];
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:@"10" forKey:@"page_size"];
}
@end
