//
//  ZOriganizationClubSelectedCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationClubSelectedCell.h"
#import "ZOriganizationClubSelectedItemCell.h"

@interface ZOriganizationClubSelectedCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;

@end

@implementation ZOriganizationClubSelectedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(24));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-0));
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
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        ViewRadius(_funBackView, CGFloatIn750(16));
        ViewShadowRadius(_funBackView, CGFloatIn750(24), CGSizeMake(2, 2), 0.5, [UIColor colorGrayBG]);
    }
    return _funBackView;
}


- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(KScreenWidth/4.0f, CGFloatIn750(72));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _iCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_iCollectionView setShowsVerticalScrollIndicator:NO];
        [_iCollectionView setShowsHorizontalScrollIndicator:NO];
        
//        [_iCollectionView setBounces:NO];
        _iCollectionView.clipsToBounds = YES;
        [_iCollectionView registerClass:[ZOriganizationClubSelectedItemCell class] forCellWithReuseIdentifier:[ZOriganizationClubSelectedItemCell className]];
        [_iCollectionView setBackgroundColor:adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark])];
        _iCollectionView.delegate = self;
        _iCollectionView.dataSource = self;
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
    return _channelList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZOriganizationClubSelectedItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZOriganizationClubSelectedItemCell className] forIndexPath:indexPath];
    cell.model = _channelList[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuBlock) {
        self.menuBlock(_channelList[indexPath.row]);
    }
    [self selectedWithIndexPath:indexPath];
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(0), CGFloatIn750(0), CGFloatIn750(0), CGFloatIn750(0));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ( _channelList.count > 0) {
        ZBaseUnitModel *model = _channelList[indexPath.row];
        CGSize cellSize = [model.name tt_sizeWithFont:[UIFont fontContent]];
        return CGSizeMake(cellSize.width + CGFloatIn750(34), CGFloatIn750(72));
    }
    return CGSizeMake(KScreenWidth/4.0f, CGFloatIn750(72));
}

#pragma mark 类型
-(void)setChannelList:(NSArray <ZBaseUnitModel *>*)channelList {
    _channelList = channelList;
    [self.iCollectionView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(98);
}

- (void)selectedWithIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i < _channelList.count; i++) {
        ZBaseUnitModel *model = _channelList[i];
        if (i == indexPath.row) {
            model.isSelected = YES;
        }else{
            model.isSelected = NO;
        }
    }
    [_iCollectionView reloadData];
    
    CGFloat leftX = [self getSelectedLeftXWithIndexPath:indexPath];
    CGFloat rightX = [self getSelectedRightXWithIndexPath:indexPath];
    if (rightX - _iCollectionView.width - _iCollectionView.contentOffset.x > 0) {
        [_iCollectionView setOffsetX:rightX - _iCollectionView.width + CGFloatIn750(70) animated:YES];
    }else if (leftX - _iCollectionView.contentOffset.x < CGFloatIn750(70)) {
        if (_iCollectionView.contentOffset.x - leftX - CGFloatIn750(70) > 0) {
            [_iCollectionView setOffsetX:_iCollectionView.contentOffset.x - leftX - CGFloatIn750(70) animated:YES];
        }else{
            [_iCollectionView setOffsetX:_iCollectionView.contentOffset.x - leftX  animated:YES];
        }
    }
}

- (CGFloat)getSelectedLeftXWithIndexPath:(NSIndexPath *)indexPath {
    CGFloat leftX = 0;
    for (int i = 0; i < indexPath.row; i++) {
        ZBaseUnitModel *model = _channelList[i];
        CGSize cellSize = [model.name tt_sizeWithFont:[UIFont fontContent]];
        leftX += cellSize.width + CGFloatIn750(34);
    }
    
    return leftX;
}

- (CGFloat)getSelectedRightXWithIndexPath:(NSIndexPath *)indexPath {
    CGFloat rightX = [self getSelectedLeftXWithIndexPath:indexPath];
    ZBaseUnitModel *model = _channelList[indexPath.row];
    CGSize cellSize = [model.name tt_sizeWithFont:[UIFont fontContent]];
    rightX += cellSize.width + CGFloatIn750(34);
    
    return rightX;
}
@end

