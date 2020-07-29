//
//  ZCircleSearchVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleSearchVC.h"
#import "ZCircleRecommendCollectionCell.h"
#import "ZCircleHotLessonListCell.h"
#import "ZCircleSectionView.h"
#import "ZCircleHotSectionView.h"
#import "WSLWaterFlowLayout.h"
#import "ZNoDataCollectionViewCell.h"

#import "ZCircleReleaseViewModel.h"
#import "ZCircleMineViewModel.h"
#import "ZOriganizationLessonModel.h"

@interface ZCircleSearchVC ()<WSLWaterFlowLayoutDelegate>
@property (nonatomic,strong) WSLWaterFlowLayout *flowLayout;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) BOOL is_more;
@property (nonatomic,strong) NSMutableDictionary *param;

@property (nonatomic,strong) NSMutableArray *hotSearchList;
@property (nonatomic,strong) NSMutableArray *lessonList;
@end

@implementation ZCircleSearchVC


- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchType = kSearchHistoryCircleSearch;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.zChain_block_setNotShouldDecompressImages(^{

    });
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchView.iTextField) {
        [self.searchView.iTextField resignFirstResponder];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.searchView.iTextField && (self.searchView.iTextField.text.length == 0)) {
        [self.searchView.iTextField becomeFirstResponder];
    }
    self.loading = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyDataStr = @"暂无数据";
    self.loading = NO;
    
    self.param = @{}.mutableCopy;
    self.hotSearchList = @[].mutableCopy;
    self.lessonList = @[].mutableCopy;
    
    self.iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.iCollectionView registerClass:[ZCircleSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    
    [self.iCollectionView registerClass:[ZCircleSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    
    [self.iCollectionView registerClass:[ZCircleHotSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lessonHeader"];
    
//    [self initCellConfigArr];
//    [self.iCollectionView reloadData];
    [self getRecommondTags];
}


#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    if (ValidArray(self.dataSources)) {
        for (int i = 0; i < self.dataSources.count; i++) {
            ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleRecommendCollectionCell className] title:[ZCircleRecommendCollectionCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZCircleRecommendCollectionCell z_getCellSize:self.dataSources[i]] cellType:ZCellTypeClass dataModel:self.dataSources[i]];
            
            [self.cellConfigArr addObject:cellConfig];
        }
    }else{
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZNoDataCollectionViewCell className] title:[ZNoDataCollectionViewCell className] showInfoMethod:@selector(setTitle:) sizeOfCell:CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))-0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10)) *(160.0f)/(142.0)) cellType:ZCellTypeClass dataModel:@"暂无动态"];
        
        
        [self.cellConfigArr addObject:cellConfig];
    }
}

- (void)searchClick:(NSString *)text{
    [super searchClick:text];
    self.name = SafeStr(text);
    if (self.name.length > 0) {
        [self refreshData];
    }
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
    [self.iCollectionView registerClass:[ZCircleSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    self.iCollectionView.delegate = self;
    self.iCollectionView.dataSource = self;
    
    _flowLayout = [[WSLWaterFlowLayout alloc] init];
    _flowLayout.delegate = self;
    _flowLayout.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
    self.iCollectionView.collectionViewLayout = _flowLayout;
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
    if (section == 0) {
        if (ValidArray(self.lessonList)) {
            return [ZCircleHotSectionView z_getCellSize:nil];
        }
        return CGSizeMake(KScreenWidth, CGFloatIn750(86));
    }
    return CGSizeMake(KScreenWidth, CGFloatIn750(86));
}
/** 脚视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (ValidArray(self.dataSources)) {
        return 2;
    }
    return 1;
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

//返回头脚视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (ValidArray(self.lessonList)) {
            ZCircleHotSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lessonHeader" forIndexPath:indexPath];
            [headerView setTip:@"热门课程"];
            [headerView setIsMore:self.is_more];
            headerView.list = self.lessonList;
            headerView.menuBlock = ^(ZCircleDynamicLessonModel *model) {
                ZOriganizationLessonListModel *listmodel = [[ZOriganizationLessonListModel alloc] init];
                listmodel.lessonID = model.lesson_id;
                routePushVC(ZRoute_main_orderLessonDetail, listmodel, nil);
            };
            headerView.moreBlock = ^{
                routePushVC(ZRoute_circle_moreLesson, weakSelf.name, nil);
            };
            return headerView;
        }else{
            ZCircleSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
            [headerView setTip:@"热门发现"];
            return headerView;
        }
    }else{
        ZCircleSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        [headerView setTip:@""];
        return headerView;
    }
}


- (void)zz_collectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZCircleRecommendCollectionCell"]) {
        ZCircleRecommendCollectionCell *lcell = (ZCircleRecommendCollectionCell *)cell;
        ZCircleMineDynamicModel *model = cellConfig.dataModel;
        lcell.handleBlock = ^(NSInteger index) {
            routePushVC(ZRoute_circle_detial, model.dynamic, nil);
        };
    }
}


- (void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZCircleRecommendCollectionCell"]) {
        ZCircleMineDynamicModel *model = cellConfig.dataModel;
        routePushVC(ZRoute_circle_detial, model.dynamic, nil);
    }
}
#pragma mark - network
- (void)getRecommondTags{
    [ZCircleReleaseViewModel getDynamicTagList:@{} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && [data isKindOfClass:[ZCircleReleaseTagNetModel class]]) {
            ZCircleReleaseTagNetModel *model = (ZCircleReleaseTagNetModel *)data;
            [self.hotSearchList removeAllObjects];
            [self.hotSearchList addObjectsFromArray:model.list];
//            self.zChain_reload_ui();
            self.hotList = self.hotSearchList;
        }
    }];
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
            if (ValidArray(data.course)) {
                [weakSelf.lessonList removeAllObjects];
                [weakSelf.lessonList addObjectsFromArray:data.course];
            }
            weakSelf.is_more = [data.is_more boolValue];
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
            weakSelf.is_more = [data.is_more boolValue];
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
    if (ValidStr(self.name)) {
        [self.param setObject:self.name forKey:@"name"];
    }
}
@end

#pragma mark - RouteHandler
@interface ZCircleSearchVC (RouteHandler)<SJRouteHandler>

@end

@implementation ZCircleSearchVC (RouteHandler)

+ (NSString *)routePath {
    return ZRoute_circle_search;
}

+ (void)handleRequest:(SJRouteRequest *)request topViewController:(UIViewController *)topViewController completionHandler:(SJCompletionHandler)completionHandler {
    ZCircleSearchVC *routevc = [[ZCircleSearchVC alloc] init];
    [topViewController.navigationController pushViewController:routevc animated:YES];
}
@end
