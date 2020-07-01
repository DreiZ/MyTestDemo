//
//  ZPhoneAlertView.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/12/12.
//  Copyright © 2018 zhuang zhang. All rights reserved.
//

#import "ZPhoneAlertView.h"
#import "AppDelegate.h"
#import "ZPublicTool.h"

@interface ZPhoneAlertView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *telLabel;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

@implementation ZPhoneAlertView

static ZPhoneAlertView *sharedManager;

+ (ZPhoneAlertView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZPhoneAlertView alloc] init];
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
        [self closeView];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(354));
        make.width.mas_equalTo(KScreenWidth - CGFloatIn750(60));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
//    [self.contView addSubview:self.headImageView];
//    [self.contView addSubview:self.nameLabel];
//    [self.contView addSubview:self.detailLabel];
//    [self.contView addSubview:self.telLabel];
//
//    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(CGFloatIn750(100));
//        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(20));
//        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(40));
//    }];
//
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.headImageView.mas_right).offset(CGFloatIn750(30));
//        make.bottom.equalTo(self.headImageView.mas_centerY).offset(-CGFloatIn750(6));
//    }];
//
//    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLabel.mas_left);
//        make.top.equalTo(self.headImageView.mas_centerY).offset(CGFloatIn750(6));
//    }];
//
//    UIImageView *telImageView = [[UIImageView alloc] init];
//    telImageView.image = [UIImage imageNamed:@"moneyIntroTop"];
//    telImageView.layer.masksToBounds = YES;
//    [self.contView addSubview:telImageView];
//    [telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(CGFloatIn750(61));
//        make.height.mas_equalTo(CGFloatIn750(57));
//        make.left.equalTo(self.nameLabel.mas_left);
//        make.top.equalTo(self.headImageView.mas_bottom).offset(CGFloatIn750(20));
//    }];
//
//    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(telImageView.mas_centerY);
//        make.left.equalTo(telImageView.mas_right).offset(CGFloatIn750(30));
//    }];
//
//    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [leftBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
//    [leftBtn.titleLabel setFont:[UIFont fontContent]];
//    [leftBtn setBackgroundColor:[UIColor colorGrayLine] forState:UIControlStateNormal];
//    [leftBtn bk_addEventHandler:^(id sender) {
//        if (self.handleBlock) {
//            self.handleBlock(0);
//        }
//        [self removeFromSuperview];
//    } forControlEvents:UIControlEventTouchUpInside];
//    [self.contView addSubview:leftBtn];
//    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(CGFloatIn750(82));
//        make.left.equalTo(self.contView.mas_left);
//        make.bottom.equalTo(self.contView.mas_bottom);
//        make.right.equalTo(self.contView.mas_centerX);
//    }];
//
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//    [rightBtn setTitle:@"呼叫" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
//    [rightBtn.titleLabel setFont:[UIFont fontContent]];
//    [rightBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
//    [rightBtn bk_addEventHandler:^(id sender) {
//        if (self.handleBlock) {
//            self.handleBlock(1);
//        }
//        [ZPublicTool callTel:self.telLabel.text];
//        [self removeFromSuperview];
//    } forControlEvents:UIControlEventTouchUpInside];
//    [self.contView addSubview:rightBtn];
//    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(CGFloatIn750(82));
//        make.right.equalTo(self.contView.mas_right);
//        make.bottom.equalTo(self.contView.mas_bottom);
//        make.left.equalTo(self.contView.mas_centerX);
//    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.layer.cornerRadius = CGFloatIn750(32);
        _contView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorGrayBGDark]);
    }
    
    return _contView;
}


- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.cornerRadius = CGFloatIn750(50);
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontContent]];
    }
    return _detailLabel;
}

- (UILabel *)telLabel {
    if (!_telLabel) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _telLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _telLabel.numberOfLines = 1;
        _telLabel.textAlignment = NSTextAlignmentLeft;
        [_telLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(38)]];
    }
    return _telLabel;
}


- (void)setName:(NSString *)title detail:(NSString *)detail headImage:(NSString *)headImage tel:(NSString *)tel handlerBlock:(void(^)(NSInteger))handleBlock {
    self.handleBlock = handleBlock;
    
//    [self.headImageView tt_setImageWithURL:[NSURL URLWithString:headImage]];
//    self.nameLabel.text = title;
//    self.detailLabel.text = detail;
//    self.telLabel.text = tel;
    
    self.contView.alpha = 0;
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contView.alpha = 1;
        self.alpha = 1;
//        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)setName:(NSString *)title tel:(NSString *)tel handlerBlock:(void(^)(NSInteger))handleBlock {
    self.handleBlock = handleBlock;
    
    [self.contView removeAllSubviews];
        
    [self.contView addSubview:self.headImageView];
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.telLabel];
    
//    self.headImageView.image = [UIImage imageNamed:@"telhint"];
    self.nameLabel.text = title;
    self.telLabel.text = tel;
    self.telLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
//
//    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(CGFloatIn750(164));
//        make.height.mas_equalTo(CGFloatIn750(208));
//        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(40));
//        make.centerX.equalTo(self.contView.mas_centerX);
//    }];
    
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(50));
    }];

   
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont boldFontContent]];
    [rightBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (self.handleBlock) {
            self.handleBlock(1);
        }
        [ZPublicTool callTel:SafeStr(self.telLabel.text)];
        [self closeView];
    } forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(rightBtn, CGFloatIn750(40));
    [self.contView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(self.contView.mas_centerX).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(40));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(48));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
       make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
       make.top.equalTo(self.telLabel.mas_bottom).offset(CGFloatIn750(22));
        make.bottom.mas_lessThanOrEqualTo(rightBtn.mas_bottom).offset(-CGFloatIn750(20));
   }];
    

    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [leftBtn setTitle:@"取消拨打" forState:UIControlStateNormal];
    [leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont fontContent]];
    [leftBtn bk_addEventHandler:^(id sender) {
        if (self.handleBlock) {
            self.handleBlock(0);
        }
        [self removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    ViewBorderRadius(leftBtn, CGFloatIn750(40), 1, adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    [self.contView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(80));
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.contView.mas_centerX).offset(-CGFloatIn750(30));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(48));
    }];
   
    
    self.contView.alpha = 0;
    self.alpha = 0;
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [[AppDelegate shareAppDelegate].window addSubview:self];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contView.alpha = 1;
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)closeView {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)setAlertName:(NSString *)title detail:(NSString *)detail headImage:(NSString *)headImage tel:(NSString *)tel handlerBlock:(void(^)(NSInteger))handleBlock  {
    [[ZPhoneAlertView sharedManager] setName:title detail:detail headImage:headImage tel:tel handlerBlock:handleBlock];
}


+ (void)setAlertName:(NSString *)title tel:(NSString *)tel handlerBlock:(void(^)(NSInteger))handleBlock  {
    [[ZPhoneAlertView sharedManager] setName:title tel:tel handlerBlock:handleBlock];
}
@end

