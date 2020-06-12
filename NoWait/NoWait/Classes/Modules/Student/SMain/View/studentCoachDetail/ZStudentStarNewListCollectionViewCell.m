//
//  ZStudentStarNewListCollectionViewCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarNewListCollectionViewCell.h"

@interface ZStudentStarNewListCollectionViewCell ()
@property (nonatomic,strong) UIView *contBackView;

@end

@implementation ZStudentStarNewListCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.contBackView];
    [self.contBackView addSubview:self.userImageView];
    [self.contBackView addSubview:self.titleLabel];
    [self.contBackView addSubview:self.skillLabel];
    
    [self.contBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contBackView.mas_centerY);
        make.left.equalTo(self.contBackView.mas_left).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userImageView.mas_centerY).offset(-CGFloatIn750(8));
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(16));
    }];
    
    [self.skillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_centerY).offset(CGFloatIn750(8));
        make.left.equalTo(self.titleLabel.mas_left);
    }];
    
    
    __weak typeof(self) weakSelf = self;
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [detailBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.detailBlock) {
            weakSelf.detailBlock(weakSelf.userImageView);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


#pragma mark -懒加载
- (UIView *)contBackView {
    if (!_contBackView) {
        _contBackView = [[UIView alloc] init];
        _contBackView.layer.masksToBounds = YES;
        _contBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        _contBackView.layer.cornerRadius = CGFloatIn750(8);
    }
    return _contBackView;
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = CGFloatIn750(50);
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _userImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontSmall]];
    }
    return _titleLabel;
}

- (UILabel *)skillLabel {
    if (!_skillLabel) {
        _skillLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _skillLabel.layer.masksToBounds = YES;
        _skillLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _skillLabel.numberOfLines = 1;
        _skillLabel.textAlignment = NSTextAlignmentLeft;
        [_skillLabel setFont:[UIFont fontMin]];
    }
    return _skillLabel;
}

- (void)setModel:(ZOriganizationTeacherListModel *)model {
    _model = model;
    [self.userImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.image)] placeholderImage:[UIImage imageNamed:@"default_head"]];
    if (model.isStarStudent) {
        self.titleLabel.text = model.name;
        self.skillLabel.text = model.stores_courses_name;
    }else{
        self.titleLabel.text = model.teacher_name;
        self.skillLabel.text = model.position;
    }
}

+(CGSize)zz_getCollectionCellSize {
    return CGSizeMake((KScreenWidth-CGFloatIn750(80))/2, 70.0f/167.0 * (KScreenWidth-CGFloatIn750(80))/2);
}
@end
