//
//  ZCircleDetailHeaderView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailHeaderView.h"

@interface ZCircleDetailHeaderView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation ZCircleDetailHeaderView

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
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.contView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.equalTo(self.contView);
        make.width.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.contView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.mas_right).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(140));
        make.centerY.equalTo(self.backBtn.mas_centerY);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
    }
    return _contView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldFontContent]];
    }
    return _nameLabel;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        _backBtn.clipsToBounds = YES;
        [_backBtn setImage:[[UIImage imageNamed:@"navleftBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        _backBtn.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorBlackBGDark]);
        [_backBtn bk_addEventHandler:^(id sender) {
            if (self.handleBlock) {
                self.handleBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    _nameLabel.text = title;
}
@end
