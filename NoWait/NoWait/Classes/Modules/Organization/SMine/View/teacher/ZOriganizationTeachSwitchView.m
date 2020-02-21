//
//  ZOriganizationTeachSwitchView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationTeachSwitchView.h"

@interface ZOriganizationTeachSwitchView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *switchBtn;

@end

@implementation ZOriganizationTeachSwitchView

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
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(106));
    }];
    
    [self.contView addSubview:self.titleLabel];
    [self.contView addSubview:self.switchBtn];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(40));
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right);
        make.top.bottom.equalTo(self.contView);
        make.width.mas_equalTo(CGFloatIn750(200));
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _titleLabel.text = @"图形俱乐部";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}



- (UIButton *)switchBtn {
    if (!_switchBtn) {
        __weak typeof(self) weakSelf = self;
        _switchBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_switchBtn setTitle:@"切换账户" forState:UIControlStateNormal];
        [_switchBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_switchBtn.titleLabel setFont:[UIFont fontSmall]];
        UIImage *image = [[UIImage imageNamed:@"switchUser"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_switchBtn.imageView setTintColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark])];
        [_switchBtn setImage:image forState:UIControlStateNormal];
        
        [_switchBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        }];
    }
    return _switchBtn;
}
@end
