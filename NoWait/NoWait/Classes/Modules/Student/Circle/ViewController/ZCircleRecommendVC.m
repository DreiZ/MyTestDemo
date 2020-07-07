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

@interface ZCircleRecommendVC ()<WSLWaterFlowLayoutDelegate>
@property (nonatomic,strong) WSLWaterFlowLayout * flowLayout;

@end

@implementation ZCircleRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCollectionViewEmptyDataDelegate];
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
    [self setCollectionViewGaryBack];
}

- (void)setDataSource {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    [super setDataSource];
//
//    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(10), CGFloatIn750(20), CGFloatIn750(10));
//    self.minimumLineSpacing = CGFloatIn750(8);
//    self.minimumInteritemSpacing = CGFloatIn750(8);
    self.iCollectionView.scrollEnabled = YES;
    self.iCollectionView.backgroundView.backgroundColor = adaptAndDarkColor([UIColor colorRedDefault], [UIColor colorGrayBGDark]);
    
    _flowLayout = [[WSLWaterFlowLayout alloc] init];
    _flowLayout.delegate = self;
    _flowLayout.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
    self.iCollectionView.collectionViewLayout = _flowLayout;
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < 50; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleRecommendCollectionCell className] title:[ZCircleRecommendCollectionCell className] showInfoMethod:@selector(setTitle:) sizeOfCell:[ZCircleRecommendCollectionCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:[NSString stringWithFormat:@"%d",i+1]];
        
        [self.cellConfigArr addObject:cellConfig];
    }
    
}

#pragma mark - WSLWaterFlowLayoutDelegate
//返回每个item大小
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(waterFlowLayout.flowLayoutStyle == (WSLWaterFlowLayoutStyle)0){
        ZCellConfig *cellconfig = self.cellConfigArr[indexPath.row];
        return cellconfig.sizeOfCell;
    }else{
        return CGSizeMake(0, 0);
    }
}

/** 头视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}
/** 脚视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}
///** 行数*/
//-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
//    return 100;
//}
/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return CGFloatIn750(20);
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return CGFloatIn750(20);
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return UIEdgeInsetsMake(CGFloatIn750(10), CGFloatIn750(30), CGFloatIn750(30), CGFloatIn750(30));
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
@end
