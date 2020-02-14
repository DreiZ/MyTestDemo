//
//  ZStudentOrganizationPersonnelListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationPersonnelListItemCell.h"

@implementation ZStudentOrganizationPersonnelListItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    self.clipsToBounds = YES;
    
    
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.skillLabel];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.height.mas_equalTo(CGFloatIn750(134));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(16));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.userImageView.mas_centerX);
        make.top.equalTo(self.userImageView.mas_bottom).offset(CGFloatIn750(8));
    }];
    
    [self.skillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.userImageView.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(4));
        make.height.mas_equalTo(CGFloatIn750(28));
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
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _titleLabel;
}

- (YYLabel *)skillLabel {
    if (!_skillLabel) {
        _skillLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _skillLabel.layer.masksToBounds = YES;
        _skillLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _skillLabel.layer.cornerRadius = 3;
        _skillLabel.backgroundColor = [UIColor  colorMain];
        _skillLabel.numberOfLines = 0;
        _skillLabel.textAlignment = NSTextAlignmentCenter;
        [_skillLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
        NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"擅长仰泳"];
        text.lineSpacing = 1;
        text.font = [UIFont systemFontOfSize:CGFloatIn750(22)];
        text.color = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _skillLabel.preferredMaxLayoutWidth = kScreenWidth/4 - CGFloatIn750(44);
        _skillLabel.attributedText = text;
    }
    return _skillLabel;
}
@end
