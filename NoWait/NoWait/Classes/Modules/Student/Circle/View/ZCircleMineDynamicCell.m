//
//  ZCircleMineDynamicCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineDynamicCell.h"
#import "ZCircleMineDynamicCollectionCell.h"

@interface ZCircleMineDynamicCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UIView *timeBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) UILabel *mouthLabel;
@property (nonatomic,strong) UILabel *dayLabel;
@property (nonatomic,strong) UILabel *yearLabel;
@end

@implementation ZCircleMineDynamicCell

- (void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    _dataSource = @[].mutableCopy;
    
    [self.contentView addSubview:self.timeBackView];
    [self.timeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(CGFloatIn750(140));
    }];
    
    [self.timeBackView addSubview:self.mouthLabel];
    [self.timeBackView addSubview:self.dayLabel];
    [self.timeBackView addSubview:self.yearLabel];
    
    [self.mouthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeBackView.mas_top).offset(CGFloatIn750(50));
        make.right.equalTo(self.timeBackView.mas_centerX);
    }];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mouthLabel.mas_bottom);
        make.left.equalTo(self.timeBackView.mas_centerX);
    }];
    
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mouthLabel.mas_bottom).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.timeBackView.mas_centerX);
    }];
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.timeBackView.mas_right);
    }];
    
    [self.contentView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.funBackView);
    }];
    
    _mouthLabel.text = @"03";
    _dayLabel.text = @"/08";
    _yearLabel.text = @"2013";
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

- (UIView *)timeBackView {
    if (!_timeBackView) {
        _timeBackView = [[UIView alloc] init];
        _timeBackView.layer.masksToBounds = YES;
        _timeBackView.clipsToBounds = YES;
        _timeBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    }
    return _timeBackView;
}

- (UILabel *)mouthLabel {
    if (!_mouthLabel) {
        _mouthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _mouthLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _mouthLabel.numberOfLines = 1;
        _mouthLabel.textAlignment = NSTextAlignmentLeft;
        [_mouthLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _mouthLabel;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dayLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _dayLabel.numberOfLines = 1;
        _dayLabel.textAlignment = NSTextAlignmentLeft;
        [_dayLabel setFont:[UIFont boldFontSmall]];

    }
    return _dayLabel;
}

- (UILabel *)yearLabel {
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _yearLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _yearLabel.numberOfLines = 1;
        _yearLabel.textAlignment = NSTextAlignmentLeft;
        [_yearLabel setFont:[UIFont boldFontSmall]];
    }
    return _yearLabel;
}

- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, [ZCircleMineDynamicCell z_getCellHeight:nil]) collectionViewLayout:flowLayout];
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
    return UIEdgeInsetsMake(CGFloatIn750(50), CGFloatIn750(8), CGFloatIn750(10), CGFloatIn750(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(4);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [ZCircleMineDynamicCollectionCell z_getCellSize:nil];
}

#pragma mark 类型

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    if (list.count%2 > 0) {
        return (list.count/2 + 1) * [ZCircleMineDynamicCollectionCell z_getCellSize:nil].height + ((list.count/2) * CGFloatIn750(4))+ CGFloatIn750(60);
    }
    return list.count/2  * [ZCircleMineDynamicCollectionCell z_getCellSize:nil].height + (list.count/2 - 1)  * CGFloatIn750(4) + CGFloatIn750(60);
}

- (void)setList:(NSMutableArray *)list {
    _dataSource = list;
    
    [self.iCollectionView reloadData];
}
@end


