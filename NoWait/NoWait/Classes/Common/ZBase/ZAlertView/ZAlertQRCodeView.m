//
//  ZAlertQRCodeView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertQRCodeView.h"
#import "AppDelegate.h"

@interface ZAlertQRCodeView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *codeImageView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ZAlertQRCodeView

static ZAlertQRCodeView *sharedManager;

+ (ZAlertQRCodeView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertQRCodeView alloc] init];
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

#pragma mark 初始化view
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
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(618));
        make.width.mas_equalTo(CGFloatIn750(560));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    [self.contView addSubview:self.codeImageView];
    [self.contView addSubview:self.titleLabel];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(80));
        make.width.height.mas_equalTo(CGFloatIn750(400));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeImageView.mas_bottom).offset(CGFloatIn750(40));
        make.centerX.equalTo(self.contView.mas_centerX);
    }];
    
    UIView *longView = [[UIView alloc] init];
        
    [self.contView addSubview:longView];
    [longView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.codeImageView);
    }];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
        longPress.minimumPressDuration = 0.5; //定义按的时间
    [longView addGestureRecognizer:longPress];
    
}

- (void)btnLong:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
         UIImage *shortImage = [ZPublicTool snapshotForView:self.contView];
       if (shortImage) {
           [ZPublicTool saveImageToPhoto:shortImage];
       }
    }
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.layer.cornerRadius = 6;
        _contView.backgroundColor = [UIColor whiteColor];
    }
    
    return _contView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _titleLabel.text = @"请教练扫码完成签课";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}


- (UIImageView *)codeImageView {
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc] init];
    }
    return _codeImageView;
}

- (void)setTitle:(NSString *)title qrCode:(NSString *)qrCode handlerBlock:(void(^)(NSInteger))handleBlock {
    
    self.titleLabel.text = title;
    [self.codeImageView tt_setImageWithURL:[NSURL URLWithString:qrCode]];
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}


+ (void)setAlertWithTitle:(NSString *)title qrCode:(NSString *)qrCode handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZAlertQRCodeView sharedManager] setTitle:title qrCode:(NSString *)qrCode handlerBlock:handleBlock];
}
@end
