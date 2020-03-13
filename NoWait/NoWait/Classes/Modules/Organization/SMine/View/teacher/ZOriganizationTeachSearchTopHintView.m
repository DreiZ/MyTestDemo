//
//  ZOriganizationTeachSearchTopHintView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTeachSearchTopHintView.h"

@interface ZOriganizationTeachSearchTopHintView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *searchBtn;

@end

@implementation ZOriganizationTeachSearchTopHintView

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
    
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(116));
    }];
    
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(-20));
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
}

#pragma mark -lazy loading
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewRadius(_contView, CGFloatIn750(16));
    }
    return _contView;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_searchBtn setTitle:@"搜索教师" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_searchBtn.titleLabel setFont:[UIFont fontSmall]];
        UIImage *image = [[UIImage imageNamed:@"mainSearch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_searchBtn.imageView setTintColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        [_searchBtn setImage:image forState:UIControlStateNormal];
        _searchBtn.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(_searchBtn, CGFloatIn750(28));
        [_searchBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        }];
    }
    return _searchBtn;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}

- (void)setHint:(NSString *)hint {
    _hint = hint;
    [_searchBtn setTitle:hint forState:UIControlStateNormal];
}
@end

