//
//  ZCircleDetailBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailBottomView.h"

@interface ZCircleDetailBottomView ()
@property (nonatomic,strong) UILabel *evaLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *likeLabel;

@property (nonatomic,strong) UIImageView *evaImageView;
@property (nonatomic,strong) UIImageView *messageImageView;
@property (nonatomic,strong) UIImageView *likeImageView;

@property (nonatomic,strong) UIButton *evaBtn;
@property (nonatomic,strong) UIButton *messageBtn;
@property (nonatomic,strong) UIButton *likeBtn;

@property (nonatomic,strong) UIView *contView;
@end

@implementation ZCircleDetailBottomView

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
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.contView addSubview:self.evaImageView];
    [self.contView addSubview:self.evaLabel];
    [self.contView addSubview:self.evaBtn];
    
    [self.contView addSubview:self.messageImageView];
    [self.contView addSubview:self.messageLabel];
    [self.contView addSubview:self.messageBtn];
    
    [self.contView addSubview:self.likeImageView];
    [self.contView addSubview:self.likeLabel];
    [self.contView addSubview:self.likeBtn];
    
    [self.evaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(28));
    }];
    
    [self.evaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.evaImageView.mas_right).offset(CGFloatIn750(16));
        make.centerY.equalTo(self.evaImageView.mas_centerY);
    }];
    
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(60));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(28));
    }];
    
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeImageView.mas_right).offset(CGFloatIn750(0));
        make.top.equalTo(self.likeImageView.mas_top);
    }];
    
    
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeImageView.mas_right).offset(-CGFloatIn750(82));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(28));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageImageView.mas_right).offset(CGFloatIn750(0));
        make.top.equalTo(self.messageImageView.mas_top);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.left.equalTo(self.likeImageView.mas_left).offset(-CGFloatIn750(20));
        make.right.equalTo(self.likeImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.left.equalTo(self.messageImageView.mas_left).offset(-CGFloatIn750(20));
        make.right.equalTo(self.messageImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self.evaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.left.equalTo(self.evaImageView.mas_left).offset(-CGFloatIn750(20));
        make.right.equalTo(self.messageImageView.mas_left).offset(-CGFloatIn750(60));
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

- (UILabel *)evaLabel {
    if (!_evaLabel) {
        _evaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _evaLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _evaLabel.numberOfLines = 1;
        _evaLabel.textAlignment = NSTextAlignmentLeft;
        _evaLabel.text = @"写评论...";
        [_evaLabel setFont:[UIFont fontContent]];
    }
    return _evaLabel;
}


- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _messageLabel.numberOfLines = 1;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        [_messageLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
    }
    return _messageLabel;
}


- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _likeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _likeLabel.numberOfLines = 1;
        _likeLabel.textAlignment = NSTextAlignmentLeft;
        [_likeLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16)]];
    }
    return _likeLabel;
}


- (UIImageView *)evaImageView {
    if (!_evaImageView) {
        _evaImageView = [[UIImageView alloc] init];
        _evaImageView.image = [[UIImage imageNamed:@"finderPen"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _evaImageView.contentMode = UIViewContentModeScaleAspectFill;
        _evaImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    }
    return _evaImageView;
}


- (UIImageView *)messageImageView {
    if (!_messageImageView) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.image = [[UIImage imageNamed:@"finerReply"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _messageImageView.contentMode = UIViewContentModeScaleAspectFill;
        _messageImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    }
    return _messageImageView;
}


- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.image = [[UIImage imageNamed:@"finderLikeNo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _likeImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    }
    return _likeImageView;
}


- (UIButton *)evaBtn {
    if (!_evaBtn) {
        __weak typeof(self) weakSelf = self;
        _evaBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_evaBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaBtn;
}

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        __weak typeof(self) weakSelf = self;
        _messageBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_messageBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}


- (UIButton *)likeBtn {
    if (!_likeBtn) {
        __weak typeof(self) weakSelf = self;
        _likeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_likeBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}
@end
