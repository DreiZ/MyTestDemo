//
//  ZRewardRankingBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardRankingBottomView.h"

@interface ZRewardRankingBottomView ()
@property (nonatomic,strong) UIImageView *userImageView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *codeLabel;
@property (nonatomic,strong) UILabel *codelHintLabel;
@property (nonatomic,strong) UILabel *statusLabel;

@end

@implementation ZRewardRankingBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorMain];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    
    [self addSubview:self.userImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.statusLabel];
    [self addSubview:self.codeLabel];
    [self addSubview:self.codelHintLabel];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(50));
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_centerX).offset(CGFloatIn750(160));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [self.codelHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
        make.top.equalTo(self.mas_centerY).offset(CGFloatIn750(6));
    }];
    
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.codelHintLabel.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(-CGFloatIn750(6));
    }];
}


#pragma mark - Getter
- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        
        _userImageView.layer.masksToBounds = YES;
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.layer.cornerRadius = CGFloatIn750(40);
    }
    return _userImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}


- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        
        _statusLabel.numberOfLines = 0;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [_statusLabel setFont:[UIFont boldFontSmall]];
    }
    return _statusLabel;
}


- (UILabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _codeLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        
        _codeLabel.numberOfLines = 1;
        _codeLabel.textAlignment = NSTextAlignmentRight;
        [_codeLabel setFont:[UIFont boldFontContent]];
    }
    return _codeLabel;
}


- (UILabel *)codelHintLabel {
    if (!_codelHintLabel) {
        _codelHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _codelHintLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        
        _codelHintLabel.numberOfLines = 1;
        _codelHintLabel.textAlignment = NSTextAlignmentCenter;
        [_codelHintLabel setFont:[UIFont fontSmall]];
    }
    return _codelHintLabel;
}

- (void)setRank:(ZRewardRankingMyModel *)rank {
    _rank = rank;
    _codelHintLabel.text = [NSString stringWithFormat:@"距离上一名%@元",rank.prev];
    _codeLabel.text = [NSString stringWithFormat:@"%@元",rank.total_amount];
    _statusLabel.text = rank.rank_desc;
    _nameLabel.text = rank.name;
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:rank.image] placeholderImage:[UIImage imageNamed:@"default_head"]];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}

@end


