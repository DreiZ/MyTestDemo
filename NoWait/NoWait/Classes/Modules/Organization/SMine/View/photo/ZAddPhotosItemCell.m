//
//  ZAddPhotosItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAddPhotosItemCell.h"

@interface ZAddPhotosItemCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UIView *hintView;
@property (nonatomic,strong) UIImageView *hintImageView;
@end

@implementation ZAddPhotosItemCell

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
    [self.hintView addSubview:self.hintImageView];
    [self.hintView addSubview:self.titleLabel];
    [self.hintView addSubview:self.subTitleLabel];
    
    [self.hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(CGFloatIn750(222));
        make.height.mas_equalTo(CGFloatIn750(148));
    }];
    
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hintView.mas_centerX);
        make.top.equalTo(self.hintView.mas_top).offset(CGFloatIn750(18));
        make.width.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hintView.mas_centerX);
        make.top.equalTo(self.hintImageView.mas_bottom).offset(CGFloatIn750(8));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.hintView.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(6));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = adaptAndDarkColor([UIColor colorWithHexString:@"bbbbbb"], [UIColor colorWithHexString:@"999999"]);
    [self.hintImageView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.hintImageView);
        make.centerY.equalTo(self.hintImageView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(4));
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = adaptAndDarkColor([UIColor colorWithHexString:@"bbbbbb"], [UIColor colorWithHexString:@"999999"]);
    [self.hintImageView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.hintImageView);
        make.centerX.equalTo(self.hintImageView.mas_centerX);
        make.width.mas_equalTo(CGFloatIn750(4));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *selectBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [selectBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handelBlock) {
            weakSelf.handelBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
        _titleLabel.text = @"添加图片";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontSmall]];
    }
    return _titleLabel;
}


- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
        _subTitleLabel.text = @"(必选)";
        _subTitleLabel.numberOfLines = 1;
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_subTitleLabel setFont:[UIFont fontSmall]];
    }
    return _subTitleLabel;
}


- (UIImageView *)hintImageView {
    if (!_hintImageView) {
        _hintImageView = [[UIImageView alloc] init];
    }
    return _hintImageView;
}

- (UIView *)hintView {
    if (!_hintView) {
        _hintView = [[UIView alloc] init];
        _hintView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_hintView, CGFloatIn750(8));
    }
    return _hintView;
}

- (void)setModel:(ZBaseMenuModel *)model {
    _model = model;
    _titleLabel.text = model.name;
    [_titleLabel setFont:[UIFont fontSmall]];
//    _hintView.hidden = YES;
    _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGrayDark]);
    _subTitleLabel.text = model.subName;
}
@end



