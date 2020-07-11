//
//  ZCircleRecommendCollectionCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleRecommendCollectionCell.h"
#import "JHLikeButton.h"

@interface ZCircleRecommendCollectionCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *userLabel;

@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIImageView *likeImageView;
@property (nonatomic,strong) UIImageView *playerImageView;


@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) UIImageView *addressImageView;
@property (nonatomic,strong) UIView *addressBackView;


@property (nonatomic,strong) JHLikeButton *likeImageBtn;

@property (nonatomic,strong) UIButton *coverBtn;
@property (nonatomic,strong) UIButton *userBtn;
@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,assign) BOOL isLike;
@end

@implementation ZCircleRecommendCollectionCell


- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.contentView.clipsToBounds = YES;
    
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.coverImageView];
    [self.backView addSubview:self.contView];
    [self.backView addSubview:self.coverBtn];
    
    [self.backView addSubview:self.addressBackView];
    [self.backView addSubview:self.addressImageView];
    [self.backView addSubview:self.addressLabel];
    [self.backView addSubview:self.distanceLabel];
    [self.backView addSubview:self.playerImageView];
    
    [self.contView addSubview:self.userLabel];
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.headImageView];
    [self.contView addSubview:self.likeImageView];
    [self.contView addSubview:self.likeImageBtn];
    
    [self.contView addSubview:self.userBtn];
    [self.contView addSubview:self.likeBtn];
    
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.backView);
        make.bottom.equalTo(self.contView.mas_top);
    }];
    
    [self.playerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.coverImageView);
    }];
    
    [self.coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.coverImageView);
    }];
    
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.coverImageView.mas_bottom).offset(CGFloatIn750(-16));
        make.width.height.mas_equalTo(CGFloatIn750(18));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImageView.mas_right).offset(CGFloatIn750(8));
        make.centerY.equalTo(self.addressImageView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(CGFloatIn750(14));
        make.centerY.equalTo(self.addressImageView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
    
    [self.addressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImageView.mas_left).offset(-CGFloatIn750(10));
        make.right.equalTo(self.distanceLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.addressImageView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(32));
    }];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.backView);
        make.height.mas_equalTo(CGFloatIn750(182));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(18));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(24));
        make.width.height.mas_equalTo(CGFloatIn750(36));
    }];
    
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.headImageView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(22));
    }];
    
    [self.likeImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.headImageView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(22));
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(CGFloatIn750(10));
        make.centerY.equalTo(self.headImageView.mas_centerY);
        make.right.equalTo(self.likeImageView.mas_left).offset(-CGFloatIn750(16));
    }];
    
    [self.userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_left);
        make.top.equalTo(self.headImageView.mas_top).offset(-CGFloatIn750(10));
        make.bottom.equalTo(self.contView.mas_bottom);
        make.right.equalTo(self.userLabel.mas_right);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeImageView.mas_left).offset(-CGFloatIn750(8));
        make.bottom.equalTo(self.contView.mas_bottom);
        make.right.equalTo(self.contView.mas_right);
        make.top.equalTo(self.likeImageView.mas_top).offset(-CGFloatIn750(10));
    }];
    
    self.likeImageView.hidden = YES;
}

#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatIn750(16);
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _backView;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
    }
    return _contView;
}

- (UIView *)addressBackView {
    if (!_addressBackView) {
        _addressBackView = [[UIView alloc] init];
        _addressBackView.layer.masksToBounds = YES;
        ViewRadius(_addressBackView, CGFloatIn750(16));
        _addressBackView.backgroundColor = HexAColor(0x000000, 0.41);
    }
    return _addressBackView;
}

- (UILabel *)userLabel {
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _userLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _userLabel.numberOfLines = 1;
        _userLabel.textAlignment = NSTextAlignmentLeft;
        [_userLabel setFont:[UIFont fontSmall]];
        [_userLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _userLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont fontMin]];
    }
    return _addressLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _distanceLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _distanceLabel.numberOfLines = 1;
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        [_distanceLabel setFont:[UIFont fontMin]];
    }
    return _distanceLabel;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        ViewRadius(_headImageView, CGFloatIn750(18));
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_headImageView tt_setImageWithURL:[NSURL URLWithString:[ZUserHelper sharedHelper].user.avatar] placeholderImage:[UIImage imageNamed:@"default_head"]];
    }
    return _headImageView;
}


- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}


- (UIImageView *)playerImageView {
    if (!_playerImageView) {
        _playerImageView = [[UIImageView alloc] init];
        _playerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _playerImageView.image = [UIImage imageNamed:@"finderPlayer"];
        _playerImageView.clipsToBounds = YES;
    }
    return _playerImageView;
}


