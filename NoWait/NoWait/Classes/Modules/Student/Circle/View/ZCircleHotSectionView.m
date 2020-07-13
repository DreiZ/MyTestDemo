//
//  ZCircleHotSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleHotSectionView.h"
#import "ZCircleHotLessonListItemCell.h"
#import "ZCircleMineModel.h"

@interface ZCircleHotSectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIView *funBackView;

@property (nonatomic,strong) UILabel *bottomTipLabel;
@property (nonatomic,strong) UIView *bottomFunBackView;

@property (nonatomic,strong) UIView *headerBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ZCircleHotSectionView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    _dataSource = @[].mutableCopy;
    
    [self addSubview:self.headerBackView];
    [self.headerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(86));
    }];
    
    [self.headerBackView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerBackView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.headerBackView.mas_centerY);
    }];
    
    [self addSubview:self.bottomFunBackView];
    [self.bottomFunBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(86));
    }];
    
    [self.bottomFunBackView addSubview:self.bottomTipLabel];
    [self.bottomTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomFunBackView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.bottomFunBackView.mas_centerY);
    }];
    
    [self addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.top.equalTo(self.headerBackView.mas_bottom);
        make.bottom.equalTo(self.bottomFunBackView.mas_top);
    }];
    
    [self addSubview:self.iCollectionView];
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
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _funBackView;
}

- (UIView *)headerBackView {
    if (!_headerBackView) {
        _headerBackView = [[UIView alloc] init];
        _headerBackView.layer.masksToBounds = YES;
        _headerBackView.clipsToBounds = YES;
        _headerBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _headerBackView;
}


- (UIView *)bottomFunBackView {
    if (!_bottomFunBackView) {
        _bottomFunBackView = [[UIView alloc] init];
        _bottomFunBackView.layer.masksToBounds = YES;
        _bottomFunBackView.clipsToBounds = YES;
        _bottomFunBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _bottomFunBackView;
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

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont boldFontContent];
        _tipLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _tipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipLabel;
}


- (UILabel *)bottomTipLabel{
    if (!_bottomTipLabel) {
        _bottomTipLabel = [UILabel new];
        _bottomTipLabel.font = [UIFont boldFontContent];
        _bottomTipLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _bottomTipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _bottomTipLabel;
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
    cell.model = _dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuBlock) {
        self.menuBlock(_dataSource[indexPath.row]);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(0), CGFloatIn750(30), CGFloatIn750(20), CGFloatIn750(30));
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
    return CGSizeMake(KScreenWidth, [ZCircleHotLessonListItemCell z_getCellSize:nil].height + CGFloatIn750(20) + CGFloatIn750(86) * 2);
}

- (void)setList:(NSMutableArray *)list {
    _dataSource = list;
    
    [self.iCollectionView reloadData];
}


- (void)setTip:(NSString *)tip{
    self.tipLabel.text = tip;
    self.bottomTipLabel.text = @"热门发现";
}

@end
