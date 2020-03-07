//
//  ZStudentOrganizationPersonnelListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationPersonnelListItemCell.h"

@interface ZStudentOrganizationPersonnelListItemCell ()
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZStudentOrganizationPersonnelListItemCell

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
    UIView *backView = [[UIView alloc] init];
    _backView = backView;
    backView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = CGFloatIn750(8);
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [backView addSubview:self.userImageView];
    [backView addSubview:self.titleLabel];
    [backView addSubview:self.skillLabel];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.height.mas_equalTo(CGFloatIn750(80));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(20));
    }];
    ViewRadius(self.userImageView, CGFloatIn750(40));
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_bottom).offset(CGFloatIn750(16));
        make.left.right.equalTo(self.backView);
    }];
    
    [self.skillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(12));
        make.height.mas_equalTo(CGFloatIn750(28));
        make.left.right.equalTo(self.backView);
    }];
}

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.layer.masksToBounds = YES;
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
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontSmall]];
    }
    return _titleLabel;
}

- (YYLabel *)skillLabel {
    if (!_skillLabel) {
        _skillLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _skillLabel.layer.masksToBounds = YES;
        _skillLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _skillLabel.textAlignment = NSTextAlignmentCenter;
        [_skillLabel setFont:[UIFont fontMin]];
        _skillLabel.text = @"擅长仰泳";
    }
    return _skillLabel;
}
@end
