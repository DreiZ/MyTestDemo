//
//  ZCircleRecommendVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleRecommendVC.h"
#import "ZCircleRecommendCollectionCell.h"
#import "ZJWaterLayout.h"

#import "ZCircleMineModel.h"
#import "ZCircleMineViewModel.h"
#import "ZLocationManager.h"

@interface ZCircleRecommendVC ()<ZJWaterLayoutDelegate>
/** ZJWaterLayout */
@property (nonatomic, strong) ZJWaterLayout *layout;
@property (nonatomic, strong) NSMutableDictionary *param;

@end

@implementation ZCircleRecommendVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([ZUserHelper sharedHelper].user) {
        self.emptyDataStr = @"暂无数据，点击重新加载";
    }else {
        self.emptyDataStr = @"您还没有登录";
    }
    [self refreshAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_routeDict) {
        if ([_routeDict objectForKey:@"stores_id"]) {
            _stores_id = _routeDict[@"stores_id"];
        }
        
        if ([_routeDict objectForKey:@"stores_name"]) {
            _stores_name = _routeDict[@"stores_name"];
        }
    }
    
    [self setCollectionViewEmptyDataDelegate];
    [self setCollectionViewRefreshFooter];
    [self setCollectionViewRefreshHeader];
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
    [self setCollectionViewGaryBack];
    if (self.stores_name) {
        [self.navigationItem setTitle:self.stores_name];
    }
}

- (void)setDataSource {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    [super setDataSource];

    self.param = @{}.mutableCopy;
    
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(0), CGFloatIn750(10), CGFloatIn750(20), CGFloatIn750(10));
    
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
    return UIEdgeInsetsMake(CGFloatIn750(0), CGFloatIn750(30), CGFloatIn750(10), CGFloatIn750(30));
}


- (void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZCircleRecommendCollectionCell"]) {
        ZCircleRecommendCollectionCell *lcell = (ZCircleRecommendCollectionCell *)cell;
        ZCircleMineDynamicModel *model = cellConfig.dataModel;
        lcell.handleBlock = ^(NSInteger index) {
            routePushVC(ZRoute_circle_detial, model.dynamic, ^(id  _Nullable result, NSError * _Nullable error) {
                
            });
        };
    }
}

-(void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZCircleRecommendCollectionCell"]) {
        ZCircleMineDynamicModel *model = cellConfig.dataModel;
        routePushVC(ZRoute_circle_detial, model.dynamic, ^(id  _Nullable result, NSError * _Nullable error) {
            
        });
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
    if (self.isAttention) {
        [ZCircleMineViewModel getFollowRecommondDynamicsList:param completeBlock:^(BOOL isSuccess, ZCircleMineDynamicNetModel *data) {
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
}

- (void)refreshMoreData {
    self.currentPage++;
    self.loading = YES;
    [self setPostCommonData];
    
    __weak typeof(self) weakSelf = self;
    if (self.isAttention) {
        [ZCircleMineViewModel getFollowRecommondDynamicsList:self.param completeBlock:^(BOOL isSuccess, ZCircleMineDynamicNetModel *data) {
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
    if (ValidStr(self.stores_id)) {
        [self.param setObject:self.stores_id forKey:@"stores_id"];
    }
    
    [self setLocationParams];
}

- (void)setLocationParams {
    if ([ZLocationManager shareManager].cureUserLocation.location) {
        [self.param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.longitude] forKey:@"longitude"];
        [self.param setObject:[NSString stringWithFormat:@"%f",[ZLocationManager shareManager].cureUserLocation.coordinate.latitude] forKey:@"latitude"];
    }
}
@end

#pragma mark - RouteHandler
@interface ZCircleRecommendVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZCircleRecommendVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_recommend;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZCircleRecommendVC *routevc = [[ZCircleRecommendVC alloc] init];
    routevc.routeDict = request.prts;
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
