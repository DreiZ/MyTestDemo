//
//  ZStudentMainEnteryCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainEnteryCell.h"
#import "ZStudentMainEntryItemCell.h"

@interface ZStudentMainEnteryCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;

@end

@implementation ZStudentMainEnteryCell

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
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-10));
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
        _funBackView.backgroundColor = [UIColor whiteColor];
    }
    return _funBackView;
}


- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(KScreenWidth/4.0f, CGFloatIn750(128));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _iCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_iCollectionView setShowsVerticalScrollIndicator:NO];
        [_iCollectionView setShowsHorizontalScrollIndicator:NO];
        
//        [_iCollectionView setBounces:NO];
        _iCollectionView.clipsToBounds = YES;
        [_iCollectionView registerClass:[ZStudentMainEntryItemCell class] forCellWithReuseIdentifier:[ZStudentMainEntryItemCell className]];
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
    ZStudentMainEntryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZStudentMainEntryItemCell className] forIndexPath:indexPath];
    ZStudentEnteryItemModel *model = _channelList[indexPath.row];
    cell.titleLabel.text = model.name;
    cell.imageView.image = [[UIImage imageNamed:model.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.imageView.tintColor = [UIColor  colorMain];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuBlock) {
        self.menuBlock(_channelList[indexPath.row]);
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_channelList.count < 5 && _channelList.count > 0) {
        return CGSizeMake(KScreenWidth/_channelList.count, CGFloatIn750(128));
    }
    return CGSizeMake(KScreenWidth/4.0f, CGFloatIn750(128));
}

#pragma mark 类型
-(void)setChannelList:(NSArray<ZStudentEnteryItemModel *> *)channelList {
    _channelList = channelList;
    [self.iCollectionView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(150);
}
@end
