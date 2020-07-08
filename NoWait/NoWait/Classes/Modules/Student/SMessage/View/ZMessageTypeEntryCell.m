//
//  ZMessageTypeEntryCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessageTypeEntryCell.h"
#import "ZMessageTypeEntryItemCell.h"

@interface ZMessageTypeEntryCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZMessageTypeEntryCell

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
        make.edges.equalTo(self.contentView);
    }];
    
    [self.funBackView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.funBackView);
    }];
}

- (void)initCellConfigArr {
    [self.cellConfigArr removeAllObjects];
    
    for (int i = 0; i < self.itemArr.count; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageTypeEntryItemCell className] title:[ZMessageTypeEntryItemCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[self getItemSize:self.itemArr.count] cellType:ZCellTypeClass dataModel:self.itemArr[i]];
        
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
    }
    return _funBackView;
}

- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_iCollectionView setShowsVerticalScrollIndicator:NO];
        [_iCollectionView setShowsHorizontalScrollIndicator:NO];
        _iCollectionView.clipsToBounds = YES;
        _iCollectionView.scrollEnabled = NO;
        [_iCollectionView registerClass:[ZMessageTypeEntryItemCell class] forCellWithReuseIdentifier:[ZMessageTypeEntryItemCell className]];
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
    if ([cellConfig.title isEqualToString:@"ZMessageTypeEntryItemCell"]) {
        ZMessageTypeEntryItemCell *lcell = (ZMessageTypeEntryItemCell *)cell;
        ZMessageTypeEntryModel *model = cellConfig.dataModel;
        lcell.handleBlock = ^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(model.entry_id);
            }
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(0), CGFloatIn750(20), CGFloatIn750(0), CGFloatIn750(20));
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
- (void)setItemArr:(NSArray *)itemArr {
    _itemArr = itemArr;
    
    [self initCellConfigArr];
    [self.iCollectionView reloadData];
}

- (CGSize)getItemSize:(NSInteger)imagesCount {
    if (imagesCount == 0) {
        return CGSizeMake(0, 0);
    }else if(imagesCount == 1){
        return CGSizeMake(KScreenWidth - CGFloatIn750(40) - 0.5, [ZMessageTypeEntryCell z_getCellHeight:nil]);
    }else if(imagesCount <= 4){
        return CGSizeMake((KScreenWidth - CGFloatIn750(40) - (imagesCount - 1)*CGFloatIn750(8))/imagesCount - 0.5, [ZMessageTypeEntryCell z_getCellHeight:nil]);
    }else {
        return CGSizeMake((KScreenWidth - CGFloatIn750(40) - (imagesCount - 1)*CGFloatIn750(8))/4.5, [ZMessageTypeEntryCell z_getCellHeight:nil]);
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(186);
}
@end


