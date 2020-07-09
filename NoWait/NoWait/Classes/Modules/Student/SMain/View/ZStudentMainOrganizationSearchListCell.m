//
//  ZStudentMainOrganizationSearchListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainOrganizationSearchListCell.h"
#import "ZStudentMainOrganizationSearchListItemCell.h"

@interface ZStudentMainOrganizationSearchListCell ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZStudentMainOrganizationSearchListCell

-(void)setupView {
    [super setupView];
    _cellConfigArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo([ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height);
    }];
    
    [self.funBackView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.funBackView);
    }];
}

#pragma mark - Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorBlackBGDark]);
    }
    return _funBackView;
}

- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(270)) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_iCollectionView registerClass:[ZStudentMainOrganizationSearchListItemCell class] forCellWithReuseIdentifier:[ZStudentMainOrganizationSearchListItemCell className]];
    }
    return _iCollectionView;
}

#pragma mark - setModel
- (void)setModel:(ZStoresListModel *)model {
    [super setModel:model];
    [_cellConfigArr removeAllObjects];

    if (ValidArray(model.course)) {
        for (int i = 0; i < model.course.count; i++) {
            ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationSearchListItemCell className] title:[ZStudentMainOrganizationSearchListItemCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZStudentMainOrganizationSearchListItemCell z_getCellSize:model.course[i]] cellType:ZCellTypeClass dataModel:model.course[i]];
            
            [self.cellConfigArr addObject:cellConfig];
        }
        self.funBackView.hidden = NO;
    }else{
        self.funBackView.hidden = YES;
    }
    
    
    [self.iCollectionView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    CGFloat cellHeight = [super z_getCellHeight:sender];
    ZStoresListModel *model = sender;
    if (model) {
        return cellHeight + (ValidArray(model.course)? [ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height:0);
    }else{
        return cellHeight;
    }
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
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCollectionViewCell *cell;
    cell = (ZBaseCollectionViewCell*)[cellConfig cellOfCellConfigWithCollection:collectionView indexPath:indexPath dataModel:cellConfig.dataModel];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if (self.lessonBlock) {
        self.lessonBlock(cellConfig.dataModel);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, CGFloatIn750(30), 0, CGFloatIn750(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGSize cellSize =  cellConfig.sizeOfCell;
    return cellSize;
}
@end
