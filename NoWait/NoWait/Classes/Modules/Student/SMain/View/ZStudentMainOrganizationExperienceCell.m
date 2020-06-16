//
//  ZStudentMainOrganizationExperienceCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainOrganizationExperienceCell.h"
#import "ZStudentMainOrganizationExperienceItemCell.h"

@interface ZStudentMainOrganizationExperienceCell ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;
@end

@implementation ZStudentMainOrganizationExperienceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    _cellConfigArr = @[].mutableCopy;
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.funBackView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.funBackView);
    }];
}

#pragma mark - Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorBlackBGDark]);
        _funBackView.backgroundColor = [UIColor redColor];
    }
    return _funBackView;
}

- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(230)) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_iCollectionView registerClass:[ZStudentMainOrganizationExperienceItemCell class] forCellWithReuseIdentifier:[ZStudentMainOrganizationExperienceItemCell className]];
    }
    return _iCollectionView;
}

#pragma mark - setModel
- (void)setAppointment_courses:(NSArray<ZOriganizationLessonListModel *> *)appointment_courses{
    _appointment_courses = appointment_courses;
    
    [_cellConfigArr removeAllObjects];

    if (ValidArray(appointment_courses)) {
        for (int i = 0; i < appointment_courses.count; i++) {
            ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationExperienceItemCell className] title:[ZStudentMainOrganizationExperienceItemCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZStudentMainOrganizationExperienceItemCell z_getCellSize:appointment_courses[i]] cellType:ZCellTypeClass dataModel:appointment_courses[i]];
            
            [self.cellConfigArr addObject:cellConfig];
        }
        self.funBackView.hidden = NO;
    }else{
        self.funBackView.hidden = YES;
    }
    
    
    [self.iCollectionView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    CGFloat cellHeight = CGFloatIn750(40);
    if ([sender isKindOfClass:[NSArray class]]) {
        NSArray *listArr = sender;
        if (listArr) {
            return cellHeight + (ValidArray(listArr)? [ZStudentMainOrganizationExperienceItemCell z_getCellSize:nil].height:0);
        }else{
            return cellHeight;
        }
    }
    return cellHeight;
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
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    ZBaseCollectionViewCell *cell;
    cell = (ZBaseCollectionViewCell*)[cellConfig cellOfCellConfigWithCollection:collectionView indexPath:indexPath dataModel:cellConfig.dataModel];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = [_cellConfigArr objectAtIndex:indexPath.row];
    if (self.lessonBlock) {
        self.lessonBlock(cellConfig.dataModel);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, CGFloatIn750(30), 0, CGFloatIn750(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCellConfig *cellConfig = _cellConfigArr[indexPath.row];
    CGSize cellSize =  cellConfig.sizeOfCell;
    return cellSize;
}
@end
