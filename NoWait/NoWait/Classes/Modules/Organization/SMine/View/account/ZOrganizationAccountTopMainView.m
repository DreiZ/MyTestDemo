//
//  ZOrganizationAccountTopMainView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAccountTopMainView.h"

@interface ZOrganizationAccountTopMainView ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *schoolView;

@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *midLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,strong) UILabel *leftHintLabel;
@property (nonatomic,strong) UILabel *midHintLabel;
@property (nonatomic,strong) UILabel *rightHintLabel;
@end

@implementation ZOrganizationAccountTopMainView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-30));
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(110));
    }];
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contView);
        make.top.equalTo(topView.mas_bottom);
    }];
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [topView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom);
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(topView.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(0.5);
    }];
    
    [topView addSubview:self.nameLabel];
    [bottomView addSubview:self.numLabel];
    [bottomView addSubview:self.detailLabel];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
        make.top.bottom.equalTo(topView);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.top.equalTo(bottomView.mas_top).offset(CGFloatIn750(54));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.top.equalTo(self.numLabel.mas_bottom).offset(CGFloatIn750(12));
    }];
    
    [bottomView addSubview:self.schoolView];
    [self.schoolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bottomView);
        make.height.mas_equalTo(CGFloatIn750(142));
    }];
    
    [self.schoolView addSubview:self.leftLabel];
    [self.schoolView addSubview:self.leftHintLabel];
    [self.schoolView addSubview:self.midLabel];
    [self.schoolView addSubview:self.midHintLabel];
    [self.schoolView addSubview:self.rightLabel];
    [self.schoolView addSubview:self.rightHintLabel];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.schoolView.mas_left);
        make.bottom.equalTo(self.schoolView.mas_centerY).offset(CGFloatIn750(-8));
        make.width.mas_equalTo(self.schoolView.mas_width).multipliedBy(1/3.0f);
    }];
    
    [self.leftHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.schoolView.mas_left);
        make.top.equalTo(self.schoolView.mas_centerY).offset(CGFloatIn750(8));
        make.width.mas_equalTo(self.schoolView.mas_width).multipliedBy(1/3.0f);
    }];
    
    [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_right);
        make.bottom.equalTo(self.schoolView.mas_centerY).offset(CGFloatIn750(-8));
        make.width.mas_equalTo(self.schoolView.mas_width).multipliedBy(1/3.0f);
    }];
    
    [self.midHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midLabel.mas_left);
        make.top.equalTo(self.schoolView.mas_centerY).offset(CGFloatIn750(8));
        make.width.mas_equalTo(self.schoolView.mas_width).multipliedBy(1/3.0f);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midLabel.mas_right);
        make.bottom.equalTo(self.schoolView.mas_centerY).offset(CGFloatIn750(-8));
        make.width.mas_equalTo(self.schoolView.mas_width).multipliedBy(1/3.0f);
    }];
    
    [self.rightHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightLabel.mas_left);
        make.top.equalTo(self.schoolView.mas_centerY).offset(CGFloatIn750(8));
        make.width.mas_equalTo(self.schoolView.mas_width).multipliedBy(1/3.0f);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(20));
    }
    return _contView;
}


- (UIView *)schoolView {
    if (!_schoolView) {
        _schoolView = [[UIView alloc] init];
        _schoolView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _schoolView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _nameLabel.text = @"账户信息：xxxxxx";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMain]);
        _numLabel.text = @"￥2309450239";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [_numLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(56)]];
    }
    return _numLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _detailLabel.text = @"签到详情";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontSmall]];
    }
    return _detailLabel;
}


- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _leftLabel.text = @"￥34543";
        _leftLabel.numberOfLines = 1;
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        [_leftLabel setFont:[UIFont fontContent]];
    }
    return _leftLabel;
}

- (UILabel *)midLabel {
    if (!_midLabel) {
        _midLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _midLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _midLabel.text = @"￥34543";
        _midLabel.numberOfLines = 1;
        _midLabel.textAlignment = NSTextAlignmentCenter;
        [_midLabel setFont:[UIFont fontContent]];
    }
    return _midLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _rightLabel.text = @"￥34543";
        _rightLabel.numberOfLines = 1;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        [_rightLabel setFont:[UIFont fontContent]];
    }
    return _rightLabel;
}




- (UILabel *)leftHintLabel {
    if (!_leftHintLabel) {
        _leftHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftHintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _leftHintLabel.text = @"已打款";
        _leftHintLabel.numberOfLines = 1;
        _leftHintLabel.textAlignment = NSTextAlignmentCenter;
        [_leftHintLabel setFont:[UIFont fontSmall]];
    }
    return _leftHintLabel;
}

- (UILabel *)midHintLabel {
    if (!_midHintLabel) {
        _midHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _midHintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _midHintLabel.text = @"未打款";
        _midHintLabel.numberOfLines = 1;
        _midHintLabel.textAlignment = NSTextAlignmentCenter;
        [_midHintLabel setFont:[UIFont fontSmall]];
    }
    return _midHintLabel;
}

- (UILabel *)rightHintLabel {
    if (!_rightHintLabel) {
        _rightHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightHintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _rightHintLabel.text = @"打款中";
        _rightHintLabel.numberOfLines = 1;
        _rightHintLabel.textAlignment = NSTextAlignmentCenter;
        [_rightHintLabel setFont:[UIFont fontSmall]];
    }
    return _rightHintLabel;
}

- (void)setIsSchool:(BOOL)isSchool {
    self.schoolView.hidden = !isSchool;
}
@end

