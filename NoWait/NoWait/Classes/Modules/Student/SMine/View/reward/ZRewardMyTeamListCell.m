//
//  ZRewardMyTeamListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardMyTeamListCell.h"
@interface ZRewardMyTeamListCell ()
@property (nonatomic,strong) UIImageView *userImageView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *statusLabel;

@property (nonatomic,strong) UIView *contView;
@end

@implementation ZRewardMyTeamListCell

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
    [self.contView addSubview:self.statusLabel];
    
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.userImageView.mas_centerY);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.userImageView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(52));
        make.height.mas_equalTo(CGFloatIn750(28));
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
       
        _userImageView.layer.masksToBounds = YES;
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.layer.cornerRadius = CGFloatIn750(30);
    }
    return _userImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}


- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMain]);
        _statusLabel.text = @"上级";
        _statusLabel.numberOfLines = 1;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [_statusLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
        ViewBorderRadius(_statusLabel, CGFloatIn750(4), 1, [UIColor colorMain]);
        _statusLabel.backgroundColor = [UIColor colorMainSub];
    }
    return _statusLabel;
}

- (void)setModel:(ZRewardTeamListModel *)model {
    _model = model;
    _nameLabel.text = model.nick_name;
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"default_head"]];
    _statusLabel.text = model.level;
    if (ValidStr(model.level)) {
        _statusLabel.hidden = NO;
        self.contView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }else{
        _statusLabel.hidden = YES;
        self.contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(120);
}

@end









