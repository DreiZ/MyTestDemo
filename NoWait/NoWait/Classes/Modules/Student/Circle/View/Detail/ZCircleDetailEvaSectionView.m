//
//  ZCircleDetailEvaSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailEvaSectionView.h"

@interface ZCircleDetailEvaSectionView ()
@property (nonatomic,strong) UIButton *evaBtn;
@property (nonatomic,strong) UIButton *likeBtn;
@end

@implementation ZCircleDetailEvaSectionView

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
    
    [self addSubview:self.likeBtn];
    [self addSubview:self.evaBtn];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(10));
        make.width.mas_equalTo(CGFloatIn750(114));
    }];
    
    [self.evaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.likeBtn.mas_right).offset(20);
        make.width.mas_equalTo(CGFloatIn750(114));
    }];
    
    [self setIsLike:NO];
}

- (UIButton *)evaBtn {
    if (!_evaBtn) {
        __weak typeof(self) weakSelf = self;
        _evaBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_evaBtn setTitle:@"回复0" forState:UIControlStateNormal];
        [_evaBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [_evaBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_evaBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        __weak typeof(self) weakSelf = self;
        _likeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_likeBtn setTitle:@"喜欢0" forState:UIControlStateNormal];
        [_likeBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_likeBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [_likeBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

- (void)setLikeNum:(NSString *)like evaNum:(NSString *)eva {
    if (like) {
        [_likeBtn setTitle:[NSString stringWithFormat:@"喜欢%@",like] forState:UIControlStateNormal];
    }
    
    if (eva) {
        [_evaBtn setTitle:[NSString stringWithFormat:@"回复%@",like] forState:UIControlStateNormal];
    }
}

- (void)setIsLike:(BOOL)isLike {
    _isLike = isLike;
    if (isLike) {
        [_likeBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [_evaBtn.titleLabel setFont:[UIFont fontSmall]];
    }else{
        [_likeBtn.titleLabel setFont:[UIFont fontSmall]];
        [_evaBtn.titleLabel setFont:[UIFont boldFontSmall]];
    }
}

@end
