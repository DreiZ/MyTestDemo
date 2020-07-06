//
//  ZCircleHotLessonListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleHotLessonListCell.h"
#import "ZCircleHotLessonListItemCell.h"

@interface ZCircleHotLessonListCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ZCircleHotLessonListCell

- (void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor =  adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    _dataSource = @[].mutableCopy;
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.funBackView);
    }];
}

#pragma mark -Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    }
    return _funBackView;
}


- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(100)) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_iCollectionView registerClass:[ZCircleHotLessonListItemCell class] forCellWithReuseIdentifier:[ZCircleHotLessonListItemCell className]];
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
    return _dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCircleHotLessonListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZCircleHotLessonListItemCell className] forIndexPath:indexPath];
//    ZStudentPhotoWallItemModel *model = _channelList[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:model.imageName];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.menuBlock) {
//        self.menuBlock(_channelList[indexPath.row]);
//    }
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
    return [ZCircleHotLessonListItemCell z_getCellSize:nil];
}

#pragma mark 类型

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(KScreenWidth, [ZCircleHotLessonListItemCell z_getCellSize:nil].height + CGFloatIn750(40));
}

- (void)setList:(NSMutableArray *)list {
    _dataSource = list;
    
    [self.iCollectionView reloadData];
}
@end



