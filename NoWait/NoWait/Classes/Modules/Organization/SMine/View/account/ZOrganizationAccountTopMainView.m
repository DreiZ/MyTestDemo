//
//  ZOrganizationAccountTopMainView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAccountTopMainView.h"

@interface ZOrganizationAccountTopMainView ()

@property (nonatomic,strong) UIView *contView;
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
    
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(20));
    }
    return _contView;
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
        _numLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMainDark]);
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
        _detailLabel.text = @"机构流水";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontSmall]];
    }
    return _detailLabel;
}
@end

