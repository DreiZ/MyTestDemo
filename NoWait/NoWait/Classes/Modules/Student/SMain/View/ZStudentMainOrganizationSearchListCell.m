//
//  ZStudentMainOrganizationSearchListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainOrganizationSearchListCell.h"
#import "ZLocationManager.h"
#import "ZStudentMainOrganizationSearchListItemCell.h"

@interface ZStudentMainOrganizationSearchListCell ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UIView *funBackView;
@property (nonatomic,strong) UICollectionView *iCollectionView;

@property (nonatomic,strong) UIImageView *goodsImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *payPeopleNumLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIView *introductionView;
@property (nonatomic,strong) UIView *activityView;
@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIView *moreView;
@property (nonatomic,strong) UIImageView *moreImageView;
@property (nonatomic,strong) UIView *moreHiddenView;

@property (nonatomic,strong) NSMutableArray *cellConfigArr;

@end

@implementation ZStudentMainOrganizationSearchListCell

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
    
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.payPeopleNumLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.collectionBtn];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(24));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(132));
        make.width.mas_equalTo(CGFloatIn750(210));
    }];
    
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_right);
        make.height.width.mas_equalTo(CGFloatIn750(84));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.goodsImageView.mas_top);
        make.right.equalTo(self.collectionBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.payPeopleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(170));
        make.centerY.equalTo(self.payPeopleNumLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.payPeopleNumLabel.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.contentView addSubview:self.introductionView];
    [self.introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.activityView.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.contentView addSubview:self.moreView];
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(-CGFloatIn750(38));
        make.width.height.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self.contentView addSubview:self.moreHiddenView];
    [self.moreHiddenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moreImageView.mas_left);
        make.left.bottom.equalTo(self.contentView);
        make.top.equalTo(self.goodsImageView.mas_bottom);
    }];
    
    [self.contentView addSubview:self.funBackView];
    [self.funBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo([ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height);
    }];
    
    [self.funBackView addSubview:self.iCollectionView];
    [self.iCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.funBackView);
    }];
}


#pragma mark - Getter
-(UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        _goodsImageView.clipsToBounds = YES;
        ViewRadius(_goodsImageView, CGFloatIn750(8));
    }
    
    return _goodsImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextGray1]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldFontTitle]];
    }
    return _titleLabel;
}

- (UILabel *)payPeopleNumLabel {
    if (!_payPeopleNumLabel) {
        _payPeopleNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _payPeopleNumLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray]);
        
        _payPeopleNumLabel.numberOfLines = 1;
        _payPeopleNumLabel.textAlignment = NSTextAlignmentLeft;
        [_payPeopleNumLabel setFont:[UIFont fontSmall]];
    }
    return _payPeopleNumLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray]);
        
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentRight;
        [_addressLabel setFont:[UIFont fontSmall]];
    }
    return _addressLabel;
}


- (UIView *)introductionView {
    if (!_introductionView) {
        _introductionView = [[UIView alloc] init];
        _introductionView.layer.masksToBounds = YES;
    }
    return _introductionView;
}

- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}

- (UIView *)moreView {
    if (!_moreView) {
        _moreView = [[UIView alloc] init];
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [[UIImage imageNamed:@"fillArrow"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _moreImageView.transform =  CGAffineTransformMakeRotation(M_PI);
        _moreImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _moreImageView.layer.masksToBounds = YES;
        [_moreView addSubview:_moreImageView];
        [_moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.moreView.mas_right).offset(-CGFloatIn750(34));
            make.width.mas_equalTo(CGFloatIn750(14));
            make.height.mas_equalTo(CGFloatIn750(8));
            make.top.equalTo(self.moreView.mas_top).offset(CGFloatIn750(20));
        }];
        
        __weak typeof(self) weakSelf = self;
        UIButton *moreBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [moreBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.moreBlock) {
                weakSelf.moreBlock(weakSelf.model);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [_moreView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.moreView);
        }];
    }
    return _moreView;
}


- (UIButton *)collectionBtn {
    if (!_collectionBtn) {
        __weak typeof(self) weakSelf = self;
        _collectionBtn = [[ZButton alloc] initWithFrame:CGRectZero];
//        [_collectionBtn setImage:[UIImage imageNamed:@"collectionHandle"] forState:UIControlStateNormal];
        UIImageView *collectionImageView = [[UIImageView alloc] init];
        collectionImageView.image = [UIImage imageNamed:@"collectionHandle"];
        collectionImageView.layer.masksToBounds = YES;
        [_collectionBtn addSubview:collectionImageView];
        [collectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.collectionBtn);
            make.height.width.mas_equalTo(CGFloatIn750(20));
        }];
        [_collectionBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}

