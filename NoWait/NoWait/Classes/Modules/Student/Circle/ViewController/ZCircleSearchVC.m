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

@interface ZCircleSearchVC ()<WSLWaterFlowLayoutDelegate>
@property (nonatomic,strong) WSLWaterFlowLayout *flowLayout;
@property (nonatomic,strong) NSString *name;
@end

@implementation ZCircleSearchVC


- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchType = kSearchHistoryLessonSearch;
    }
    return self;
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
    
    self.hotList = @[@"",@"",@"",@""];
    
    [self.iCollectionView registerClass:[ZCircleSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    
    [self.iCollectionView registerClass:[ZCircleSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    
    [self.iCollectionView registerClass:[ZCircleHotSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lessonHeader"];
    
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
}


#pragma mark - setdata
- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < 5; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleRecommendCollectionCell className] title:[ZCircleRecommendCollectionCell className] showInfoMethod:@selector(setTitle:) sizeOfCell:[ZCircleRecommendCollectionCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:[NSString stringWithFormat:@"%d",i+1]];
        
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
        return [ZCircleHotSectionView z_getCellSize:nil];
    }
    return CGSizeMake(KScreenWidth, CGFloatIn750(86));
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

//返回头脚视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZCircleHotSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lessonHeader" forIndexPath:indexPath];
        [headerView setTip:@"热门课程"];
        headerView.list = self.hotList;
        return headerView;
        
    }else{
        ZCircleSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        [headerView setTip:@"热门发现"];
        return headerView;
    }
}

@end
