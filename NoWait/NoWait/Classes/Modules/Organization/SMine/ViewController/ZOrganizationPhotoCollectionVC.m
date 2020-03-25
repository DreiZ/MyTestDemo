//
//  ZOrganizationPhotoCollectionVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationPhotoCollectionVC.h"
#import "ZOrganizatioPhotosCollectionCell.h"
#import "ZOriganizationPhotoViewModel.h"
#import "ZOriganizationLessonViewModel.h"
#import "ZAlertView.h"

@interface ZOrganizationPhotoCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) NSMutableDictionary *param;
@property (nonatomic,strong) NSMutableArray *uploadArr;
@property (nonatomic,strong) NSMutableArray *uploadNetArr;
@end

@implementation ZOrganizationPhotoCollectionVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
         
    [self setNavigation];
    [self setMainView];
}

- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"相册管理"];
}

- (void)setMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88) + safeAreaBottom() * 2)];
    footerView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [footerView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footerView);
        make.height.mas_equalTo(CGFloatIn750(88));
        make.bottom.equalTo(footerView.mas_bottom).offset(-safeAreaBottom());
    }];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88) + safeAreaBottom() * 2);
    }];
    
    [self.view addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(footerView.mas_top).offset(0);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.iCollectionView tt_addRefreshHeaderWithAction:^{
        [weakSelf refreshData];
    }];
    
    [self.iCollectionView tt_addLoadMoreFooterWithAction:^{
        [weakSelf refreshMoreData];
    }];
}


#pragma mark - 懒加载
- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        _iCollectionView.showsVerticalScrollIndicator = NO;
//
//        [_iCollectionView registerClass:[ZOrganizationLessonAddPhotosItemCell class] forCellWithReuseIdentifier:[ZOrganizationLessonAddPhotosItemCell className]];
    }
    
    return _iCollectionView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"上传图片" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            [ZPhotoManager sharedManager].maxImageSelected = 9;
            
            [[ZPhotoManager sharedManager] showSelectMenu:^(NSArray<LLImagePickerModel *> *list) {
                if (list && list.count > 0){
                    [weakSelf.uploadArr removeAllObjects];
                    [weakSelf.uploadNetArr removeAllObjects];
                    for (LLImagePickerModel *model in list) {
                        [weakSelf.uploadArr addObject:model.image];
                    }
                    [weakSelf updatePhotosStep1];
                }
            }];
        }];
    }
    return _bottomBtn;
}

- (NSMutableArray *)uploadArr {
    if (!_uploadArr) {
        _uploadArr = @[].mutableCopy;
    }
    return _uploadArr;
}

- (NSMutableArray *)uploadNetArr {
    if (!_uploadNetArr) {
        _uploadNetArr = @[].mutableCopy;
    }
    return _uploadNetArr;
}

- (NSMutableDictionary *)param {
    if (!_param) {
        _param = @{}.mutableCopy;
    }
    return _param;
}

-(NSMutableArray *)list {
    if (!_list) {
        _list = @[].mutableCopy;
    }
    return _list;
}

#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZOrganizatioPhotosCollectionCell *cell = [ZOrganizatioPhotosCollectionCell z_cellWithCollection:collectionView indexPath:indexPath];
//    ZOrganizatioPhotosCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZOrganizatioPhotosCollectionCell className] forIndexPath:indexPath];
    cell.delBlock = ^(ZOriganizationPhotoTypeListModel *model) {
        [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定删除此图片" leftBtnTitle:@"取消" rightBtnTitle:@"删除" handlerBlock:^(NSInteger index) {
            if (index == 1) {
                [self deleteData:model];
            }
        }];
        
    };
    cell.model = _list[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(30), CGFloatIn750(30), CGFloatIn750(30), CGFloatIn750(24));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth-CGFloatIn750(90))/2, (KScreenWidth-CGFloatIn750(90))/2 * (110.0f/165));
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
    [self.param setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [self.param setObject:SafeStr(self.model.type) forKey:@"type"];
}

#pragma mark - 上传图片
- (void)updatePhotosStep1 {
    [TLUIUtility showLoading:@"上传图片中"];
    NSInteger tindex = 0;
    [self updatePhotosStep2WithImage:tindex];
}

 - (void)updatePhotosStep2WithImage:(NSInteger)index {
     [self updatePhotosStep3WithImage:index complete:^(BOOL isSuccess, NSInteger index) {
         if (index == self.uploadArr.count-1) {
             [TLUIUtility showLoading:@"上传其他数据"];
             [self updateData];
         }else{
             index++;
             [self updatePhotosStep2WithImage:index];
         }
    }];
}

- (void)updatePhotosStep3WithImage:(NSInteger)index complete:(void(^)(BOOL, NSInteger))complete{
    [TLUIUtility showLoading:[NSString stringWithFormat:@"上传课程相册中 %ld/%ld",index+1,self.uploadArr.count]];
    
    id temp = self.uploadArr[index];
   
    UIImage *image;
    if ([temp isKindOfClass:[UIImage class]]) {
        image = temp;  
    }
    
    if (!image) {
        complete(YES,index);
        return;
    }
    __weak typeof(self) weakSelf = self;
    [ZOriganizationLessonViewModel uploadImageList:@{@"type":@"2",@"imageKey":@{@"file":image}} completeBlock:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [weakSelf.uploadNetArr addObject:message];
            complete(YES,index);
        }else{
            [TLUIUtility hiddenLoading];
            [TLUIUtility showErrorHint:message];
        }
    }];
}

#pragma mark - 上传图片url
- (void)updateData {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [params setObject:SafeStr(self.model.type) forKey:@"type"];
    NSMutableArray *imageUrlArr = @[].mutableCopy;
    for (NSString *imageUrl in self.uploadNetArr) {
        [imageUrlArr addObject:imageUrl];
    }
    [params setObject:imageUrlArr forKey:@"images"];
    
    [TLUIUtility showLoading:@""];
    [ZOriganizationPhotoViewModel addImage:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [self refreshAllData];
            [TLUIUtility showSuccessHint:message];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}

- (void)deleteData:(ZOriganizationPhotoTypeListModel *)model {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:SafeStr([ZUserHelper sharedHelper].school.schoolID) forKey:@"stores_id"];
    [params setObject:SafeStr(model.imageID) forKey:@"id"];
    
    [TLUIUtility showLoading:@""];
    [ZOriganizationPhotoViewModel delImage:params completeBlock:^(BOOL isSuccess, NSString *message) {
        [TLUIUtility hiddenLoading];
        if (isSuccess) {
            [self refreshAllData];
            [TLUIUtility showSuccessHint:message];
            return ;
        }else {
            [TLUIUtility showErrorHint:message];
        }
    }];
}
@end
