//
//  ZCircleMineCollectionVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineCollectionVC.h"
#import "ZCircleMineDynamicCollectionCell.h"
#import "ZCircleMineHeaderView.h"
#import "ZCircleMineSectionView.h"

@interface ZCircleMineCollectionVC ()
@property (nonatomic,strong) ZCircleMineHeaderView *headView;
@property (nonatomic,strong) ZCircleMineSectionView *sectionView;

@end

@implementation ZCircleMineCollectionVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.loading = YES;
    
    [self setCollectionViewEmptyDataDelegate];
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
}


- (void)setDataSource {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    [super setDataSource];
    
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(40), CGFloatIn750(30), CGFloatIn750(40), CGFloatIn750(30));
    self.minimumLineSpacing = CGFloatIn750(4);
    self.minimumInteritemSpacing = CGFloatIn750(4);
    self.iCollectionView.scrollEnabled = YES;
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"个人中心"];
}

- (void)setupMainView {
    [super setupMainView];
    self.iCollectionView.delegate = self;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(KScreenWidth, CGFloatIn750(318));  //设置headerView大小
    [self.iCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];  //  一定要设置
    [self.iCollectionView setCollectionViewLayout:flowLayout];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCollectionCell className] title:[ZCircleMineDynamicCollectionCell className] showInfoMethod:nil sizeOfCell:CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3 *(160.0f)/(142.0)) cellType:ZCellTypeClass dataModel:nil];
    
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
    [self.cellConfigArr addObject:cellConfig];
}

#pragma mark - view
- (ZCircleMineHeaderView *)headView {
    if (!_headView) {
        CGSize tempSize = [@"这个颜色太神奇了" tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(60), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        _headView = [[ZCircleMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(292)+tempSize.height)];
        
    }
    return _headView;
}

- (ZCircleMineSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[ZCircleMineSectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(76))];
    }
    return _sectionView;
}

#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellConfigArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCellConfig *cellConfig = [self.cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCollectionViewCell *cell;
    cell = (ZBaseCollectionViewCell*)[cellConfig cellOfCellConfigWithCollection:collectionView indexPath:indexPath dataModel:cellConfig.dataModel];
    [self zz_collectionView:collectionView cell:cell cellForItemAtIndexPath:indexPath cellConfig:cellConfig];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [self.cellConfigArr objectAtIndex:indexPath.row];
    [self zz_collectionView:collectionView didSelectItemAtIndexPath:indexPath cellConfig:cellConfig];
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.edgeInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = self.cellConfigArr[indexPath.row];
    CGSize cellSize =  cellConfig.sizeOfCell;
    return cellSize;
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [headerView addSubview:self.headView];
    return headerView;
}
@end
