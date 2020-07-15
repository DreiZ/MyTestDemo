//
//  ZCircleMineDynamicCollectionCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineDynamicCollectionCell.h"

@interface ZCircleMineDynamicCollectionCell ()
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UILabel *seeLabel;
@property (nonatomic,strong) UILabel *likeLabel;

@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UIImageView *numImageVIew;
@property (nonatomic,strong) UIImageView *playerImageView;
@property (nonatomic,strong) UIImageView *seeImageView;
@property (nonatomic,strong) UIImageView *likeImageView;
@end

@implementation ZCircleMineDynamicCollectionCell


- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.contentView.clipsToBounds = YES;
    
    [self.contentView addSubview:self.contView];
    [self.contView addSubview:self.coverImageView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.coverImageView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.coverImageView);
        make.height.mas_equalTo(CGFloatIn750(54));
    }];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)HexAColor(0x000000, 0.01).CGColor, (__bridge id)HexAColor(0x000000, 0.4).CGColor, (__bridge id)HexAColor(0x000000, 0.8).CGColor];
    gradientLayer.locations = @[@0.1, @0.4, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, KScreenWidth - CGFloatIn750(60), CGFloatIn750(54));
    [bottomLineView.layer insertSublayer:gradientLayer atIndex:0];
    
    [self.contView addSubview:self.likeLabel];
    [self.contView addSubview:self.seeLabel];
    [self.contView addSubview:self.numImageVIew];
    [self.contView addSubview:self.playerImageView];
    [self.contView addSubview:self.likeImageView];
    [self.contView addSubview:self.seeImageView];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.contView);
    }];
    
    [self.numImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(22));
        make.top.equalTo(self.coverImageView.mas_top).offset(CGFloatIn750(16));
        make.right.equalTo(self.coverImageView.mas_right).offset(-CGFloatIn750(16));
    }];
    
    [self.seeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(18));
        make.centerY.equalTo(bottomLineView.mas_centerY);
        make.left.equalTo(self.coverImageView.mas_left).offset(CGFloatIn750(16));
    }];
    
    [self.seeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seeImageView.mas_right).offset(CGFloatIn750(4));
        make.centerY.equalTo(self.seeImageView.mas_centerY);
    }];
    
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.coverImageView.mas_right).offset(-CGFloatIn750(16));
        make.centerY.equalTo(self.seeImageView.mas_centerY);
    }];
    
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(18));
        make.centerY.equalTo(self.seeImageView.mas_centerY);
        make.right.equalTo(self.likeLabel.mas_left).offset(-CGFloatIn750(4));
    }];
    
    [self.playerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.coverImageView.mas_centerX);
        make.centerY.equalTo(self.coverImageView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(60));
    }];
}

#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
    }
    return _contView;
}


- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _likeLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _likeLabel.numberOfLines = 1;
        _likeLabel.textAlignment = NSTextAlignmentLeft;
        [_likeLabel setFont:[UIFont fontMin]];
    }
    return _likeLabel;
}

- (UILabel *)seeLabel {
    if (!_seeLabel) {
        _seeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _seeLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _seeLabel.numberOfLines = 0;
        _seeLabel.textAlignment = NSTextAlignmentLeft;
        [_seeLabel setFont:[UIFont fontMin]];
    }
    return _seeLabel;
}

- (UIImageView *)numImageVIew {
    if (!_numImageVIew) {
        _numImageVIew = [[UIImageView alloc] init];
        _numImageVIew.contentMode = UIViewContentModeScaleAspectFill;
        _numImageVIew.image = [UIImage imageNamed:@"finderPhotos"];
    }
    return _numImageVIew;
}


- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.backgroundColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        ViewRadius(_coverImageView, CGFloatIn750(8));
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


- (UIImageView *)seeImageView {
    if (!_seeImageView) {
        _seeImageView = [[UIImageView alloc] init];
        _seeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _seeImageView.image = [UIImage imageNamed:@"finderSeeNum"];
        _seeImageView.clipsToBounds = YES;
    }
    return _seeImageView;
}


- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _likeImageView.image = [UIImage imageNamed:@"finderLikeNum"];
    }
    return _likeImageView;
}

#pragma mark - setdata
- (void)setModel:(ZCircleMineDynamicModel *)model {
    _model = model;
    
    
    _seeLabel.text = model.browse;
    _likeLabel.text = model.enjoy;
    
    if ([model.has_video intValue] == 0) {
        self.playerImageView.hidden = YES;
    }else{
        self.playerImageView.hidden = NO;
    }
    
    if ([model.is_many_image intValue] == 0) {
        self.numImageVIew.hidden = YES;
    }else{
        self.numImageVIew.hidden = NO;
    }
    
    if (isVideo(model.cover.url)) {
        self.coverImageView.image = [[ZVideoPlayerManager sharedInstance] thumbnailImageForVideo:[NSURL URLWithString:model.cover.url] atTime:0];
    }else{
        [self.coverImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.cover.url)]];
    }
//    [_coverImageView tt_setImageWithURL:[NSURL URLWithString:model.cover.url]];
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake((KScreenWidth - CGFloatIn750(148) - CGFloatIn750(36))/2.0f, ((KScreenWidth - CGFloatIn750(148) - CGFloatIn750(36))/2.0f)*(160.0f)/(142.0));
}
@end

