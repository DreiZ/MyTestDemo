//
//  ZStudentOrganizationDetailTopCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailTopCell.h"
#import "ZStudentLessonDetailPeoplesItemCell.h"

@interface ZStudentOrganizationDetailTopCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;

@end

@implementation ZStudentOrganizationDetailTopCell

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
        make.edges.equalTo(self.contentView);
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
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _funBackView;
}


- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, [ZStudentOrganizationDetailTopCell z_getCellHeight:nil]) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_iCollectionView registerClass:[ZStudentLessonDetailPeoplesItemCell class] forCellWithReuseIdentifier:[ZStudentLessonDetailPeoplesItemCell className]];
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
    return _list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZStudentLessonDetailPeoplesItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZStudentLessonDetailPeoplesItemCell className] forIndexPath:indexPath];
    ZBaseUnitModel *model = _list[indexPath.row];
    [cell.userImageView tt_setImageWithURL:[NSURL URLWithString:model.imageName]];
    cell.titleLabel.text = model.name;
    cell.titleLabel.font = [UIFont fontMin];
    cell.titelBack.backgroundColor = adaptAndDarkColor(HexAColor(0x00000, 0.7), HexAColor(0xffffff, 0.7));
    cell.titleLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlack]);
    [cell.titelBack mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(cell.userImageView);
        make.height.mas_equalTo(CGFloatIn750(30));
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectBlock) {
        self.selectBlock(_list[indexPath.row]);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(20), CGFloatIn750(20), CGFloatIn750(20));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGFloatIn750(256), CGFloatIn750(168));
}

#pragma mark 类型
-(void)setList:(NSArray<ZBaseUnitModel *> *)list {
    _list = list;
    [self.iCollectionView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    if (list.count > 0) {
        return CGFloatIn750(210);
    }
    return 0.01;
}
@end


