//
//  ZCircleMineDynamicCollectionTableViewCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineDynamicCollectionTableViewCell.h"
#import "ZCircleMineDynamicCollectionCell.h"

@interface ZCircleMineDynamicCollectionTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ZCircleMineDynamicCollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    _dataSource = @[].mutableCopy;
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
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
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    }
    return _funBackView;
}

- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, [ZCircleMineDynamicCollectionTableViewCell z_getCellHeight:nil]) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = NO;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_iCollectionView registerClass:[ZCircleMineDynamicCollectionCell class] forCellWithReuseIdentifier:[ZCircleMineDynamicCollectionCell className]];
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
    ZCircleMineDynamicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZCircleMineDynamicCollectionCell className] forIndexPath:indexPath];
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
    return UIEdgeInsetsMake(CGFloatIn750(0), CGFloatIn750(30), CGFloatIn750(0), CGFloatIn750(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(4);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3, (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3 *(160.0f)/(142.0));
}

#pragma mark 类型

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    CGFloat height = (KScreenWidth - CGFloatIn750(60) - CGFloatIn750(10))/3 *(160.0f)/(142.0);
    if (list.count%3 > 0) {
        return (list.count/3 + 1) * height + ((list.count/3) * CGFloatIn750(4));
    }
    return list.count/3  * height + (list.count/3 - 1)  * CGFloatIn750(4);
}

- (void)setList:(NSMutableArray *)list {
    _dataSource = list;
    
    [self.iCollectionView reloadData];
}
@end



