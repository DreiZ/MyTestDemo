//
//  ZMineMenuItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineMenuItemCell.h"

@implementation ZMineMenuItemCell

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
    
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.height.mas_equalTo(CGFloatIn750(62));
        make.bottom.equalTo(self.contentView.mas_centerY).offset(CGFloatIn750(7));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.top.equalTo(self.imageView.mas_bottom).offset(CGFloatIn750(18));
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.text = @"hahaha";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontSmall]];
    }
    return _titleLabel;
}

@end
