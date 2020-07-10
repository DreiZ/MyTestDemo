//
//  ZCircleMineSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMineSectionView.h"

@interface ZCircleMineSectionView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *followBtn;
@property (nonatomic,strong) UIButton *dynamicBtn;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation ZCircleMineSectionView

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
    [self.contView addSubview:self.dynamicBtn];
    [self.contView addSubview:self.followBtn];
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(1);
    }];
    
    [self.contView addSubview:self.lineView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [self.dynamicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(68));
        make.width.mas_equalTo(CGFloatIn750(118));
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dynamicBtn.mas_right).offset(CGFloatIn750(10));
        make.height.mas_equalTo(CGFloatIn750(68));
        make.width.mas_equalTo(CGFloatIn750(118));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(6));
        make.width.mas_equalTo(CGFloatIn750(30));
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.dynamicBtn.mas_centerX);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.layer.masksToBounds = YES;
        _lineView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
    }
    return _lineView;
}

- (UIButton *)followBtn {
    if (!_followBtn) {
        __weak typeof(self) weakSelf = self;
        _followBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_followBtn setTitle:@"喜欢" forState:UIControlStateNormal];
        [_followBtn.titleLabel setFont:[UIFont fontSmall]];
        [_followBtn setTitleColor:[UIColor colorTextBlack] forState:UIControlStateNormal];
        [_followBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
            self.isLike = YES;
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}

- (UIButton *)dynamicBtn {
    if (!_dynamicBtn) {
        __weak typeof(self) weakSelf = self;
        _dynamicBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_dynamicBtn setTitle:@"动态" forState:UIControlStateNormal];
        [_dynamicBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [_dynamicBtn setTitleColor:[UIColor colorTextBlack] forState:UIControlStateNormal];
        [_dynamicBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
            self.isLike = NO;
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _dynamicBtn;
}

- (void)setIsLike:(BOOL)isLike {
    _isLike = isLike;
    if (isLike) {
        [_dynamicBtn.titleLabel setFont:[UIFont fontSmall]];
        [_followBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(6));
            make.width.mas_equalTo(CGFloatIn750(30));
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.followBtn.mas_centerX);
        }];
    }else{
        [_dynamicBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [_followBtn.titleLabel setFont:[UIFont fontSmall]];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(6));
            make.width.mas_equalTo(CGFloatIn750(30));
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.dynamicBtn.mas_centerX);
        }];
    }
}

- (void)setDynamic:(NSString *)dynamic like:(NSString *)like {
    
    if (ValidStr(dynamic)) {
        [_dynamicBtn setTitle:[NSString stringWithFormat:@"%@%@",@"动态",dynamic] forState:UIControlStateNormal];
    }
    
    if (ValidStr(like)) {
        [_followBtn setTitle:[NSString stringWithFormat:@"%@%@",@"喜欢",like] forState:UIControlStateNormal];
    }
}
@end
