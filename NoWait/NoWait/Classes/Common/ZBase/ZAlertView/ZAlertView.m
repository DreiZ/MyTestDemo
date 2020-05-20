//
//  ZAlertView.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/11/29.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZAlertView.h"
#import "AppDelegate.h"

@interface ZAlertView ()
@property (nonatomic,strong) UIView *contView;

@end

@implementation ZAlertView

static ZAlertView *sharedManager;

+ (ZAlertView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertView alloc] init];
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
    
    UIButton *backBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(250));
        make.width.mas_equalTo(CGFloatIn750(570));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.layer.cornerRadius = 6;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    
    return _contView;
}



- (void)setTitle:(NSString *)title leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    
    CGSize titleSize = [title sizeForFont:[UIFont fontContent] size:CGSizeMake(CGFloatIn750(570 - 60), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(205)+titleSize.height);
        make.width.mas_equalTo(CGFloatIn750(570));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontContent]];
    [self.contView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(70));
    }];
    
    
    UIButton *leftBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont fontContent]];
    [leftBtn setBackgroundColor:HexAColor(0xcccccc, 1.0) forState:UIControlStateNormal];
    [leftBtn bk_addEventHandler:^(id sender) {
        if (handleBlock) {
            handleBlock(0);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(82));
        make.left.equalTo(self.contView.mas_left);
        make.bottom.equalTo(self.contView.mas_bottom);
        make.right.equalTo(self.contView.mas_centerX);
    }];
    
    UIButton *rightBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont fontContent]];
    [rightBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (handleBlock) {
            handleBlock(1);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(82));
        make.right.equalTo(self.contView.mas_right);
        make.bottom.equalTo(self.contView.mas_bottom);
        make.left.equalTo(self.contView.mas_centerX);
    }];
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}



- (void)setTitle:(NSString *)title btnTitle:(NSString *)btnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    
    CGSize titleSize = [title sizeForFont:[UIFont fontContent] size:CGSizeMake(CGFloatIn750(570 - 60), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(205)+titleSize.height);
        make.width.mas_equalTo(CGFloatIn750(570));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontContent]];
    [self.contView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(70));
    }];
    
    
    UIButton *rightBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [rightBtn setTitle:btnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont fontContent]];
    [rightBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (handleBlock) {
            handleBlock(1);
            [self removeFromSuperview];
        }else{
            [self removeFromSuperview];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(82));
        make.right.equalTo(self.contView.mas_right);
        make.bottom.equalTo(self.contView.mas_bottom);
        make.left.equalTo(self.contView.mas_left);
    }];
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}


- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle btnTitle:(NSString *)btnTitle  handlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    
    CGSize subTitleSize = [subTitle sizeForFont:[UIFont fontContent] size:CGSizeMake(KScreenWidth - CGFloatIn750(120), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(360)+subTitleSize.height);
        make.width.mas_equalTo(KScreenWidth - CGFloatIn750(60));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    titleLabel.text = title;
    titleLabel.numberOfLines = 1;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont boldFontMax1Title]];
    [self.contView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(40));
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    subTitleLabel.text = subTitle;
    subTitleLabel.numberOfLines = 0;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [subTitleLabel setFont:[UIFont fontContent]];
    [self.contView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(titleLabel.mas_bottom).offset(CGFloatIn750(70));
    }];
    
    
    UIButton *leftBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [leftBtn setTitle:btnTitle forState:UIControlStateNormal];
    [leftBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont boldFontContent]];
    ViewBorderRadius(leftBtn, CGFloatIn750(40), 1, adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    [leftBtn bk_addEventHandler:^(id sender) {
        if (handleBlock) {
            handleBlock(0);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.width.mas_equalTo(CGFloatIn750(500));
        make.centerX.equalTo(self.contView.mas_centerX);
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
    }];
    
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}

- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    
    CGSize subTitleSize = [subTitle sizeForFont:[UIFont fontContent] size:CGSizeMake(KScreenWidth - CGFloatIn750(120), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(360)+subTitleSize.height);
        make.width.mas_equalTo(KScreenWidth - CGFloatIn750(60));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    titleLabel.text = title;
    titleLabel.numberOfLines = 1;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont boldFontMax1Title]];
    [self.contView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(40));
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
    subTitleLabel.text = subTitle;
    subTitleLabel.numberOfLines = 0;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [subTitleLabel setFont:[UIFont fontContent]];
    [self.contView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(titleLabel.mas_bottom).offset(CGFloatIn750(70));
    }];
    
    
    UIButton *leftBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
    [leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]) forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont boldFontContent]];
    ViewBorderRadius(leftBtn, CGFloatIn750(40), 1, adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]));
    [leftBtn bk_addEventHandler:^(id sender) {
        if (handleBlock) {
            handleBlock(0);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(14));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
    }];
    
    UIButton *rightBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont boldFontContent]];
    ViewBorderRadius(rightBtn, CGFloatIn750(40), 1, adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    [rightBtn bk_addEventHandler:^(id sender) {
        if (handleBlock) {
            handleBlock(1);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(40));
        make.left.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(14));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
    }];
    
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }];
}

+ (void)setAlertWithTitle:(NSString *)title leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZAlertView sharedManager] setTitle:title leftBtnTitle:leftBtnTitle rightBtnTitle:rightBtnTitle handlerBlock:handleBlock];
}

+ (void)setAlertWithTitle:(NSString *)title btnTitle:(NSString *)btnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZAlertView sharedManager] setTitle:title btnTitle:btnTitle handlerBlock:handleBlock];
}

+ (void)setAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle btnTitle:(NSString *)btnTitle  handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZAlertView sharedManager] setTitle:title subTitle:subTitle btnTitle:btnTitle handlerBlock:handleBlock];
}

+ (void)setAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock{
    [[ZAlertView sharedManager] setTitle:title subTitle:subTitle leftBtnTitle:leftBtnTitle rightBtnTitle:rightBtnTitle handlerBlock:handleBlock];
}
@end
