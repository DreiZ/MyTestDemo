//
//  ZMessageTypeEntryItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessageTypeEntryItemCell.h"

@interface ZMessageTypeEntryItemCell ()
@property (nonatomic,strong) UIImageView *detailImageView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIView *hintView;
@end

@implementation ZMessageTypeEntryItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    self.clipsToBounds = YES;
    
    [self.contentView addSubview:self.hintView];
    [self.hintView addSubview:self.detailImageView];
    [self.hintView addSubview:self.nameLabel];
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(self.hintView.mas_height);
    }];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hintView.mas_centerX);
        make.top.equalTo(self.hintView.mas_top).offset(CGFloatIn750(20));
        make.width.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hintView.mas_centerX);
        make.left.right.equalTo(self.hintView);
        make.top.equalTo(self.detailImageView.mas_bottom).offset(CGFloatIn750(18));
    }];
    
    UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [itemBtn bk_addEventHandler:^(id sender) {
        if (self.handleBlock) {
            self.handleBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:itemBtn];
    
    [itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailImageView.mas_left).offset(-CGFloatIn750(20));
        make.right.equalTo(self.detailImageView.mas_right).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.hintView.mas_centerX);
        make.top.bottom.equalTo(self.hintView);
    }];
}


- (UIImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[UIImageView alloc] init];
        _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _detailImageView;
}


- (UIView *)hintView {
    if (!_hintView) {
        _hintView = [[UIView alloc] init];
        _hintView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    }
    return _hintView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (void)setModel:(ZMessageTypeEntryModel *)model {
    _model = model;
    _nameLabel.text = model.name;
    _detailImageView.image = [UIImage imageNamed:model.image];
}

+ (CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(CGFloatIn750(213), CGFloatIn750(214));
}
@end

