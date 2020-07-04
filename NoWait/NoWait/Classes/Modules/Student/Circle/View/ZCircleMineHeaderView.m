//
//  ZCircleMineHeaderView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineHeaderView.h"
#import "TZImageCropManager.h"

@interface ZCircleMineHeaderView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *followBtn;
@property (nonatomic,strong) UIButton *fansBtn;
@property (nonatomic,strong) UIButton *dynamicBtn;
@property (nonatomic,strong) UIButton *signatureBtn;
@property (nonatomic,strong) UIButton *getFollowBtn;

@property (nonatomic,strong) YYLabel *signatureLabel;

@property (nonatomic,strong) UILabel *followLabel;
@property (nonatomic,strong) UILabel *fansLabel;
@property (nonatomic,strong) UILabel *followHintLabel;
@property (nonatomic,strong) UILabel *fansHintLabel;

@property (nonatomic,strong) UILabel *dynamicLabel;
@property (nonatomic,strong) UILabel *dynamicHintLabel;

@property (nonatomic,strong) UIImageView *headImageView;
@end

@implementation ZCircleMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    [self addSubview:self.contView];
    
    [self.contView addSubview:self.headImageView];
    [self addSubview:self.signatureLabel];
    [self.contView addSubview:self.fansLabel];
    [self.contView addSubview:self.followLabel];
    [self.contView addSubview:self.fansHintLabel];
    [self.contView addSubview:self.followHintLabel];
    [self.contView addSubview:self.dynamicLabel];
    [self.contView addSubview:self.dynamicHintLabel];
    [self.contView addSubview:self.getFollowBtn];
    
    [self.contView addSubview:self.followBtn];
    [self.contView addSubview:self.fansBtn];
    [self.contView addSubview:self.dynamicBtn];
    [self.contView addSubview:self.signatureBtn];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(218));
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(168));
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(40));
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
    
    [self.contView addSubview:self.getFollowBtn];
    [self.getFollowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(58));
        make.width.mas_equalTo(CGFloatIn750(460));
        make.bottom.equalTo(self.headImageView.mas_bottom);
    }];
    
    
    [self.fansHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(60));
        make.bottom.equalTo(self.getFollowBtn.mas_top).offset(-CGFloatIn750(28));
    }];
    
    [self.followHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.fansHintLabel.mas_left).offset(-CGFloatIn750(118));
        make.centerY.equalTo(self.fansHintLabel.mas_centerY);
    }];
    
    [self.dynamicHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.followHintLabel.mas_left).offset(-CGFloatIn750(118));
        make.centerY.equalTo(self.fansHintLabel.mas_centerY);
    }];
    
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fansHintLabel.mas_centerX);
        make.bottom.equalTo(self.fansHintLabel.mas_top).offset(-CGFloatIn750(6));
    }];
    
    [self.followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.followHintLabel.mas_centerX);
        make.centerY.equalTo(self.fansLabel.mas_centerY);
    }];
    
    [self.dynamicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dynamicHintLabel.mas_centerX);
        make.centerY.equalTo(self.fansLabel.mas_centerY);
    }];
    
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView.mas_bottom).offset(CGFloatIn750(30));
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(40));
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.followLabel.mas_right).offset(CGFloatIn750(20));
        make.left.equalTo(self.followLabel.mas_left).offset(-CGFloatIn750(20));
        make.top.equalTo(self.followLabel.mas_top).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.followHintLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [self.fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.fansHintLabel.mas_right).offset(CGFloatIn750(20));
        make.left.equalTo(self.fansHintLabel.mas_left).offset(-CGFloatIn750(20));
        make.top.equalTo(self.fansLabel.mas_top).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.fansHintLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [self.dynamicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dynamicHintLabel.mas_right).offset(CGFloatIn750(20));
        make.left.equalTo(self.dynamicHintLabel.mas_left).offset(-CGFloatIn750(20));
        make.top.equalTo(self.dynamicLabel.mas_top).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.dynamicHintLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [self.signatureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.signatureLabel.mas_right).offset(CGFloatIn750(10));
        make.left.equalTo(self.signatureLabel.mas_left).offset(-CGFloatIn750(10));
        make.top.equalTo(self.signatureLabel.mas_top).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.signatureLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [self updateData];
}

#pragma mark -lazy loading
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(16));
    }
    return _contView;
}

