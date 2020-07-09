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

@interface ZCircleRecommendVC ()<ZJWaterLayoutDelegate>
/** ZJWaterLayout */
@property (nonatomic, strong) ZJWaterLayout *layout;
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
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(10), CGFloatIn750(20), CGFloatIn750(10));
//    self.minimumLineSpacing = CGFloatIn750(8);
//    self.minimumInteritemSpacing = CGFloatIn750(8);
    self.iCollectionView.scrollEnabled = YES;
    self.iCollectionView.backgroundView.backgroundColor = adaptAndDarkColor([UIColor colorRedDefault], [UIColor colorGrayBGDark]);
    
//    _flowLayout = [[WSLWaterFlowLayout alloc] init];
//    _flowLayout.delegate = self;
//    _flowLayout.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
//    self.iCollectionView.collectionViewLayout = _flowLayout;
    
    ZJWaterLayout *layout = [[ZJWaterLayout alloc] init];
    layout.delegate = self;
    layout.waterDirection = ZJWaterVertical;
    
    self.iCollectionView.collectionViewLayout = layout;
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < 50; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleRecommendCollectionCell className] title:[ZCircleRecommendCollectionCell className] showInfoMethod:@selector(setTitle:) sizeOfCell:[ZCircleRecommendCollectionCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:[NSString stringWithFormat:@"%d",i+1]];
        
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
@end
