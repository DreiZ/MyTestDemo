//
//  ZStudentMineLessonTimetableCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineLessonTimetableCell.h"
#import "ZStudentMineLessonTimetableCollectionCell.h"

@interface ZStudentMineLessonTimetableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) NSArray *dataSources;
@property (nonatomic,strong) UILabel *lessonTitleLabel;
@property (nonatomic,strong) UILabel *timeTitleLabel;

@property (nonatomic,strong) UIView *bottomView;

@end

@implementation ZStudentMineLessonTimetableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [super setupView];
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectZero];
    contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    contView.layer.cornerRadius = CGFloatIn750(16);
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-CGFloatIn750(20));
    }];
    ViewShadowRadius(contView, CGFloatIn750(20), CGSizeMake(CGFloatIn750(0), CGFloatIn750(0)), 1, [UIColor colorGrayBG]);
    
    UIView *topTitleBackView = [[UIView alloc] initWithFrame:CGRectZero];
    topTitleBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [contView addSubview:topTitleBackView];
    [topTitleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(122));
        make.right.equalTo(contView);
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(contView.mas_top).offset(CGFloatIn750(14));
    }];
    
    [topTitleBackView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topTitleBackView.mas_centerY).offset(-CGFloatIn750(20));
        make.centerX.equalTo(topTitleBackView.mas_centerX);
    }];
    
    [topTitleBackView addSubview:self.timeTitleLabel];
    [self.timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.lessonTitleLabel.mas_centerX);
        make.top.equalTo(self.lessonTitleLabel.mas_bottom).offset(CGFloatIn750(8));
    }];
    
    
    [contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(contView);
        make.height.mas_equalTo(CGFloatIn750(108));
    }];
    
    [contView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topTitleBackView.mas_bottom).offset(CGFloatIn750(0));
        make.left.equalTo(contView.mas_left);
        make.right.equalTo(contView.mas_right);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
}


#pragma mark - 懒加载
- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        _iCollectionView.showsVerticalScrollIndicator = NO;
        _iCollectionView.scrollEnabled = NO;
//        [_iCollectionView registerClass:[ZStudentOrganizationLessonListCollectionCell class] forCellWithReuseIdentifier:[ZStudentOrganizationLessonListCollectionCell className]];
    }
    
    return _iCollectionView;
}

- (NSArray *)dataSources {
    if (!_dataSources) {
        _dataSources = @[];
    }
    return _dataSources;
}

#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ZStudentOrganizationLessonListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZStudentOrganizationLessonListCollectionCell className] forIndexPath:indexPath];
    ZStudentMineLessonTimetableCollectionCell *cell = [ZStudentMineLessonTimetableCollectionCell z_cellWithCollection:collectionView indexPath:indexPath];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    ZStudentLessonDetailVC *dvc = [[ZStudentLessonDetailVC alloc] init];
//    dvc.model = self.dataSources[indexPath.row];
//    [self.navigationController pushViewController:dvc animated:YES];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(64), CGFloatIn750(20), CGFloatIn750(64));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [ZStudentMineLessonTimetableCollectionCell z_getCellSize:nil];
}


#pragma mark - lazy loading
- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _lessonTitleLabel.text = @"今日课程";
        _lessonTitleLabel.numberOfLines = 0;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont boldFontContent]];
    }
    return _lessonTitleLabel;
}

- (UILabel *)timeTitleLabel {
    if (!_timeTitleLabel) {
        
        _timeTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _timeTitleLabel.text = [[NSString stringWithFormat:@"%f",[[NSDate new] timeIntervalSince1970]] timeStringWithFormatter:@"MM/dd"];
        _timeTitleLabel.numberOfLines = 0;
        _timeTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_timeTitleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
    }
    return _timeTitleLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [moreBtn setTitle:@"查看本周课程  >" forState:UIControlStateNormal];
        [moreBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [moreBtn.titleLabel setFont:[UIFont fontSmall]];
        [moreBtn bk_whenTapped:^{
            if (self.moreBlock) {
                self.moreBlock(0);
            }
        }];
        [_bottomView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bottomView);
        }];
        
        UIView *spaceLineView = [[UIView alloc] initWithFrame:CGRectZero];
        spaceLineView.backgroundColor = [UIColor colorGrayLine];
        [_bottomView addSubview:spaceLineView];
        [spaceLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomView.mas_top);
            make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(30));
            make.right.equalTo(self.bottomView.mas_right).offset(-CGFloatIn750(30));
            make.height.mas_equalTo(0.5);
        }];
    }
    return _bottomView;
}
+ (CGFloat)z_getCellHeight:(id)sender {
    NSArray *list = sender;
    if (list.count%4 > 0) {
        return (list.count/4 + 1) * ((KScreenWidth-CGFloatIn750(252))/4 * (64.0/62.0)) + ((list.count/4) * CGFloatIn750(20))+ CGFloatIn750(73 * 2 + 60*2) + CGFloatIn750(40);
    }
    return list.count/4  * ((KScreenWidth-CGFloatIn750(252))/4 * (64.0/62.0)) + (list.count/4 - 1)  * CGFloatIn750(20) + CGFloatIn750(73 * 2 + 60*2) + CGFloatIn750(40);
}


- (void)setList:(NSArray<ZOriganizationLessonListModel *> *)list {
    _dataSources = list;
    [_iCollectionView reloadData];
}
@end

