//
//  ZOrganizationDetailBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationDetailBottomView.h"

@interface ZOrganizationDetailBottomView ()
@property (nonatomic,strong) UIButton *telBtn;
@property (nonatomic,strong) UIButton *handleBtn;

@end

@implementation ZOrganizationDetailBottomView


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
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-safeAreaBottom());
    }];
    
    [backView addSubview:self.telBtn];
    [backView addSubview:self.handleBtn];
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(backView);
        make.width.mas_equalTo(CGFloatIn750(128));
    }];
    
    [self.handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(backView);
        make.left.equalTo(self.telBtn.mas_right);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIButton *)handleBtn {
    if (!_handleBtn) {
        _handleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _handleBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_handleBtn setTitle:@"预约体验" forState:UIControlStateNormal];
        [_handleBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_handleBtn.titleLabel setFont:[UIFont boldFontContent]];
        
        __weak typeof(self) weakSelf = self;
        [_handleBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
        }];
    }
    return _handleBtn;
}


- (UIButton *)telBtn {
    if (!_telBtn) {
        _telBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_telBtn setImage:[UIImage imageNamed:@"default_bigPhone_mainColor"] forState:UIControlStateNormal];
        [_telBtn.titleLabel setFont:[UIFont fontSmall]];
        
        __weak typeof(self) weakSelf = self;
        [_telBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        }];
    }
    return _telBtn;
}

- (void)setTitle:(NSString *)title {
    [_handleBtn setTitle:title forState:UIControlStateNormal];
}
@end
