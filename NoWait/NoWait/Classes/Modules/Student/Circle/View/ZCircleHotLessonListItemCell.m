//
//  ZCircleHotLessonListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleHotLessonListItemCell.h"

@interface ZCircleHotLessonListItemCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *orignLabel;
@property (nonatomic,strong) UIView *orignLineView;

@property (nonatomic,strong) UIImageView *lessonImageView;

@end

@implementation ZCircleHotLessonListItemCell

- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.lessonImageView];
    [self.backView addSubview:self.priceLabel];
    [self.backView addSubview:self.orignLabel];
    [self.backView addSubview:self.orignLineView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.lessonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(132));
        make.width.mas_equalTo(CGFloatIn750(210));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.backView.mas_centerX);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(20));
        make.top.equalTo(self.lessonImageView.mas_bottom).offset(CGFloatIn750(18));
        make.height.mas_lessThanOrEqualTo(CGFloatIn750(70));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-CGFloatIn750(18));
    }];
    
    [self.orignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(4));
        make.bottom.equalTo(self.backView.mas_bottom).offset(-CGFloatIn750(18));
    }];
    
    [self.orignLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orignLabel);
        make.centerY.equalTo(self.orignLabel.mas_centerY);
        make.height.mas_equalTo(1);
    }];
}


#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _backView.layer.cornerRadius = CGFloatIn750(16);
    }
    return _backView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (UIImageView *)lessonImageView {
    if (!_lessonImageView) {
        _lessonImageView = [[UIImageView alloc] init];
        _lessonImageView.layer.masksToBounds = YES;
        _lessonImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_lessonImageView, CGFloatIn750(8));
    }
    return _lessonImageView;
}


- (UIView *)orignLineView {
    if (!_orignLineView) {
        _orignLineView = [[UIView alloc] init];
        _orignLineView.layer.masksToBounds = YES;
        _orignLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGray]);
    }
    return _orignLineView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor colorOrangeHot];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont fontMin]];
    }
    return _priceLabel;
}


- (UILabel *)orignLabel {
    if (!_orignLabel) {
        _orignLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orignLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _orignLabel.numberOfLines = 1;
        _orignLabel.textAlignment = NSTextAlignmentLeft;
        [_orignLabel setFont:[UIFont fontMin]];
    }
    return _orignLabel;
}

- (void)setModel:(ZCircleDynamicLessonModel *)model {
    _model = model;

    [_lessonImageView tt_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    
    self.nameLabel.text = model.name;
    
    if ([model.is_experience intValue] == 1) {
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.experience_price];
        self.orignLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        self.priceLabel.textColor = [UIColor colorMain];
        self.orignLabel.hidden = NO;
        self.orignLineView.hidden = NO;
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        self.orignLabel.hidden = YES;
        self.orignLineView.hidden = YES;
        self.priceLabel.textColor = [UIColor colorOrangeHot];
    }
}


+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(CGFloatIn750(250), CGFloatIn750(286));
}
@end



