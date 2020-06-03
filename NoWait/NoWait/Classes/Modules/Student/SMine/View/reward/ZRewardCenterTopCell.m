//
//  ZRewardCenterTopCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardCenterTopCell.h"

@interface ZRewardCenterTopCell ()
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *midLabel;
@property (nonatomic,strong) UILabel *inviteLabel;
@property (nonatomic,strong) UIImageView *erweimageView;
@end

@implementation ZRewardCenterTopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.midLabel];
    [self.contentView addSubview:self.erweimageView];
    [self.contentView addSubview:self.inviteLabel];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(70));
        make.top.equalTo(self.contentView.mas_top).offset(CGFloatIn750(40));
        make.width.height.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(CGFloatIn750(30));
        make.top.equalTo(self.userImageView.mas_top).offset(CGFloatIn750(4));
        make.right.equalTo(self.inviteLabel.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [self.erweimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(120));
        make.width.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.inviteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.erweimageView.mas_centerX);
        make.top.equalTo(self.erweimageView.mas_bottom).offset(CGFloatIn750(16));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *inviteBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [inviteBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(1);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:inviteBtn];
    [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inviteLabel.mas_left).offset(-CGFloatIn750(20));
        make.right.equalTo(self.inviteLabel.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.erweimageView.mas_top).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.inviteLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        ViewRadius(_userImageView, CGFloatIn750(50));
    }
    return _userImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontTitle]];
    }
    return _nameLabel;
}


- (UILabel *)inviteLabel {
    if (!_inviteLabel) {
        _inviteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _inviteLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        _inviteLabel.text = @"邀请好友";
        _inviteLabel.numberOfLines = 1;
        _inviteLabel.textAlignment = NSTextAlignmentCenter;
        [_inviteLabel setFont:[UIFont fontSmall]];
    }
    return _inviteLabel;
}

- (UILabel *)midLabel {
    if (!_midLabel) {
        _midLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _midLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        
        _midLabel.numberOfLines = 1;
        _midLabel.textAlignment = NSTextAlignmentLeft;
        [_midLabel setFont:[UIFont fontSmall]];
    }
    return _midLabel;
}

- (UIImageView *)erweimageView {
    if (!_erweimageView) {
        _erweimageView = [[UIImageView alloc] init];
        _erweimageView.image = [[UIImage imageNamed:@"erweimlist"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _erweimageView.tintColor = [UIColor colorMain];
        _erweimageView.layer.masksToBounds = YES;
        _erweimageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _erweimageView;
}

- (void)setModel:(ZRewardInfoModel *)model {
    _model = model;
    _midLabel.text = [NSString stringWithFormat:@"MID:%@",SafeStr(model.inviter_code)];
    [_userImageView tt_setImageWithURL:[NSURL URLWithString:[ZUserHelper sharedHelper].user.avatar] placeholderImage:[UIImage imageNamed:@"default_head"]];
    _nameLabel.text = [ZUserHelper sharedHelper].user.nikeName;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(200);
}
@end
