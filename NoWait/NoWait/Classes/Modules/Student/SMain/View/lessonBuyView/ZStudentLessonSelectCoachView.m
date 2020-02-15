//
//  ZStudentLessonSelectCoachView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonSelectCoachView.h"
#import "ZStudentLessonListCoachItemCell.h"

@interface ZStudentLessonSelectCoachView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) UILabel *lessonTitleLabel;
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIButton *lastStepBtn;

@end

@implementation ZStudentLessonSelectCoachView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;

    __weak typeof(self) weakSelf = self;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
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
    
    [topView addSubview:self.lastStepBtn];
    [self.lastStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(10));
        make.top.bottom.equalTo(topView);
        make.width.mas_equalTo(CGFloatIn750(90));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorBlackBG]);
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
    lessonImageView.image = [UIImage imageNamed:@"lessonCoach"];
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
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    }
    return _funBackView;
}


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        __weak typeof(self) weakSelf = self;
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(38)]];
        [_bottomBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_bottomBtn bk_whenTapped:^{
            if (weakSelf.bottomBlock) {
                weakSelf.bottomBlock();
            }
        }];
    }
    return _bottomBtn;
}

- (UIButton *)lastStepBtn {
    if (!_lastStepBtn) {
        __weak typeof(self) weakSelf = self;
        _lastStepBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_lastStepBtn setImage:[UIImage imageNamed:@"leftBlackArrow"] forState:UIControlStateNormal];
        [_lastStepBtn bk_whenTapped:^{
            if (weakSelf.lastStepBlock) {
                weakSelf.lastStepBlock();
            }
        }];
    }
    return _lastStepBtn;
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
        [_iCollectionView registerClass:[ZStudentLessonListCoachItemCell class] forCellWithReuseIdentifier:[ZStudentLessonListCoachItemCell className]];
        [_iCollectionView setBackgroundColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG])];
        _iCollectionView.delegate = self;
        _iCollectionView.dataSource = self;
    }
    
    return _iCollectionView;
}


- (UILabel *)lessonTitleLabel {
    if (!_lessonTitleLabel) {
        _lessonTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _lessonTitleLabel.text = @"请选择教练";
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
   
    ZStudentLessonListCoachItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZStudentLessonListCoachItemCell className] forIndexPath:indexPath];
    ZStudentDetailLessonCoachModel *model = _list[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.coachBlock) {
        self.coachBlock(_list[indexPath.row]);
    }
    
    for (int i = 0; i < _list.count; i++) {
        ZStudentDetailLessonCoachModel *model = _list[i];
        if (i == indexPath.row) {
            model.isCoachSelected = YES;
        }else{
            model.isCoachSelected = NO;
        }
    }
    [_iCollectionView reloadData];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(20), CGFloatIn750(20), CGFloatIn750(0), CGFloatIn750(20));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth-CGFloatIn750(80))/3, CGFloatIn750(300));
}

#pragma mark 类型
-(void)setList:(NSArray<ZStudentDetailLessonCoachModel *> *)list {
    _list = list;
    if (_buyType == ZLessonBuyTypeSubscribeInitial || _buyType == ZLessonBuyTypeSubscribeInitial) {
        self.lastStepBtn.hidden = NO;
    }else{
        self.lastStepBtn.hidden = YES;
    }
    [self.iCollectionView reloadData];
    
}

- (void)setBuyType:(ZLessonBuyType)buyType {
    _buyType = buyType;
    if (_buyType == ZLessonBuyTypeSubscribeInitial || _buyType == ZLessonBuyTypeSubscribeInitial) {
        self.lastStepBtn.hidden = NO;
    }else{
        self.lastStepBtn.hidden = YES;
    }
}
@end


