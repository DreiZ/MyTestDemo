//
//  ZOrganizationPhotoCollectionVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationPhotoCollectionVC.h"
#import "ZOrganizatioPhotosCollectionCell.h"

@interface ZOrganizationPhotoCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZOrganizationPhotoCollectionVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
         
    [self setNavigation];
    [self setMainView];
    [self setData];
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
}

- (void)setData {
    NSArray *stemparr = @[@"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnimudx9rj30u0190x6r.jpg",
      @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnik9gg1zj30rt167qv5.jpg",
      @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnih592ymj30u012mkjl.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnifebkgxj30u011i41n.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcni9yq6txj30in0skdh8.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcni67jfp0j30u01907wi.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcni0ntc2oj30ia0rfgpz.jpg",
    @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1gcnhw86vyej30rs15ojti.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcnhm4ar5rj30m90xc4mp.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcnhgm151mj30tm18gwrz.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcnhcwlaihj30u011in00.jpg",
    @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1gcnhbdlq2fj30hs0hsdin.jpg",
    @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1gcnh64taa2j30u011iqfx.jpg",
    @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1gcnh1f4yvfj30u0140dsy.jpg",
    @"http://tva1.sinaimg.cn/mw600/00831rSTly1gcngrcu9g5j30hs0m7ta9.jpg",
    ];
    _list = @[].mutableCopy;
    for (int i = 0; i < 80; i++) {
        ZBaseUnitModel *model = [[ZBaseUnitModel alloc] init];
        model.data = stemparr[i%14];
        [_list addObject:model];
    }
    [_iCollectionView reloadData];
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
//        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont fontContent]];
        [_bottomBtn setBackgroundColor:[UIColor colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            
        }];
    }
    return _bottomBtn;
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

@end