- (JHLikeButton *)likeImageBtn {
    if (!_likeImageBtn) {
        _likeImageBtn = [[JHLikeButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(22), CGFloatIn750(22))];
        _likeImageBtn.color = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _likeImageBtn.enabled = NO;
        _likeImageBtn.likeColor = [UIColor colorRedForButton];
        _likeImageBtn.type = JHLikeButtonType_Heart;
        [_likeImageBtn prepare];
        _likeImageBtn.clickBlock = ^(BOOL like) {
            
        };
    }
    return _likeImageBtn;
}

- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _likeImageView;
}


- (UIImageView *)addressImageView {
    if (!_addressImageView) {
        _addressImageView = [[UIImageView alloc] init];
        _addressImageView.contentMode = UIViewContentModeScaleAspectFill;
        _addressImageView.image = [UIImage imageNamed:@"finerLocation"];
    }
    return _addressImageView;
}

- (UIButton *)coverBtn {
    if (!_coverBtn) {
        _coverBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_coverBtn bk_addEventHandler:^(id sender) {
            if (self.handleBlock) {
                self.handleBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverBtn;
}


- (UIButton *)userBtn {
    if (!_userBtn) {
        _userBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_userBtn bk_addEventHandler:^(id sender) {
            if (self.handleBlock) {
                self.handleBlock(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _userBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_likeBtn bk_addEventHandler:^(id sender) {
            if (self.handleBlock) {
                self.handleBlock(2);
            }
            self.isLike = !self.isLike;
            [self.likeImageBtn setLike:self.isLike animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

#pragma mark - setdata
- (void)setModel:(ZCircleMineDynamicModel *)model {
    _model = model;
    
    [_coverImageView tt_setImageWithURL:[NSURL URLWithString:model.cover.url]];
    _nameLabel.text = model.title;
    _userLabel.text = model.nick_name;
    [ZPublicTool setLineSpacing:CGFloatIn750(8) label:_nameLabel];
    
    CGSize temp = [model.title tt_sizeWithFont:[UIFont boldFontContent] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(60 + 20 + 60))/2.0, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(8)];
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.backView);
        make.height.mas_equalTo(CGFloatIn750(100)+temp.height);
    }];
    
    self.addressLabel.text = model.address;
    self.distanceLabel.text = model.show_distance;
    CGSize distanceTemp = [model.show_distance tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(60 + 20 + 60))/2.0, MAXFLOAT)];
    
    CGSize addressTemp = [model.address tt_sizeWithFont:[UIFont fontMin] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(60 + 20 + 60))/2.0-CGFloatIn750(36)-distanceTemp.width - CGFloatIn750(14)-CGFloatIn750(20), MAXFLOAT)];
    
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImageView.mas_right).offset(CGFloatIn750(8));
        make.centerY.equalTo(self.addressImageView.mas_centerY);
        make.width.mas_equalTo(addressTemp.width);
    }];
    
    [self.distanceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(CGFloatIn750(14));
        make.centerY.equalTo(self.addressImageView.mas_centerY);
        make.width.mas_equalTo(distanceTemp.width);
    }];
    
    if (ValidStr(_model.address)) {
        _addressLabel.hidden = NO;
        _distanceLabel.hidden = NO;
        _addressImageView.hidden = NO;
        _addressBackView.hidden = NO;
    }else{
        _addressLabel.hidden = YES;
        _distanceLabel.hidden = YES;
        _addressImageView.hidden = YES;
        _addressBackView.hidden = YES;
    }
    
    if ([_model.enjoy intValue] > 0) {
        self.isLike = YES;
    }else{
        self.isLike = NO;
    }
    [self.likeImageBtn setLike:self.isLike animated:NO];
    
    if ([_model.has_video intValue] > 0) {
        self.playerImageView.hidden = NO;
    }else{
        self.playerImageView.hidden = YES;
    }
}

+(CGSize)z_getCellSize:(id)sender {
    ZCircleMineDynamicModel *model = sender;
    CGSize temp = [model.title tt_sizeWithFont:[UIFont boldFontContent] constrainedToSize:CGSizeMake((KScreenWidth - CGFloatIn750(60 + 40))/2.0, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping lineSpace:CGFloatIn750(8)];
    
    CGFloat width = (KScreenWidth - CGFloatIn750(30) - CGFloatIn750(22))/2.0f;
    return CGSizeMake(width-0.5, width * ([model.cover.height floatValue]/[model.cover.width floatValue]) + CGFloatIn750(80) + CGFloatIn750(20) + temp.height);
}
@end
