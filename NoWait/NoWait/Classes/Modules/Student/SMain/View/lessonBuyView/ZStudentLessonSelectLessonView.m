//
//  ZStudentLessonSelectLessonView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectLessonView.h"
#import "ZStudentLessonListItemCell.h"

@interface ZStudentLessonSelectLessonView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) UILabel *lessonTitleLabel;
@property (nonatomic,strong) UIButton *bottomBtn;

@end

@implementation ZStudentLessonSelectLessonView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;

    __weak typeof(self) weakSelf = self;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = KWhiteColor;
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(102));
        make.left.right.top.equalTo(self);
    }];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [closeBtn setImage:[UIImage imageNamed:@"lessonSelectClose"] forState:UIControlStateNormal];
    [closeBtn bk_whenTapped:^{
        if (weakSelf.closeBlock) {
            weakSelf.closeBlock();
        }
    }];
    [topView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(80));
        make.right.equalTo(topView.mas_right).offset(-CGFloatIn750(20));
        make.top.bottom.equalTo(topView);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KLineColor;
    [topView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(0.5);
    }];
    
    [topView addSubview:self.lessonTitleLabel];
    [self.lessonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX).offset(-0);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    UIImageView *lessonImageView = [[UIImageView alloc] init];
    lessonImageView.image = [UIImage imageNamed:@"studentLessonHint"];
    lessonImageView.layer.masksToBounds = YES;
    [topView addSubview:lessonImageView];
    [lessonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lessonTitleLabel.mas_left).offset(-CGFloatIn750(20));
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    [self addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(topView.mas_bottom).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.bottomBtn.mas_top).offset(CGFloatIn750(-0));
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
        _funBackView.backgroundColor = [UIColor whiteColor];
    }
    return _funBackView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"立即预约" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(38)]];
        [_bottomBtn setBackgroundColor:KMainColor forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (weakSelf.bottomBlock) {
                weakSelf.bottomBlock();
            }
        }];
    }
    return _bottomBtn;
}


- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing= 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _iCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_iCollectionView setShowsVerticalScrollIndicator:NO];
        [_iCollectionView setShowsHorizontalScrollIndicator:NO];
        
//        [_iCollectionView setBounces:NO];
        _iCollectionView.clipsToBounds = YES;
        [_iCollectionView registerClass:[ZStudentLessonListItemCell class] forCellWithReuseIdentifier:[ZStudentLessonListItemCell className]];
        [_iCollectionView setBackgroundColor:[UIColor whiteColor]];
        _iCollectionView.delegate = self;
        _iCollectionView.dataSource = self;
    }
    
    return _iCollectionView;
}

- (UIImageView *)getImageviewWithImageName:(NSString *)name {
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.image = [UIImage imageNamed:name];
    tempImageView.layer.masksToBounds = YES;
    tempImageView.backgroundColor = KGrayColor;
    return tempImageView;
}

- (UILabel *)getLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = KFont6Color;
    label.text = title;
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    return label;
}

- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = KBlackColor;
        _lessonTitleLabel.text = @"选择预约课程";
        _lessonTitleLabel.numberOfLines = 1;
        _lessonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonTitleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(38)]];
    }
    return _lessonTitleLabel;
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
   
    ZStudentLessonListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZStudentLessonListItemCell className] forIndexPath:indexPath];
    ZStudentDetailLessonListModel *model = _list[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.lessonBlock) {
        self.lessonBlock(_list[indexPath.row]);
    }
    
    for (int i = 0; i < _list.count; i++) {
        ZStudentDetailLessonListModel *model = _list[i];
        if (i == indexPath.row) {
            model.isLessonSelected = YES;
        }else{
            model.isLessonSelected = NO;
        }
    }
    [_iCollectionView reloadData];
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
    return CGSizeMake((KScreenWidth-CGFloatIn750(60))/2, CGFloatIn750(226));
}

#pragma mark 类型
-(void)setList:(NSArray<ZStudentDetailLessonListModel *> *)list {
    _list = list;
    [self.iCollectionView reloadData];
}

@end

