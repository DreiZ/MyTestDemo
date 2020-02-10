//
//  ZStudentLessonListCoachItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonListCoachItemCell.h"

@interface ZStudentLessonListCoachItemCell ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *coachImageView;
@property (nonatomic,strong) UIImageView *selectImageView;
@property (nonatomic,strong) UIImageView *selectTopImageView;
@property (nonatomic,strong) UIImageView *goldImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@end

@implementation ZStudentLessonListCoachItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(270));
        make.left.right.equalTo(self);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.contView addSubview:self.coachImageView];
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.priceLabel];
    [self.contView addSubview:self.selectImageView];
    [self.contView addSubview:self.selectTopImageView];
    [self.contView addSubview:self.goldImageView];
    
    [self.coachImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(196));
    }];
    
    [self.selectTopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(20));
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right);
        make.bottom.equalTo(self.contView.mas_bottom);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(20));
        make.top.equalTo(self.coachImageView.mas_bottom).offset(CGFloatIn750(8));
    }];
    
    [self.goldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.right.equalTo(self.nameLabel.mas_left).offset(CGFloatIn750(-10));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.coachImageView.mas_centerX);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(6));
    }];
}


#pragma mark -lazying loading---
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.layer.borderWidth = 1;
        _contView.layer.borderColor = KFont6Color.CGColor;
        _contView.layer.cornerRadius = CGFloatIn750(20);
    }
    return _contView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = KFont6Color;
        _nameLabel.text = @"";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _nameLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = KFont6Color;
        _priceLabel.text = @"";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    }
    return _priceLabel;
}

- (UIImageView *)coachImageView {
    if (!_coachImageView) {
        _coachImageView = [[UIImageView alloc] init];
        _coachImageView.image = [UIImage imageNamed:@"coachSelect5"];
        _coachImageView.layer.masksToBounds = YES;
    }
    return _coachImageView;
}

- (UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
        _selectImageView.image = [UIImage imageNamed:@"studentCoachSelect"];
        _selectImageView.layer.masksToBounds = YES;
    }
    return _selectImageView;
}


- (UIImageView *)selectTopImageView {
    if (!_selectTopImageView) {
        _selectTopImageView = [[UIImageView alloc] init];
        _selectTopImageView.image = [UIImage imageNamed:@"studentNoSelect"];
        _selectTopImageView.layer.masksToBounds = YES;
    }
    return _selectTopImageView;
}


- (UIImageView *)goldImageView {
    if (!_goldImageView) {
        _goldImageView = [[UIImageView alloc] init];
        _goldImageView.image = [UIImage imageNamed:@"lessonSelectCoach"];
        _goldImageView.layer.masksToBounds = YES;
    }
    return _goldImageView;
}

#pragma mark -setdata
-(void)setModel:(ZStudentDetailLessonCoachModel *)model {
    _model = model;
    _nameLabel.text = model.coachName;
    _priceLabel.text = model.coachPrice;
    _coachImageView.image = [UIImage imageNamed:model.coachImage];
    if (model.isCoachSelected) {
        _nameLabel.textColor = KMainColor;
        _priceLabel.textColor = KMainColor;
        _selectTopImageView.image = [UIImage imageNamed:@"studentSelect"];
        _contView.layer.borderColor = KMainColor.CGColor;
        _selectImageView.hidden = NO;
    }else{
        _nameLabel.textColor = KFont6Color;
        _priceLabel.textColor = KFont6Color;
        _selectTopImageView.image = [UIImage imageNamed:@"studentNoSelect"];
        _contView.layer.borderColor = KFont6Color.CGColor;
        _selectImageView.hidden = YES;
    }
}
@end
