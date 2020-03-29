//
//  ZCollectionVIewController.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCollectionVIewController : ZViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign) CGFloat minimumInteritemSpacing;
@property (nonatomic,assign) CGFloat minimumLineSpacing;
@property (nonatomic,assign) UIEdgeInsets edgeInsets;

@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) UIView *safeFooterView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

- (void)setupMainView;

//重写数据方法
- (void)refreshMoreData;
- (void)setDataSource;
- (void)initCellConfigArr;
- (void)setCollectionViewGaryBack;
- (void)setCollectionViewWhiteBack;

//设置CollectionView 刷新数据 空数据代理
- (void)setCollectionViewRefreshHeader;
- (void)setCollectionViewRefreshFooter;
- (void)setCollectionViewEmptyDataDelegate;

-(void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig;

- (void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig;
@end

NS_ASSUME_NONNULL_END
