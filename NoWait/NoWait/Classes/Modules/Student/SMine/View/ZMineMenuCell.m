//
//  ZMineMenuCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineMenuCell.h"
#import "ZMineMenuItemCell.h"

@interface ZMineMenuCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;

@end

@implementation ZMineMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-20));
    }];
    ViewShadowRadius(self.funBackView, CGFloatIn750(20), CGSizeMake(CGFloatIn750(0), CGFloatIn750(0)), 1, [UIColor colorGrayBG]);
    
    [self.contentView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.funBackView);
    }];
}


#pragma mark -Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
//        _funBackView.layer.masksToBounds = YES;
//        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _funBackView;
}


- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake((KScreenWidth - CGFloatIn750(60))/4.0f, CGFloatIn750(174));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _iCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_iCollectionView setShowsVerticalScrollIndicator:NO];
        [_iCollectionView setShowsHorizontalScrollIndicator:NO];
        
//        [_iCollectionView setBounces:NO];
//        _iCollectionView.clipsToBounds = YES;
        [_iCollectionView registerClass:[ZMineMenuItemCell class] forCellWithReuseIdentifier:[ZMineMenuItemCell className]];
        [_iCollectionView setBackgroundColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark])];
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
    return _topChannelList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZMineMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMineMenuItemCell className] forIndexPath:indexPath];
    ZStudentMenuItemModel *model = _topChannelList[indexPath.row];
    cell.titleLabel.text = model.name;
    cell.imageView.image = [[UIImage imageNamed:model.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.imageView.tintColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuBlock) {
        self.menuBlock(_topChannelList[indexPath.row]);
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_topChannelList.count < 5 && _topChannelList.count > 0) {
        return CGSizeMake((KScreenWidth - CGFloatIn750(60))/_topChannelList.count, CGFloatIn750(174));
    }
    return CGSizeMake((KScreenWidth - CGFloatIn750(60))/4.0f, CGFloatIn750(174));
}

#pragma mark 类型
-(void)setTopChannelList:(NSArray<ZStudentMenuItemModel *> *)topChannelList {
    _topChannelList = topChannelList;
    [self.iCollectionView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(216);
}

@end
