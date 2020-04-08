//
//  ZPayAlertTypeView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZPayAlertTypeView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"

@interface ZPayAlertTypeView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *wexinimageView;
@property (nonatomic,strong) UIImageView *aliImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *weixinLabel;
@property (nonatomic,strong) UILabel *aliLabel;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

@implementation ZPayAlertTypeView

static ZPayAlertTypeView *sharedManager;

+ (ZPayAlertTypeView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZPayAlertTypeView alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.backgroundColor = RGBAColor(1, 1, 1, 0.5);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(348));
        make.width.mas_equalTo(CGFloatIn750(520));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    [self.contView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(38));
        make.centerX.equalTo(self.contView.mas_centerX);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    ViewBorderRadius(leftView, CGFloatIn750(12), 1, adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]));
    [self.contView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(146));
        make.height.mas_equalTo(CGFloatIn750(174));
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(20));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(46));
    }];
    
    UIView *rightView = [[UIView alloc] init];
    ViewBorderRadius(rightView, CGFloatIn750(12), 1, adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]));
    [self.contView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(146));
        make.height.mas_equalTo(CGFloatIn750(174));
        make.left.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(20));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(46));
    }];
    [leftView addSubview:self.wexinimageView];
    [rightView addSubview:self.aliImageView];
    
    [leftView addSubview:self.weixinLabel];
    [rightView addSubview:self.aliLabel];
    
    [self.wexinimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.mas_top).offset(CGFloatIn750(30));
        make.centerX.equalTo(leftView.mas_centerX);
    }];
    
    [self.weixinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.wexinimageView.mas_centerX);
        make.top.equalTo(self.wexinimageView.mas_bottom).offset(CGFloatIn750(18));
    }];
    
    [self.aliImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightView.mas_top).offset(CGFloatIn750(30));
        make.centerX.equalTo(rightView.mas_centerX);
    }];
    
    [self.aliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.aliImageView.mas_centerX);
        make.top.equalTo(self.aliImageView.mas_bottom).offset(CGFloatIn750(18));
    }];
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [leftBtn bk_addEventHandler:^(id sender) {
        if (self.handleBlock) {
            self.handleBlock(0);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(leftView);
    }];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (self.handleBlock) {
            self.handleBlock(1);
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightView);
    }];
}


#pragma mark 初始化view
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.layer.cornerRadius = 6;
        _contView.backgroundColor = [UIColor whiteColor];
    }
    
    return _contView;
}


- (UIImageView *)wexinimageView {
    if (!_wexinimageView) {
        _wexinimageView = [[UIImageView alloc] init];
        _wexinimageView.layer.masksToBounds = YES;
        _wexinimageView.contentMode = UIViewContentModeScaleAspectFit;
        _wexinimageView.image = [UIImage imageNamed:@"wechatPay"];
    }
    return _wexinimageView;
}

- (UIImageView *)aliImageView {
    if (!_aliImageView) {
        _aliImageView = [[UIImageView alloc] init];
        _aliImageView.layer.masksToBounds = YES;
        _aliImageView.contentMode = UIViewContentModeScaleAspectFit;
        _aliImageView.image = [UIImage imageNamed:@"alipay"];
    }
    return _aliImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);;
        _nameLabel.text = @"请选择支付方式";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldFontTitle]];
    }
    return _nameLabel;
}


- (UILabel *)weixinLabel {
    if (!_weixinLabel) {
        _weixinLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _weixinLabel.textColor =  adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _weixinLabel.text = @"微信";
        _weixinLabel.numberOfLines = 1;
        _weixinLabel.textAlignment = NSTextAlignmentCenter;
        [_weixinLabel setFont:[UIFont fontSmall]];
    }
    return _weixinLabel;
}

- (UILabel *)aliLabel {
    if (!_aliLabel) {
        _aliLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _aliLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _aliLabel.text = @"支付宝";
        _aliLabel.numberOfLines = 1;
        _aliLabel.textAlignment = NSTextAlignmentCenter;
        [_aliLabel setFont:[UIFont fontSmall]];
    }
    return _aliLabel;
}


- (void)showWithHandlerBlock:(void(^)(NSInteger))handleBlock {
    self.handleBlock = handleBlock;
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}

+ (void)showWithHandlerBlock:(void(^)(NSInteger))handleBlock  {
    [[ZPayAlertTypeView sharedManager] showWithHandlerBlock:handleBlock];
}
@end


