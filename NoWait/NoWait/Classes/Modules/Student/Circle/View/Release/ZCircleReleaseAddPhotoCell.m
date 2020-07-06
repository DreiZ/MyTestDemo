//
//  ZCircleReleaseAddPhotoCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseAddPhotoCell.h"
#import "ZCircleAddPhotosItemCell.h"
#import "ZCirclePhotosItemCell.h"

@interface ZCircleReleaseAddPhotoCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZCircleReleaseAddPhotoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

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
    
    ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleAddPhotosItemCell className] title:[ZCircleAddPhotosItemCell className] showInfoMethod:nil sizeOfCell:[ZCircleAddPhotosItemCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:nil];
    
    [self.cellConfigArr addObject:cellConfig];
    
    for (int i = 0; i < self.imageList.count; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZCirclePhotosItemCell className] title:[ZCirclePhotosItemCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZCirclePhotosItemCell z_getCellSize:nil] cellType:ZCellTypeClass dataModel:self.imageList[i]];
        
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
        [_iCollectionView registerClass:[ZCircleAddPhotosItemCell class] forCellWithReuseIdentifier:[ZCircleAddPhotosItemCell className]];
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
        lcell.delBlock = ^{
            if (weakSelf.menuBlock) {
                weakSelf.menuBlock(indexPath.row,NO);
            }
        };
        lcell.seeBlock = ^{
            if (weakSelf.seeBlock) {
                weakSelf.seeBlock(indexPath.row);
            }
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if ([cellConfig.title isEqualToString:@"ZCircleAddPhotosItemCell"]) {
        if (self.addBlock) {
            self.addBlock();
        }
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(44), CGFloatIn750(20), CGFloatIn750(44));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(10);
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

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(214) + CGFloatIn750(40);
}
@end