- (UIView *)moreHiddenView {
    if (!_moreHiddenView) {
        _moreHiddenView = [[UIView alloc] init];
        _moreHiddenView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _moreHiddenView;
}

- (UIView *)funBackView {
    if (!_funBackView) {
        _funBackView = [[UIView alloc] init];
        _funBackView.layer.masksToBounds = YES;
        _funBackView.clipsToBounds = YES;
        _funBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorBlackBGDark]);
    }
    return _funBackView;
}


- (UICollectionView *)iCollectionView {
    if (!_iCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _iCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(100)) collectionViewLayout:flowLayout];
        _iCollectionView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _iCollectionView.dataSource = self;
        _iCollectionView.delegate = self;
        _iCollectionView.scrollEnabled = YES;
        _iCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_iCollectionView registerClass:[ZStudentMainOrganizationSearchListItemCell class] forCellWithReuseIdentifier:[ZStudentMainOrganizationSearchListItemCell className]];
    }
    
    return _iCollectionView;
}

#pragma mark - setModel
- (void)setModel:(ZStoresListModel *)model {
    _model = model;
    _titleLabel.text = model.name;
    _payPeopleNumLabel.text = [NSString stringWithFormat:@"%@人已付款",model.pay_nums];
    _addressLabel.text = [NSString stringWithFormat:@"%@",model.distance];
    [_goodsImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.image)] placeholderImage:[UIImage imageNamed:@"default_loadFail276"]];
    self.moreView.hidden = YES;
    [self setActivityData];
    if (model.coupons && model.coupons.count > 0) {
        [self setIntroData];
        self.introductionView.hidden = NO;
        if (ValidArray(self.model.tags)) {
            [self.introductionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
                make.top.equalTo(self.activityView.mas_bottom).offset(CGFloatIn750(18));
                make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
                make.height.mas_equalTo(CGFloatIn750(40));
            }];
        }else{
            [self.introductionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
                make.top.equalTo(self.payPeopleNumLabel.mas_bottom).offset(CGFloatIn750(18));
                make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
                make.height.mas_equalTo(CGFloatIn750(40));
            }];
        }
    }else{
        self.introductionView.hidden = YES;
    }
    if (model.isStudentCollection) {
        [self.collectionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.height.width.mas_equalTo(CGFloatIn750(84));
        }];
    }else {
        [self.collectionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_right);
            make.height.width.mas_equalTo(CGFloatIn750(84));
        }];
    }
    
    if (_model.isMore) {
        _moreImageView.transform =  CGAffineTransformMakeRotation(0);
        _moreHiddenView.hidden = YES;
    }else{
        _moreImageView.transform =  CGAffineTransformMakeRotation(M_PI);
        _moreHiddenView.hidden = NO;
    }
    for (int i = 0; i < model.course.count; i++) {
        ZCellConfig *cellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMainOrganizationSearchListItemCell className] title:[ZStudentMainOrganizationSearchListItemCell className] showInfoMethod:@selector(setModel:) sizeOfCell:[ZStudentMainOrganizationSearchListItemCell z_getCellSize:model.course[i]] cellType:ZCellTypeClass dataModel:model.course[i]];
        
        [self.cellConfigArr addObject:cellConfig];
    }
    [self.iCollectionView reloadData];
}