- (UIButton *)followBtn {
    if (!_followBtn) {
        __weak typeof(self) weakSelf = self;
        _followBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_followBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}

- (UIButton *)fansBtn {
    if (!_fansBtn) {
        __weak typeof(self) weakSelf = self;
        _fansBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_fansBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _fansBtn;
}

- (UIButton *)dynamicBtn {
    if (!_dynamicBtn) {
        __weak typeof(self) weakSelf = self;
        _dynamicBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_dynamicBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _dynamicBtn;
}


- (UIButton *)signatureBtn {
    if (!_signatureBtn) {
        __weak typeof(self) weakSelf = self;
        _signatureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_signatureBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(4);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _signatureBtn;
}


- (UIButton *)getFollowBtn {
    if (!_getFollowBtn) {
        __weak typeof(self) weakSelf = self;
        _getFollowBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        ViewRadius(_getFollowBtn, CGFloatIn750(4));
        _getFollowBtn.backgroundColor = [UIColor colorMain];
        [_getFollowBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_getFollowBtn.titleLabel setFont:[UIFont fontContent]];
        [_getFollowBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_getFollowBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(5);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _getFollowBtn;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        ViewRadius(_headImageView, CGFloatIn750(84));
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (YYLabel *)signatureLabel {
    if (!_signatureLabel) {
        _signatureLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _signatureLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _signatureLabel.numberOfLines = 0;
        _signatureLabel.textAlignment = NSTextAlignmentLeft;
        [_signatureLabel setFont:[UIFont fontContent]];
    }
    return _signatureLabel;
}


- (UILabel *)fansLabel {
    if (!_fansLabel) {
        _fansLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _fansLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _fansLabel.numberOfLines = 1;
        _fansLabel.textAlignment = NSTextAlignmentCenter;
        [_fansLabel setFont:[UIFont boldFontTitle]];
    }
    return _fansLabel;
}


- (UILabel *)followLabel {
    if (!_followLabel) {
        _followLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _followLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1Dark]);
        _followLabel.numberOfLines = 1;
        _followLabel.textAlignment = NSTextAlignmentCenter;
        [_followLabel setFont:[UIFont boldFontTitle]];
    }
    return _followLabel;
}


- (UILabel *)dynamicLabel {
    if (!_dynamicLabel) {
        _dynamicLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dynamicLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1Dark]);
        _dynamicLabel.numberOfLines = 1;
        _dynamicLabel.textAlignment = NSTextAlignmentCenter;
        [_dynamicLabel setFont:[UIFont boldFontTitle]];
    }
    return _dynamicLabel;
}


- (UILabel *)fansHintLabel {
    if (!_fansHintLabel) {
        _fansHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _fansHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _fansHintLabel.text = @"粉丝";
        _fansHintLabel.numberOfLines = 1;
        _fansHintLabel.textAlignment = NSTextAlignmentCenter;
        [_fansHintLabel setFont:[UIFont fontMin]];
    }
    return _fansHintLabel;
}


- (UILabel *)followHintLabel {
    if (!_followHintLabel) {
        _followHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _followHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _followHintLabel.text = @"关注";
        _followHintLabel.numberOfLines = 1;
        _followHintLabel.textAlignment = NSTextAlignmentCenter;
        [_followHintLabel setFont:[UIFont fontMin]];
    }
    return _followHintLabel;
}


- (UILabel *)dynamicHintLabel {
    if (!_dynamicHintLabel) {
        _dynamicHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dynamicHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _dynamicHintLabel.text = @"动态";
        _dynamicHintLabel.numberOfLines = 1;
        _dynamicHintLabel.textAlignment = NSTextAlignmentCenter;
        [_dynamicHintLabel setFont:[UIFont fontMin]];
    }
    return _dynamicHintLabel;
}


- (void)updateData {
    _followLabel.text = @"120";
    _fansLabel.text = @"100";
    _dynamicLabel.text = @"8";
    
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"已阅读并同意遵守《服务条款》和《隐私协议》"];
    text.lineSpacing = 4;
    text.font = [UIFont fontContent];
    text.color = [UIColor colorWithHexString:@"999999"];
    
    YYAnimatedImageView *imageView1= [[YYAnimatedImageView alloc] initWithImage:[UIImage imageNamed:@"finderPen"]];
    imageView1.frame = CGRectMake(0, 0, CGFloatIn750(24), CGFloatIn750(24));
    NSMutableAttributedString *attachText1= [NSMutableAttributedString attachmentStringWithContent:imageView1 contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView1.frame.size alignToFont:[UIFont systemFontOfSize:CGFloatIn750(24)] alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString:attachText1];
    _signatureLabel.attributedText = text;
    
    [self.headImageView tt_setImageWithURL:[NSURL URLWithString:SafeStr([ZUserHelper sharedHelper].user.avatar)] placeholderImage:[UIImage imageNamed:@"default_head"]];
    if (ValidStr([ZUserHelper sharedHelper].user.avatar)) {
        [LKUIUtils downloadShareImage:SafeStr([ZUserHelper sharedHelper].user.avatar) complete:^(UIImage *image) {
            if (!image) {
                image = [UIImage imageNamed:@"default_head"];
            }
            image = [TZImageCropManager circularClipImage:image];
            [LKUIUtils doubleAnimaitonWithImageView:self.headImageView toImage:image duration:0.8 animations:^{
                self.headImageView.layer.cornerRadius = CGFloatIn750(36);
            } completion:^{
                
            }];
        }];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}

@end
