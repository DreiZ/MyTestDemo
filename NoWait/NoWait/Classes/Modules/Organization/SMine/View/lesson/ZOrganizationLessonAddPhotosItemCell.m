//
//  ZOrganizationLessonAddPhotosItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonAddPhotosItemCell.h"


@interface ZOrganizationLessonAddPhotosItemCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UIView *hintView;
@property (nonatomic,strong) UIImageView *hintImageView;
@property (nonatomic,strong) UIButton *deleteBtn;

@end

@implementation ZOrganizationLessonAddPhotosItemCell

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

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _deleteBtn.backgroundColor = [UIColor blackColor];
    }
    return _deleteBtn;
}

- (void)setModel:(ZBaseUnitModel *)model {
    _model = model;
    _titleLabel.text = model.name;
    [_titleLabel setFont:[UIFont fontSmall]];
    _hintView.hidden = YES;
    _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGrayDark]);
}
@end

