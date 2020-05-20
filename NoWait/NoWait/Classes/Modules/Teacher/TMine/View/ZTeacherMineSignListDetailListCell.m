//
//  ZTeacherMineSignListDetailListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherMineSignListDetailListCell.h"
#import "ZTeacherMineSignListDetailListItemCell.h"

@interface ZTeacherMineSignListDetailListCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;
@property (nonatomic,strong) UIButton *moreBtn;

@end

@implementation ZTeacherMineSignListDetailListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    [self.contentView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.funBackView.mas_left).offset(CGFloatIn750(60));
        make.right.equalTo(self.funBackView.mas_right).offset(-CGFloatIn750(100));
        make.top.bottom.equalTo(self.funBackView);
    }];
    
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iCollectionView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.iCollectionView.mas_top).offset(CGFloatIn750(20));
        make.width.height.mas_equalTo(CGFloatIn750(60));
    }];
    
}


#pragma mark -Getter
- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    }
    return _funBackView;
}


- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, [ZTeacherMineSignListDetailListCell z_getCellHeight:nil]) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = NO;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
        [_iCollectionView registerClass:[ZTeacherMineSignListDetailListItemCell class] forCellWithReuseIdentifier:[ZTeacherMineSignListDetailListItemCell className]];
    }
    
    return _iCollectionView;
}



- (UIButton *)moreBtn {
    if (!_moreBtn) {
        __weak typeof(self) weakSelf = self;
        _moreBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_moreBtn setTitle:@"..." forState:UIControlStateNormal];
        [_moreBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_moreBtn.titleLabel setFont:[UIFont boldFontTitle]];
        _moreBtn.backgroundColor = adaptAndDarkColor([UIColor colorMainSub],[UIColor colorMainSub]);
        _moreBtn.titleEdgeInsets = UIEdgeInsetsMake(CGFloatIn750(-18), 0, 0, 0);
        ViewRadius(_moreBtn, CGFloatIn750(30));
        [_moreBtn bk_addEventHandler:^(id sender) {
            weakSelf.model.isMore = YES;
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}



#pragma mark collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.model.isMore) {
        if (self.model.list.count < 5) {
            return self.model.list.count;
        }
        return 5;
    }
    return self.model.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZTeacherMineSignListDetailListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZTeacherMineSignListDetailListItemCell className] forIndexPath:indexPath];
    ZOriganizationSignListStudentModel *listModel = self.model.list[indexPath.row];
    listModel.isEdit = self.model.isEdit;
    cell.model = listModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model.isEdit) {
        ZOriganizationSignListStudentModel *listModel = self.model.list[indexPath.row];
        listModel.isSelected = !listModel.isSelected;
        [self.iCollectionView reloadData];
    }else{
        if (self.menuBlock) {
            self.menuBlock(self.model.list[indexPath.row]);
        }
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGFloatIn750(0), CGFloatIn750(0), CGFloatIn750(0), CGFloatIn750(0));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFloatIn750(20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth-CGFloatIn750(160 + 80))/5, CGFloatIn750(180));
}

#pragma mark 类型
- (void)setModel:(ZOriganizationSignListModel *)model {
    _model = model;
    
    self.moreBtn.hidden = model.isMore;
    if (_model.list.count <= 5) {
        self.moreBtn.hidden = YES;
    }
    [self.iCollectionView reloadData];
}


+(CGFloat)z_getCellHeight:(id)sender {
    ZOriganizationSignListModel *model = sender;
    NSArray *list = model.list;
    if (!model.isMore || model.list.count <= 5) {
        return (1) * CGFloatIn750(180);
    }
    
    if (list.count%5 > 0) {
        return (list.count/5 + 1) * CGFloatIn750(180) + ((list.count/5) * CGFloatIn750(10));
    }
    return list.count/5  * CGFloatIn750(180) + (list.count/5 - 1)  * CGFloatIn750(10);
}
@end


