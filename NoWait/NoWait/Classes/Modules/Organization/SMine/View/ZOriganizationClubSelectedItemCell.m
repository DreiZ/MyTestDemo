//
//  ZOriganizationClubSelectedItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationClubSelectedItemCell.h"


@interface ZOriganizationClubSelectedItemCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *hintView;

@end

@implementation ZOriganizationClubSelectedItemCell

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
    

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.hintView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(0));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(CGFloatIn750(48));
        make.height.mas_equalTo(CGFloatIn750(8));
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontSmall]];
    }
    return _titleLabel;
}

- (UIView *)hintView {
    if (!_hintView) {
        _hintView = [[UIView alloc] init];
        _hintView.backgroundColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    }
    return _hintView;
}

- (void)setModel:(ZBaseUnitModel *)model {
    _model = model;
    _titleLabel.text = model.name;
    if (model.isSelected) {
        [_titleLabel setFont:[UIFont boldFontContent]];
        _hintView.hidden = NO;
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorTextBlackDark]);
    }else{
        [_titleLabel setFont:[UIFont fontSmall]];
        _hintView.hidden = YES;
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGrayDark]);
    }
}
@end
