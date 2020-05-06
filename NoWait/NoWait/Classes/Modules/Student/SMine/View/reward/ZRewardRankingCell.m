//
//  ZRewardRankingCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardRankingCell.h"

@interface ZRewardRankingCell ()
@property (nonatomic,strong) UIImageView *userImageView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *indexLabel;
@property (nonatomic,strong) UIView *progressView;


@property (nonatomic,strong) UIView *contView;
@end

@implementation ZRewardRankingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    
    [self.contentView addSubview:self.userImageView];
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.indexLabel];
    [self.contView addSubview:self.moneyLabel];
    [self.contView addSubview:self.progressView];
    
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(36));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.indexLabel.mas_right).offset(CGFloatIn750(12));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.userImageView.mas_centerY).offset(-CGFloatIn750(10));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.userImageView.mas_centerY).offset(CGFloatIn750(12));
        make.height.mas_equalTo(CGFloatIn750(8));
        make.width.mas_equalTo(KScreenWidth - CGFloatIn750(260));
    }];
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        [_userImageView tt_setImageWithURL:[NSURL URLWithString:[ZUserHelper sharedHelper].user.avatar] placeholderImage:[UIImage imageNamed:@"default_head"]];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.layer.cornerRadius = CGFloatIn750(40);
    }
    return _userImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"斯柯达公司两个";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}


- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _indexLabel.textColor = adaptAndDarkColor(HexAColor(0xfebe4d, 1),HexAColor(0xfebe4d, 1));
        _indexLabel.text = @"1";
        _indexLabel.numberOfLines = 1;
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        [_indexLabel setFont:[UIFont fontContent]];
        ViewRadius(_indexLabel, CGFloatIn750(20));
        _indexLabel.backgroundColor = HexAColor(0xfebe4d, 0.1);
    }
    return _indexLabel;
}


- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _moneyLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _moneyLabel.text = @"234";
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        [_moneyLabel setFont:[UIFont boldFontContent]];
    }
    return _moneyLabel;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.layer.masksToBounds = YES;
        _progressView.backgroundColor = [UIColor colorRedDefault];
        ViewRadius(_progressView, CGFloatIn750(4));
    }
    return _progressView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(140);
}

@end

