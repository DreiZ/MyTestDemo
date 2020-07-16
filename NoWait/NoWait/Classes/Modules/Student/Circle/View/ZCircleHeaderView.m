//
//  ZCircleHeaderView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleHeaderView.h"

@interface ZCircleHeaderView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *searchBtn;
@property (nonatomic,strong) UIButton *headerBtn;

@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UIImageView *searchImageView;

@property (nonatomic,strong) UIImageView *headImageView;
@end

@implementation ZCircleHeaderView

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
    [self addSubview:self.searchBtn];
    [self addSubview:self.headImageView];
    [self addSubview:self.headerBtn];
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
//        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
//        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-0));
//        make.height.mas_equalTo(CGFloatIn750(80));
        make.edges.equalTo(self);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(68));
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(-30));
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headImageView.mas_left).offset(CGFloatIn750(-20));
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(76));
    }];
    
    [self.searchBtn addSubview:self.searchImageView];
    [self.searchBtn addSubview:self.hintLabel];
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBtn.mas_centerY);
        make.left.equalTo(self.searchBtn.mas_left).offset(CGFloatIn750(40));
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBtn);
        make.left.equalTo(self.searchImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self.headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_left).offset(-CGFloatIn750(4));
        make.right.equalTo(self.headImageView.mas_right).offset(CGFloatIn750(4));
        make.top.equalTo(self.headImageView.mas_top).offset(-CGFloatIn750(4));
        make.bottom.equalTo(self.headImageView.mas_bottom).offset(CGFloatIn750(4));
    }];
}

#pragma mark -lazy loading
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_contView, CGFloatIn750(16));
    }
    return _contView;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _searchBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_searchBtn, CGFloatIn750(38));
        ViewShadowRadius(_searchBtn, CGFloatIn750(10), CGSizeMake(2, 2), 0.5, isDarkModel() ? [UIColor colorGrayBG] : [UIColor colorGrayBGDark]);
        [_searchBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (UIButton *)headerBtn {
    if (!_headerBtn) {
        _headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_headerBtn bk_addEventHandler:^(id sender) {
            if (self.handleBlock) {
                self.handleBlock(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerBtn;
}

- (UIImageView *)searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] init];
        UIImage *image = [[UIImage imageNamed:@"mainSearch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_searchImageView setTintColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        _searchImageView.image = image;
        _searchImageView.layer.masksToBounds = YES;
        _searchImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _searchImageView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        ViewRadius(_headImageView, CGFloatIn750(34));
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_headImageView tt_setImageWithURL:[NSURL URLWithString:[ZUserHelper sharedHelper].user.avatar] placeholderImage:[UIImage imageNamed:@"default_head"]];
    }
    return _headImageView;
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        _hintLabel.text = @"搜索课程";
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentLeft;
        [_hintLabel setFont:[UIFont fontContent]];
    }
    return _hintLabel;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}

- (void)setHint:(NSString *)hint {
    _hint = hint;
    [_searchBtn setTitle:hint forState:UIControlStateNormal];
}

- (void)updateData {
    [_headImageView tt_setImageWithURL:[NSURL URLWithString:[ZUserHelper sharedHelper].user.avatar] placeholderImage:[UIImage imageNamed:@"default_head"]];
}
@end


