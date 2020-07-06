//
//  ZCollectionSearchVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZSearchFieldView.h"
#import "ZHistoryModel.h"

@interface ZCollectionSearchVC : ZViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) ZSearchFieldView *searchView;
@property (nonatomic,strong) NSString *searchType;
@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic,strong) NSArray *hotList;

@property (nonatomic,assign) CGFloat minimumInteritemSpacing;
@property (nonatomic,assign) CGFloat minimumLineSpacing;
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
@property (nonatomic,assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) UIView *safeFooterView;

@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;


- (void)valueChange:(NSString *)text;
- (void)searchClick:(NSString *)text;
- (void)cancleBtnOnClick;

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