+(CGFloat)z_getCellHeight:(id)sender {
    ZStoresListModel *model = sender;
    if (model) {
        if (!model.isMore) {
            return CGFloatIn750(188) + (ValidArray(model.course)? [ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height:0);
        }
        NSMutableArray *ttArr = @[].mutableCopy;
        [ttArr addObjectsFromArray:model.tags];
        NSArray *textArr = ttArr;
        
        CGFloat leftX = 0;
        CGFloat leftY = 0;
        for (int i = 0; i < textArr.count; i++) {
            CGPoint label = [ZStudentMainOrganizationSearchListCell getViewWithText:textArr[i] leftX:leftX leftY:leftY model:model];
            leftY = label.y;
            leftX = label.x;
        }
        
        CGFloat couponHeight = 0;
        if (model.coupons && model.coupons.count > 0) {
            NSMutableArray *ttArr = @[].mutableCopy;
            for (int i = 0; i < model.coupons.count; i++) {
                ZOriganizationCardListModel *smodel = model.coupons[i];
                [ttArr addObject:smodel.title];
            }
            NSArray *textArr = ttArr;
            
            CGFloat leftX = 0;
            CGFloat leftY = 0;
            for (int i = 0; i < textArr.count; i++) {
                CGPoint label = [ZStudentMainOrganizationSearchListCell getViewWithText:textArr[i] leftX:leftX leftY:leftY model:model];
                leftY = label.y;
                leftX = label.x;
            }
            couponHeight = leftY + CGFloatIn750(40);
        }
        if (textArr.count == 0) {
            if (!model.coupons || model.coupons.count == 0) {
                return CGFloatIn750(188) + (ValidArray(model.course)? [ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height:0);
            }else{
                return CGFloatIn750(188) + couponHeight + (ValidArray(model.course)? [ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height:0);
            }
        }
        if (!model.coupons || model.coupons.count == 0) {
            return CGFloatIn750(188) + leftY  + (ValidArray(model.course)? [ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height:0);
        }else{
            return CGFloatIn750(188) + leftY + couponHeight  +  (ValidArray(model.course)? [ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height:0);
        }
        
    }
    return CGFloatIn750(188) + (ValidArray(model.course)? [ZStudentMainOrganizationSearchListItemCell z_getCellSize:nil].height:0);
}


- (void)setActivityData {
    [self.activityView removeAllSubviews];
    NSMutableArray *ttArr = @[].mutableCopy;
    [ttArr addObjectsFromArray:self.model.tags];
    
    NSArray *textArr = ttArr;
    
    CGFloat leftX = 0;
    CGFloat leftY = 0;
    for (int i = 0; i < textArr.count; i++) {
        UIView *label = [self getViewWithText:textArr[i] leftX:leftX leftY:leftY colorType:YES];
        leftY = label.top;
        [self.activityView addSubview:label];
        leftX = label.right + CGFloatIn750(8);
    }
    
    [self.activityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.payPeopleNumLabel.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        if (self.model.isMore) {
            make.height.mas_equalTo(leftY + CGFloatIn750(40));
        }else{
            make.height.mas_equalTo(CGFloatIn750(40));
        }
        
    }];
}


- (void)setIntroData {
    [self.introductionView removeAllSubviews];
    NSMutableArray *ttArr = @[].mutableCopy;
    for (int i = 0; i < self.model.coupons.count; i++) {
        ZOriganizationCardListModel *smodel = self.model.coupons[i];
        [ttArr addObject:smodel.title];
    }
    
    NSArray *textArr = ttArr;
    
    CGFloat leftX = 0;
    CGFloat leftY = 0;
    for (int i = 0; i < textArr.count; i++) {
        UIView *label = [self getViewWithText:textArr[i] leftX:leftX leftY:leftY colorType:NO];
        leftY = label.top;
        [self.introductionView addSubview:label];
        leftX = label.right + CGFloatIn750(8);
    }
    
    [self.introductionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.activityView.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
//        make.height.mas_equalTo(leftY + CGFloatIn750(40));
        if (self.model.isMore) {
            make.height.mas_equalTo(leftY + CGFloatIn750(40));
        }else{
            make.height.mas_equalTo(CGFloatIn750(40));
        }
    }];
}

- (UIView *)getViewWithText:(NSString *)text leftX:(CGFloat)leftX leftY:(CGFloat)leftY colorType:(BOOL)isTags{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
    
    UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, leftY, tempSize.width+6, CGFloatIn750(36))];
    if (isTags) {
        actLabel.backgroundColor = adaptAndDarkColor([UIColor colorMainSub],[UIColor colorMainSub]);
        actLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }else{
        actLabel.backgroundColor = adaptAndDarkColor([UIColor colorRedForLabelSub],[UIColor colorRedForLabelSub]);
        actLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
    }
    
    actLabel.layer.masksToBounds = YES;
    actLabel.layer.cornerRadius = 2;
    actLabel.text = text;
    actLabel.numberOfLines = 0;
    actLabel.textAlignment = NSTextAlignmentCenter;
    [actLabel setFont:[UIFont fontMin]];
    
    if (leftX + tempSize.width + 6 < (KScreenWidth - CGFloatIn750(134 * 2 + 20) - CGFloatIn750(48))) {
        actLabel.frame = CGRectMake(leftX, leftY, tempSize.width+6, CGFloatIn750(36));
    }else{
        self.moreView.hidden = NO;
        actLabel.frame = CGRectMake(0, leftY + CGFloatIn750(36) + CGFloatIn750(20), tempSize.width+6, CGFloatIn750(36));
    }
    return actLabel;
}

+ (CGPoint)getViewWithText:(NSString *)text leftX:(CGFloat)leftX leftY:(CGFloat)leftY model:(ZStoresListModel *)model{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
     
     if (leftX + tempSize.width + 6 < KScreenWidth - CGFloatIn750(134 * 2 + 20) - CGFloatIn750(48)) {
         return CGPointMake(leftX + tempSize.width+6 + CGFloatIn750(8), leftY);
     }else{
         return CGPointMake(tempSize.width+6 + CGFloatIn750(8), leftY + CGFloatIn750(36) + CGFloatIn750(20));
     }
}


#pragma mark collectionview delegate
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
