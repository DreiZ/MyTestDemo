//
//  ZStudentOrganizationDetailIntroListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailIntroListVC.h"
#import "ZOrganizationDetailIntroCollectionViewCell.h"
#import "ZOriganizationPhotoViewModel.h"

@interface ZStudentOrganizationDetailIntroListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) NSMutableDictionary *param;

@end

@implementation ZStudentOrganizationDetailIntroListVC

- (void)viewDidLoad {
    [super viewDidLoad];
         
    self.loading = YES;
    
    [self setData];
    [self refreshData];
    
    [self setCollectionViewRefreshFooter];
    [self setCollectionViewRefreshHeader];
    [self setCollectionViewEmptyDataDelegate];
    [self setEmptyDataStr:@"暂无图片"];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:self.imageModel.name];
}

- (void)setupMainView {
    [super setupMainView];
    

}

- (void)setData {
    _list = @[].mutableCopy;
    _param = @{}.mutableCopy;
    
    self.edgeInsets = UIEdgeInsetsMake(CGFloatIn750(24), CGFloatIn750(30), CGFloatIn750(24), CGFloatIn750(30));
    self.minimumLineSpacing = CGFloatIn750(20);
    self.minimumInteritemSpacing = CGFloatIn750(20);
    self.iCollectionView.scrollEnabled = YES;
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    [self.list enumerateObjectsUsingBlock:^(ZOriganizationPhotoTypeListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZOrganizationDetailIntroCollectionViewCell className] title:[ZOrganizationDetailIntroCollectionViewCell className] showInfoMethod:@selector(setImage:) sizeOfCell:[ZOrganizationDetailIntroCollectionViewCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:obj.images_url];
        [self.cellConfigArr addObject:cellConfig];
    }];
}
#pragma mark collectionview delegate
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return _list.count;
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    ZOrganizationDetailIntroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZOrganizationDetailIntroCollectionViewCell className] forIndexPath:indexPath];
//    ZOriganizationPhotoTypeListModel *model = self.list[indexPath.row];
//    [cell.detailImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.images_url)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
//    return cell;
//}

- (void)zz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
//    NSMutableArray *temp = @[].mutableCopy;
//    for (int i = 0; i < self.list.count; i++) {
//        ZOriganizationPhotoTypeListModel *model = self.list[i];
//        [temp addObject:model.images_url];
//    }
//    [[ZImagePickerManager sharedManager] showBrowser:temp withIndex:indexPath.row];
    ZOriganizationPhotoTypeListModel *model = self.list[indexPath.row];
    [[ZVideoPlayerManager sharedInstance] playVideoWithNSUrl:[NSURL URLWithString:model.images_url] title:@"视频"];
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
    [ZOriganizationPhotoViewModel getStoresTypeImageList:param completeBlock:^(BOOL isSuccess, ZOriganizationPhotoTypeListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.list removeAllObjects];
            [weakSelf.list addObjectsFromArray:data.list];
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
    [ZOriganizationPhotoViewModel getStoresTypeImageList:self.param completeBlock:^(BOOL isSuccess, ZOriganizationPhotoTypeListNetModel *data) {
        weakSelf.loading = NO;
        if (isSuccess && data) {
            [weakSelf.list addObjectsFromArray:data.list];
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
    [_param setObject:[NSString stringWithFormat:@"%ld",self.currentPage * 10] forKey:@"page_size"];
    
    [self refreshHeadData:_param];
}

- (void)setPostCommonData {
    [self.param setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.param setObject:SafeStr(self.detailModel.schoolID) forKey:@"stores_id"];
    [self.param setObject:SafeStr(self.imageModel.type) forKey:@"type"];
}
@end

