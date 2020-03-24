//
//  ZStudentOrganizationLessonListCollectionCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationLessonListCollectionCell.h"

@interface ZStudentOrganizationLessonListCollectionCell ()
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UIImageView *lessonImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *favourablePriceLabel;
@property (nonatomic,strong) UILabel *goodReputationLabel;
@property (nonatomic,strong) UILabel *sellCountLabel;
@end

@implementation ZStudentOrganizationLessonListCollectionCell


- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.lessonImageView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.priceLabel];
    [self.backView addSubview:self.favourablePriceLabel];
    [self.backView addSubview:self.goodReputationLabel];
    [self.backView addSubview:self.sellCountLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.lessonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(CGFloatIn750(220));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.lessonImageView.mas_bottom).offset(CGFloatIn750(16));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(130));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(14));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(130));
    }];
    
    [self.favourablePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.priceLabel.mas_bottom).offset(-3);
        make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(4));
    }];
    self.favourablePriceLabel.hidden = YES;
    
    [self.goodReputationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(120));
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.sellCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(120));
        make.centerY.equalTo(self.priceLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
}


#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatIn750(16);
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _backView;
}
-(UIImageView *)lessonImageView {
    if (!_lessonImageView) {
        _lessonImageView = [[UIImageView alloc] init];
        _lessonImageView.contentMode = UIViewContentModeScaleAspectFill;
        _lessonImageView.clipsToBounds = YES;
        _lessonImageView.layer.cornerRadius = 3;
        _lessonImageView.layer.masksToBounds = YES;
    }
    
    return _lessonImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontContent]];
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _titleLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor colorRedDefault];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont fontContent]];
        [_priceLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _priceLabel;
}

- (UILabel *)favourablePriceLabel {
    if (!_favourablePriceLabel) {
        _favourablePriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _favourablePriceLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _favourablePriceLabel.numberOfLines = 1;
        _favourablePriceLabel.textAlignment = NSTextAlignmentRight;
        [_favourablePriceLabel setFont:[UIFont fontMin]];
    }
    return _favourablePriceLabel;
}

- (UILabel *)goodReputationLabel {
    if (!_goodReputationLabel) {
        _goodReputationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodReputationLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _goodReputationLabel.numberOfLines = 1;
        _goodReputationLabel.textAlignment = NSTextAlignmentRight;
        [_goodReputationLabel setFont:[UIFont fontSmall]];
        [_goodReputationLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _goodReputationLabel;
}

- (UILabel *)sellCountLabel {
    if (!_sellCountLabel) {
        _sellCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _sellCountLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _sellCountLabel.numberOfLines = 1;
        _sellCountLabel.textAlignment = NSTextAlignmentRight;
        [_sellCountLabel setFont:[UIFont fontSmall]];
        [_sellCountLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _sellCountLabel;
}

- (void)setModel:(ZOriganizationLessonListModel *)model {
    _model = model;
    [_lessonImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.image_url)]];
    _titleLabel.text = @"图形俱乐部";
    _sellCountLabel.text = @"已售200";
    _goodReputationLabel.text = @"90%好评";
    _favourablePriceLabel.text = @"￥256";
    _priceLabel.text = @"￥543";
    
    _titleLabel.text = model.name;
    _sellCountLabel.text = [NSString stringWithFormat:@"已售%@",model.pay_nums];
    _goodReputationLabel.text = [NSString stringWithFormat:@"%@好评",model.score];
    _favourablePriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake((KScreenWidth-CGFloatIn750(90))/2, 175/165 * (KScreenWidth-CGFloatIn750(90))/2);
}
@end

