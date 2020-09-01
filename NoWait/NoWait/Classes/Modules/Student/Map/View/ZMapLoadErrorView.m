//
//  ZMapLoadErrorView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMapLoadErrorView.h"

@interface ZMapLoadErrorView ()
@property (nonatomic,strong) UIView *contView;

@property (nonatomic,strong) UIButton *reloadBtn;
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
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    

    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.contView addSubview:self.reloadBtn];
    [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contView);
        make.left.equalTo(self.contView.mas_left);
        make.top.bottom.equalTo(self.contView);
        make.width.mas_equalTo(CGFloatIn750(320));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [closeBtn setImage:[UIImage imageNamed:@"lessonSelectClose"] forState:UIControlStateNormal];
    [closeBtn bk_whenTapped:^{
        if (weakSelf.backBlock) {
            weakSelf.backBlock();
        }
    }];
    [_contView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.width.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(self.reloadBtn.mas_right);
    }];

    
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorOrangeBack],[UIColor colorOrangeBack]);
        ViewBorderRadius(_contView, CGFloatIn750(30), 1, [UIColor colorOrangeMoment]);
    }
    return _contView;
}

- (UIButton *)reloadBtn {
    if (!_reloadBtn) {
        __weak typeof(self) weakSelf = self;
        _reloadBtn = [[UIButton alloc] init];
        _reloadBtn.clipsToBounds = YES;
        [_reloadBtn setTitle:@"暂无数据，重新定位获取数据" forState:UIControlStateNormal];
        [_reloadBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_reloadBtn.titleLabel setFont:[UIFont fontSmall]];
        [_reloadBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.reloadBtn) {
                weakSelf.reloadBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [_reloadBtn setTitle:title forState:UIControlStateNormal];
}
@end
