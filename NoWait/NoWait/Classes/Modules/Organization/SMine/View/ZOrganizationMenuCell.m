//
//  ZOrganizationMenuCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationMenuCell.h"
#import "ZOrganizationMenuItemCell.h"

@interface ZOrganizationMenuCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSArray <ZBaseUnitModel*>*channelList;
@end

@implementation ZOrganizationMenuCell

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
    
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(CGFloatIn750(-20));
    }];
    
    UIView *topView = [[UIView alloc] init];
    [self.funBackView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.funBackView);
        make.height.mas_equalTo(CGFloatIn750(76));
    }];
    
    [topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(topView.mas_bottom);
    }];
    
    [self.funBackView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.funBackView);
        make.top.equalTo(topView.mas_bottom);
    }];
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _titleLabel.text = @"财务管理";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldFontMaxTitle]];
    }
    return _titleLabel;
}



- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(KScreenWidth/4.0f, CGFloatIn750(110));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _iCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_iCollectionView setShowsVerticalScrollIndicator:NO];
        [_iCollectionView setShowsHorizontalScrollIndicator:NO];
        _iCollectionView.scrollEnabled = NO;
        [_iCollectionView setBounces:NO];
        _iCollectionView.clipsToBounds = YES;
        [_iCollectionView registerClass:[ZOrganizationMenuItemCell class] forCellWithReuseIdentifier:[ZOrganizationMenuItemCell className]];
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
    ZOrganizationMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZOrganizationMenuItemCell className] forIndexPath:indexPath];
    ZBaseUnitModel *model = _channelList[indexPath.row];
    cell.titleLabel.text = model.name;
    if (model.istransformDark) {
        cell.imageView.image = [[UIImage imageNamed:model.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        cell.imageView.tintColor = adaptAndDarkColor([UIColor colorWithHexString:@"333c4f"], [UIColor colorWhite]);
    }else{
        cell.imageView.image = [UIImage imageNamed:model.imageName];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuBlock) {
        self.menuBlock(_channelList[indexPath.row]);
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(36), CGFloatIn750(0), CGFloatIn750(40), CGFloatIn750(0));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(56);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_channelList.count < 5 && _channelList.count > 0) {
        return CGSizeMake((KScreenWidth - CGFloatIn750(60))/4 - 1, CGFloatIn750(104));
    }
    return CGSizeMake((KScreenWidth - CGFloatIn750(60))/4.0f -1, CGFloatIn750(104));
}


#pragma mark 类型
- (void)setModel:(ZBaseMenuModel *)model {
    self.channelList = model.units;
    self.titleLabel.text = model.name;
}

-(void)setChannelList:(NSArray <ZBaseUnitModel *>*)channelList {
    _channelList = channelList;
    [self.iCollectionView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    if (list.count%4 > 0) {
        return (list.count/4 + 1) * CGFloatIn750(104) + ((list.count/4) * CGFloatIn750(56))+ CGFloatIn750(70)+ CGFloatIn750(75) + CGFloatIn750(20);
    }
    return list.count/4  * CGFloatIn750(104) + (list.count/4 - 1)  * CGFloatIn750(56) + CGFloatIn750(70)+ CGFloatIn750(75) + CGFloatIn750(20);
}
@end


