//
//  ZCircleHotLessonListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleHotLessonListItemCell.h"

@interface ZCircleHotLessonListItemCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *orignLabel;
@property (nonatomic,strong) UIView *orignLineView;

@property (nonatomic,strong) UIImageView *lessonImageView;

@end

@implementation ZCircleHotLessonListItemCell

- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.lessonImageView];
    [self.backView addSubview:self.priceLabel];
    [self.backView addSubview:self.orignLabel];
    [self.backView addSubview:self.orignLineView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.lessonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(132));
        make.width.mas_equalTo(CGFloatIn750(210));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.backView.mas_centerX);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(20));
        make.top.equalTo(self.lessonImageView.mas_bottom).offset(CGFloatIn750(18));
        make.height.mas_lessThanOrEqualTo(CGFloatIn750(70));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-CGFloatIn750(18));
    }];
    
    [self.orignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(4));
        make.bottom.equalTo(self.backView.mas_bottom).offset(-CGFloatIn750(18));
    }];
    
    [self.orignLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orignLabel);
        make.centerY.equalTo(self.orignLabel.mas_centerY);
        make.height.mas_equalTo(1);
    }];
    
    self.nameLabel.text = @"水果可那是肯定给你";
    self.priceLabel.text = @"￥123";
    self.orignLabel.text = @"￥223";
}


#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _backView.layer.cornerRadius = CGFloatIn750(16);
    }
    return _backView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (UIImageView *)lessonImageView {
    if (!_lessonImageView) {
        _lessonImageView = [[UIImageView alloc] init];
        _lessonImageView.layer.masksToBounds = YES;
        _lessonImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_lessonImageView, CGFloatIn750(8));
        
        NSArray *temp = @[@"http://wx2.sinaimg.cn/mw600/0076BSS5ly1ggdtzaw1o9j31920u012l.jpg",
            @"http://wx4.sinaimg.cn/mw600/0085KTY1gy1ggdszf1e9dj30cs0h10tm.jpg",
            @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1ggdv58xbztj30jg0t60y9.jpg",
            @"http://wx2.sinaimg.cn/mw600/0076BSS5ly1ggdrr9ulh7j30jg0t64fe.jpg",
        @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1ggdrlahu23j30u019vass.jpg",
        @"http://wx4.sinaimg.cn/mw600/0076BSS5ly1ggdrex90apj30hs0haajt.jpg",
        @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1ggdr4fqy6ij316m0u0hdt.jpg",
        @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggdq7o5303j30jg0t6acu.jpg",
        @"http://wx3.sinaimg.cn/mw600/0076BSS5ly1ggdwri1jkgj30oh10m4n5.jpg",
        @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggdwhfjcncj31900u0wud.jpg",
        @"http://ww1.sinaimg.cn/mw600/9f0b0dd5ly1ggdvmg3xd4j20mj0s6tbo.jpg",
        @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggdvf7wgwbj30xc0m9tfh.jpg",
        @"http://wx1.sinaimg.cn/mw600/0076BSS5ly1ggdv9khjdvj30u018zwl6.jpg"];

        [_lessonImageView tt_setImageWithURL:[NSURL URLWithString:temp[arc4random() %( temp.count - 1)]]];
    }
    return _lessonImageView;
}


- (UIView *)orignLineView {
    if (!_orignLineView) {
        _orignLineView = [[UIView alloc] init];
        _orignLineView.layer.masksToBounds = YES;
        _orignLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGray]);
    }
    return _orignLineView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor colorOrangeHot];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont fontMin]];
    }
    return _priceLabel;
}


- (UILabel *)orignLabel {
    if (!_orignLabel) {
        _orignLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orignLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _orignLabel.numberOfLines = 1;
        _orignLabel.textAlignment = NSTextAlignmentLeft;
        [_orignLabel setFont:[UIFont fontMin]];
    }
    return _orignLabel;
}


+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(CGFloatIn750(250), CGFloatIn750(286));
}
@end



