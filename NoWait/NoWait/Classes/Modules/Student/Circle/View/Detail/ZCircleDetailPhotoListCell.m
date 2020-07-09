//
//  ZCircleDetailPhotoListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailPhotoListCell.h"
#import "ZCirclePhotosItemCell.h"

@interface ZCircleDetailPhotoListCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZCircleDetailPhotoListCell

- (void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    self.cellConfigArr = @[].mutableCopy;
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-0));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-0));
    }];
    
    [self.funBackView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.funBackView);
    }];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    for (int i = 0; i < self.imageList.count; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCirclePhotosItemCell className] title:[ZCirclePhotosItemCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[self getItemSize:self.imageList.count] cellType:ZCellTypeClass dataModel:self.imageList[i]];
        
        [self.cellConfigArr addObject:cellConfig];
    }
}

#pragma mark -Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        ViewRadius(_funBackView, CGFloatIn750(16));
        ViewShadowRadius(_funBackView, CGFloatIn750(10), CGSizeMake(2, 2), 0.5, [UIColor colorGrayBG]);
    }
    return _funBackView;
}

- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(CGFloatIn750(222), CGFloatIn750(148));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _iCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_iCollectionView setShowsVerticalScrollIndicator:NO];
        [_iCollectionView setShowsHorizontalScrollIndicator:NO];
        _iCollectionView.clipsToBounds = YES;
        _iCollectionView.scrollEnabled = NO;
        [_iCollectionView registerClass:[ZCirclePhotosItemCell class] forCellWithReuseIdentifier:[ZCirclePhotosItemCell className]];
        [_iCollectionView setBackgroundColor:adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark])];
        _iCollectionView.delegate = self;
        _iCollectionView.dataSource = self;
    }
    
    return _iCollectionView;
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
    __weak typeof(self) weakSelf = self;
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCollectionViewCell *cell;
    cell = (ZBaseCollectionViewCell*)[cellConfig cellOfCellConfigWithCollection:collectionView indexPath:indexPath dataModel:cellConfig.dataModel];
    if ([cellConfig.title isEqualToString:@"ZCirclePhotosItemCell"]) {
        ZCirclePhotosItemCell *lcell = (ZCirclePhotosItemCell *)cell;
        lcell.isEdit = NO;
        lcell.seeBlock = ^{
            if (weakSelf.seeBlock) {
                weakSelf.seeBlock(indexPath.row);
            }
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(20), CGFloatIn750(20), CGFloatIn750(20));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGSize cellSize =  cellConfig.sizeOfCell;
    return cellSize;
}

#pragma mark 类型
- (void)setImageList:(NSMutableArray<ZFileUploadDataModel *> *)imageList {
    _imageList = imageList;
    
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
}

- (CGSize)getItemSize:(NSInteger)imagesCount {
    if (imagesCount == 0) {
        return CGSizeMake(0, 0);
    }else if(imagesCount == 1){
        return CGSizeMake(KScreenWidth - CGFloatIn750(60) - CGFloatIn750(20) - 0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40)) * (195.0/325.0));
    }else if(imagesCount == 2 || imagesCount == 4){
        return CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8))/2 - 0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8))/2);
    }else if(imagesCount == 3){
        return CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8)*2)/3.0f - 0.5, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8)*2)/3.0f);
    }else {
        CGFloat height = (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8)*2)/3.0f;
        
        return CGSizeMake(height-0.5, height);
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    if (list.count == 0) {
        return 0;
    }else if(list.count == 1){
        return (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40)) * (195.0/325.0) + CGFloatIn750(40);
    }else if(list.count == 2){
        return (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8))/2 + CGFloatIn750(40);
    }else if(list.count == 3){
        return (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8*2))/3 + CGFloatIn750(40);
    }else if(list.count == 4){
        return (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8))/2 * 2 + CGFloatIn750(8) + CGFloatIn750(40);
    }else {
        CGFloat height = (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(40) - CGFloatIn750(8*2))/3;
        
        if (list.count%3 > 0) {
            return (list.count/3 + 1) * height + ((list.count/3) * CGFloatIn750(8))+ CGFloatIn750(40);
        }
        return list.count/3  * height + (list.count/3 - 1)  * CGFloatIn750(8) + CGFloatIn750(40);
    }
    return 0;
}
@end

