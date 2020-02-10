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
    self.view.backgroundColor = KAdaptAndDarkColor(KBackColor, K2eBackColor);
    
    [self.view addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
}

- (void)setData {
    _list = @[].mutableCopy;
    for (int i = 0; i < 10; i++) {
        ZStudentDetailLessonOrderCoachModel *model = [[ZStudentDetailLessonOrderCoachModel alloc] init];
        model.coachName = @"张思思";
        model.coachImage = [NSString stringWithFormat:@"studentListItem%d",i%4+1];
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
        _iCollectionView.backgroundColor = KAdaptAndDarkColor(KBackColor, K2eBackColor);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        _iCollectionView.showsVerticalScrollIndicator = NO;
        
        [_iCollectionView registerClass:[ZStudentStarListCollectionViewCell class] forCellWithReuseIdentifier:[ZStudentStarListCollectionViewCell className]];
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
    ZStudentStarListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZStudentStarListCollectionViewCell className] forIndexPath:indexPath];
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
    return UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(20), CGFloatIn750(20), CGFloatIn750(20));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth-CGFloatIn750(60))/2, CGFloatIn750(370));
}

@end
