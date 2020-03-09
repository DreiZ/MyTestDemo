//
//  ZStudentStarStudentListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarStudentListVC.h"
#import "ZStudentDetailModel.h"
#import "ZStudentStarListCollectionViewCell.h"
#import "ZStudentStarNewListCollectionViewCell.h"

#import "ZStudentStarStudentInfoVC.h"

@interface ZStudentStarStudentListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation ZStudentStarStudentListVC

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
    [self.navigationItem setTitle:@"明星学员"];
}

- (void)setMainView {
    self.view.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self.view addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
}

- (void)setData {
    _list = @[].mutableCopy;
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
    for (int i = 0; i < 80; i++) {
        ZStudentDetailLessonOrderCoachModel *model = [[ZStudentDetailLessonOrderCoachModel alloc] init];
        model.coachName = @"张思思";
        model.coachImage = stemparr[i%14];
        model.adeptArr = @[@"擅长游泳"];
        [_list addObject:model];
    }
    
    [_iCollectionView reloadData];
}


#pragma mark -懒加载
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
        
        [_iCollectionView registerClass:[ZStudentStarNewListCollectionViewCell class] forCellWithReuseIdentifier:[ZStudentStarNewListCollectionViewCell className]];
    }
    
    return _iCollectionView;
}


#pragma mark collectionview delegate
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
    ZStudentStarNewListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZStudentStarNewListCollectionViewCell className] forIndexPath:indexPath];
    ZStudentDetailLessonOrderCoachModel *model = _list[indexPath.row];
    cell.model = model;
    cell.detailBlock = ^(UIImageView *imgView) {
        ZStudentStarStudentInfoVC *ivc = [[ZStudentStarStudentInfoVC alloc] init];
        [self.navigationController wxs_pushViewController:ivc makeTransition:^(WXSTransitionProperty *transition) {
        transition.animationType = WXSTransitionAnimationTypeViewMoveToNextVC;
        transition.animationTime = 1;
        transition.startView  = imgView;
        transition.targetView = ivc.headerView.userHeaderImageView;
        }];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZStudentStarStudentInfoVC *ivc = [[ZStudentStarStudentInfoVC alloc] init];
    [self.navigationController pushViewController:ivc animated:YES];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(30), CGFloatIn750(20), CGFloatIn750(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [ZStudentStarNewListCollectionViewCell zz_getCollectionCellSize];
}

@end
