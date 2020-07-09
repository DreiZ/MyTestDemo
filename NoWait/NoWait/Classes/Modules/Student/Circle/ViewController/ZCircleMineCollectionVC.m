//
//  ZCircleMineCollectionVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineCollectionVC.h"

#import "ZCircleMineDynamicCollectionCell.h"
#import "ZCircleMineDynamicCollectionListCell.h"

#import "ZCircleMineHeaderView.h"
#import "ZCircleMineSectionView.h"
#import "ZJWaterLayout.h"

#import "ZCircleMineCollectionViewFlowLayout.h"

#import "ZCircleMyFocusListVC.h"
#import "ZCircleMyFansListVC.h"
#import "ZStudentMineSettingMineEditVC.h"


@interface ZCircleMineCollectionVC ()
@property (nonatomic,strong) ZCircleMineHeaderView *headView;
@property (nonatomic,assign) BOOL isCollection;
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
    
    ZCircleMineCollectionViewFlowLayout *flowLayout = [[ZCircleMineCollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(KScreenWidth, CGFloatIn750(80));
    
    //设置headerView大小
    [self.iCollectionView registerClass:[ZCircleMineSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZCircleMineSectionView"];  //  一定要设置
    [self.iCollectionView setCollectionViewLayout:flowLayout];
    [self.iCollectionView addSubview:self.headView];
    self.headView.frame = CGRectMake(0, -CGFloatIn750(318), KScreenWidth, CGFloatIn750(318));
    self.iCollectionView.contentInset = UIEdgeInsetsMake(CGFloatIn750(318), 0, 0, 0);
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    [self.cellConfigArr removeAllObjects];
    ZCellConfig *cellConfig;
    if (_isCollection) {
        cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCollectionCell className] title:[ZCircleMineDynamicCollectionCell className] showInfoMethod:nil sizeOfCell:CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3-0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3 *(160.0f)/(142.0)) cellType:ZCellTypeClass dataModel:nil];
    }else{
       cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCollectionListCell className] title:[ZCircleMineDynamicCollectionListCell className] showInfoMethod:@selector(setList:) sizeOfCell:[ZCircleMineDynamicCollectionListCell z_getCellSize:@[@"",@"",@""]] cellType:ZCellTypeClass dataModel:@[@"",@"",@""]];
    }
    
    
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
        __weak typeof(self) weakSelf = self;
        CGSize tempSize = [@"这个颜色太神奇了" tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(60), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        _headView = [[ZCircleMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(292)+tempSize.height)];
        _headView.handleBlock = ^(NSInteger index) {
            DLog(@"----%ld", (long)index);
            if (index == 0) {
                
            }else if(index == 1){
                ZCircleMyFocusListVC *lvc = [[ZCircleMyFocusListVC alloc] init];
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }else if(index == 2){
                ZCircleMyFansListVC *lvc = [[ZCircleMyFansListVC alloc] init];
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }else if(index == 4){
                //签名
                ZStudentMineSettingMineEditVC *edit = [[ZStudentMineSettingMineEditVC alloc] init];
                edit.navTitle = @"设置个性签名";
                edit.formatter = ZFormatterTypeAnyByte;
                edit.max = 90;
                edit.hitStr = @"签名只可有汉字字母数字下划线组成，90字节以内";
                edit.showHitStr = @"你还没有输入任何签名";
                edit.placeholder = @"请输入签名";
//                edit.text = weakSelf.user.nikeName;
                edit.handleBlock = ^(NSString *text) {
//                    weakSelf.user.nikeName = text;
                    [weakSelf initCellConfigArr];
                    [weakSelf.iCollectionView reloadData];
//                    [weakSelf updateUserInfo:@{@"nick_name":SafeStr(weakSelf.user.nikeName)}];
                };
                [weakSelf.navigationController pushViewController:edit animated:YES];
            }else if(index == 5){
                //关注
            }
        };
    }
    return _headView;
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
    if (!self.isCollection) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self.edgeInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (!self.isCollection) {
        return 0;
    }
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (!self.isCollection) {
        return 0;
    }
    return self.minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = self.cellConfigArr[indexPath.row];
    CGSize cellSize =  cellConfig.sizeOfCell;
    return cellSize;
}
//
//- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//    [headerView addSubview:self.headView];
//    return headerView;
//}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        ZCircleMineSectionView *sectionView = nil;
        __weak typeof(self) weakSelf = self;
        if (sectionView==nil) {
            sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZCircleMineSectionView" forIndexPath:indexPath];
            sectionView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
            sectionView.frame = CGRectMake(0, 0, KScreenWidth, CGFloatIn750(80));
            sectionView.handleBlock = ^(NSInteger index) {
                if (index == 0) {
                    weakSelf.isCollection = NO;
                }else{
                    weakSelf.isCollection = YES;
                }
                [weakSelf initCellConfigArr];
                [weakSelf.iCollectionView reloadData];
            };
        }
        return sectionView;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0 &&  scrollView.contentOffset.y > -CGFloatIn750(318)) {
        self.iCollectionView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= 0) {
        self.iCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.iCollectionView.contentInset = UIEdgeInsetsMake(CGFloatIn750(318), 0, 0, 0);
    }
}
@end
