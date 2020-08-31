//
//  ZMapLoadErrorView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMapLoadErrorView.h"

@interface ZMapLoadErrorView ()
@property (nonatomic,strong) UIView *reloadBackView;

@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UIButton *reloadBtn;

@property (nonatomic,strong) UIView *backView;

@end

@implementation ZMapLoadErrorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.contView addSubview:self.reloadBackView];
    
    [self.reloadBackView addSubview:self.reloadBtn];
    [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contView);
        make.right.equalTo(self.reloadBackView.mas_right);
        make.top.bottom.equalTo(self.reloadBackView);
        make.width.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.contView addSubview:self.reloadBackView];
    [self.reloadBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(380));
        make.height.mas_equalTo(CGFloatIn750(60));
        make.right.equalTo(self.reloadBtn.mas_left).offset(-CGFloatIn750(10));
        make.centerY.equalTo(self.contView.mas_centerY);
    }];

    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [closeBtn bk_whenTapped:^{
//        if (weakSelf.backBlock) {
//            weakSelf.backBlock();
//        }
    }];
    [_reloadBackView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.reloadBackView);
        make.right.equalTo(self.reloadBtn.mas_left);
    }];
    
    
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorOrangeBack],[UIColor colorOrangeBack]);
    }
    return _contView;
}


- (UIView *)reloadBackView {
    if (!_reloadBackView) {
        _reloadBackView = [[UIView alloc] init];
        _reloadBackView.layer.masksToBounds = YES;
        _reloadBackView.backgroundColor = adaptAndDarkColor([UIColor colorOrangeBack],[UIColor colorOrangeBack]);
        _reloadBackView.layer.cornerRadius = CGFloatIn750(32);
    }
    return _reloadBackView;
}

- (UIButton *)reloadBtn {
    if (!_reloadBtn) {
        __weak typeof(self) weakSelf = self;
        _reloadBtn = [[UIButton alloc] init];
        _reloadBtn.clipsToBounds = YES;
        [_reloadBtn setTitle:@"" forState:UIControlStateNormal];
        [_reloadBtn setTitleColor:adaptAndDarkColor([UIColor colorOrangeHot], [UIColor colorOrangeHot]) forState:UIControlStateNormal];
        [_reloadBtn.titleLabel setFont:[UIFont fontSmall]];
        
        ViewBorderRadius(_reloadBtn, CGFloatIn750(30), 1, [UIColor colorTextBlack]);
        [_reloadBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.reloadBtn) {
                weakSelf.reloadBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}


#pragma mark - handle
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = adaptAndDarkColor([UIColor  colorMain], [UIColor colorBlackBGDark]);
        _backView.alpha = 0;
    }
    return _backView;
}

@end





