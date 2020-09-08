//
//  ZMapNavView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMapNavView.h"

@interface ZMapNavView ()

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIImageView *arrImageView;
@end

@implementation ZMapNavView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:topView];
    ViewBorderRadius(topView, CGFloatIn750(30), 1, [UIColor colorTextBlack]);
    [self.contView addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contView.mas_centerY);
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.left.equalTo(self.contView.mas_left);
        make.right.equalTo(self.backImageView.mas_right).offset(CGFloatIn750(30));
    }];
    
    
    [self.contView addSubview:self.navTitleLabel];
    [self.navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contView);
    }];
    
    [self.contView addSubview:self.arrImageView];
    [self.arrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contView.mas_centerY);
        make.left.equalTo(self.navTitleLabel.mas_right).offset(CGFloatIn750(2));
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navTitleLabel.mas_left).offset(-CGFloatIn750(18));
        make.right.equalTo(self.arrImageView.mas_right).offset(CGFloatIn750(12));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(60));
    }];
    
    UIButton *allBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [allBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(1);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.contView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(topView);
        make.top.bottom.equalTo(self.contView);
    }];
}


#pragma mark - lazy loading
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}


- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [[UIImage imageNamed:@"navleftBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _backImageView.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }
    return _backImageView;
}


- (UIImageView *)arrImageView {
    if (!_arrImageView) {
        _arrImageView = [[UIImageView alloc] init];
        _arrImageView.image = [[UIImage imageNamed:@"mineLessonDown"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _arrImageView.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }
    return _arrImageView;
}

- (UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _navTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _navTitleLabel.text = @"全部";
        _navTitleLabel.numberOfLines = 1;
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_navTitleLabel setFont:[UIFont fontSmall]];
    }
    return _navTitleLabel;
}

@end


