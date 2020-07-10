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
#import "ZCircleMineViewModel.h"
#import "ZCircleMineModel.h"

#import "ZCircleMyFocusListVC.h"
#import "ZCircleMyFansListVC.h"
#import "ZStudentMineSettingMineEditVC.h"


@interface ZCircleMineCollectionVC ()
@property (nonatomic,strong) ZCircleMineHeaderView *headView;
@property (nonatomic,strong) ZCircleMineSectionView *sectionView;
@property (nonatomic,assign) BOOL isLike;
@property (nonatomic,strong) ZCircleMineModel *mineModel;
@property (nonatomic,assign) CGFloat headHeight;

@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZCircleMineCollectionVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.loading = YES;
    self.headHeight = CGFloatIn750(292);
    [self setCollectionViewEmptyDataDelegate];
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
    [self getMineInfo];
    [self refreshData];
    
    [self setCollectionViewRefreshFooter];
    [self setCollectionViewRefreshHeader];
//    [self setCollectionViewEmptyDataDelegate];
}


- (void)setDataSource {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    [super setDataSource];
    
    self.param = @{}.mutableCopy;
    self.headHeight = CGFloatIn750(292);
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
    self.headView.frame = CGRectMake(0, -self.headHeight, KScreenWidth, self.headHeight);
    self.iCollectionView.contentInset = UIEdgeInsetsMake(self.headHeight, 0, 0, 0);
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    [self.cellConfigArr removeAllObjects];
    if (ValidArray(self.dataSources)) {
        [self.dataSources enumerateObjectsUsingBlock:^(ZCircleMineDynamicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCollectionCell className] title:[ZCircleMineDynamicCollectionCell className] showInfoMethod:@selector(setModel:) sizeOfCell:CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3-0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3 *(160.0f)/(142.0)) cellType:ZCellTypeClass dataModel:obj];
            
            
            [self.cellConfigArr addObject:cellConfig];
        }];
    }else{
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMineDynamicCollectionCell className] title:[ZCircleMineDynamicCollectionCell className] showInfoMethod:@selector(setModel:) sizeOfCell:CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3-0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3 *(160.0f)/(142.0)) cellType:ZCellTypeClass dataModel:nil];
        
        
        [self.cellConfigArr addObject:cellConfig];
    }
    
}

#pragma mark - view
- (ZCircleMineHeaderView *)headView {
    if (!_headView) {
        __weak typeof(self) weakSelf = self;
        _headView = [[ZCircleMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.headHeight)];
        _headView.handleBlock = ^(NSInteger index) {
            DLog(@"----%ld", (long)index);
            if (index == 0) {
                
            }else if(index == 1){
                ZCircleMyFocusListVC *lvc = [[ZCircleMyFocusListVC alloc] init];
                if (weakSelf.account) {
                    lvc.account = weakSelf.account;
                }else{
                    lvc.account = [ZUserHelper sharedHelper].user.userCodeID;
                }
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            }else if(index == 2){
                ZCircleMyFansListVC *lvc = [[ZCircleMyFansListVC alloc] init];
                if (weakSelf.account) {
                    lvc.account = weakSelf.account;
                }else{
                    lvc.account = [ZUserHelper sharedHelper].user.userCodeID;
                }
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
                edit.text = weakSelf.mineModel.autograph;
                edit.handleBlock = ^(NSString *text) {
                    if (ValidStr(text)) {
                        weakSelf.mineModel.autograph = text;
                        weakSelf.headView.model = weakSelf.mineModel;
                        [weakSelf updateUserInfo:text];
                    }
                };
                [weakSelf.navigationController pushViewController:edit animated:YES];
            }else if(index == 5){
                //关注
            }
        };
    }
    return _headView;
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
                    weakSelf.isLike = NO;
                }else{
                    weakSelf.isLike = YES;
                }
                [weakSelf refreshData];
            };
            [sectionView setDynamic:self.mineModel.dynamic like:self.mineModel.enjoy];
            self.sectionView = sectionView;
        }
        return sectionView;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0 &&  scrollView.contentOffset.y > -self.headHeight) {
        self.iCollectionView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= 0) {
        self.iCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.iCollectionView.contentInset = UIEdgeInsetsMake(self.headHeight, 0, 0, 0);
    }
}

- (void)getMineInfo {
    __weak typeof(self) weakSelf = self;
    [ZCircleMineViewModel getCircleMineData:@{@"account":[ZUserHelper sharedHelper].user.userCodeID} completeBlock:^(BOOL isSuccess, id data) {
        if (isSuccess && [data isKindOfClass:[ZCircleMineModel class]]) {
            weakSelf.mineModel = data;
            if (!weakSelf.account || ([weakSelf.account isEqualToString:[ZUserHelper sharedHelper].user.userCodeID])) {
                weakSelf.mineModel.isMine = YES;
            }
            [weakSelf.sectionView setDynamic:weakSelf.mineModel.dynamic like:weakSelf.mineModel.enjoy];
            weakSelf.headView.model = weakSelf.mineModel;
            [weakSelf setHeadViewHeight];
            [weakSelf.navigationItem setTitle:weakSelf.mineModel.nick_name];
        }
    }];
}

- (void)setHeadViewHeight {
    if (ValidStr(self.mineModel.autograph)) {
        CGSize tempSize = [self.mineModel.autograph tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(60), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        self.headHeight = tempSize.height + CGFloatIn750(292);
    }else if(self.mineModel.isMine){
        self.headHeight = CGFloatIn750(318);
    }
    
    self.headView.frame = CGRectMake(0, -self.headHeight, KScreenWidth, self.headHeight);
    self.iCollectionView.contentInset = UIEdgeInsetsMake(self.headHeight, 0, 0, 0);
}

- (void)updateUserInfo:(NSString *)text {
    [ZCircleMineViewModel updateUserAutograph:@{@"autograph":SafeStr(text)} completeBlock:^(BOOL isSuccess, id data) {
        [TLUIUtility showInfoHint:data];
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
    [ZCircleMineViewModel getDynamicsList:param isLike:self.isLike completeBlock:^(BOOL isSuccess, ZCircleMineDynamicNetModel *data) {
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
    [ZCircleMineViewModel getDynamicsList:self.param isLike:self.isLike completeBlock:^(BOOL isSuccess, ZCircleMineDynamicNetModel *data) {
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
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 12] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:@"12" forKey:@"page_size"];
    [self.param setObject:self.account? self.account:[ZUserHelper sharedHelper].user.userCodeID forKey:@"account"];
}
@end
