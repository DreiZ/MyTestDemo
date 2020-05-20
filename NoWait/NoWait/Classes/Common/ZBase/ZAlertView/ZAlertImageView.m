//
//  ZAlertImageView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZAlertImageView.h"
#import "AppDelegate.h"

@interface ZAlertImageView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *hintImageView;

@end

@implementation ZAlertImageView

static ZAlertImageView *sharedManager;

+ (ZAlertImageView *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZAlertImageView alloc] init];
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
        _contView.backgroundColor = [UIColor whiteColor];
    }
    
    return _contView;
}

- (UIImageView *)hintImageView {
    if (!_hintImageView) {
        _hintImageView = [[UIImageView alloc] init];
        _hintImageView.layer.masksToBounds = YES;
        _hintImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _hintImageView;
}

#pragma mark ---设置显示内容
- (void)setTitle:(NSString *)title  subTitle:(NSString *)subTitle image:(UIImage *)image leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    self.hintImageView.image = image;
//    [UIImage imageNamed:image];
    
    CGFloat fixelW = image.size.width;
    CGFloat fixelH = image.size.height;
    if (fixelH > fixelW * 1.5) {
        fixelH = fixelW*1.5;
    }
    
    CGSize titleSize = [title sizeForFont:[UIFont boldFontMaxTitle] size:CGSizeMake(CGFloatIn750(570 - 60), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    CGSize subTitleSize = [subTitle sizeForFont:[UIFont fontContent] size:CGSizeMake(CGFloatIn750(570 - 60), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor colorTextBlack];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont boldFontMaxTitle]];
    [self.contView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(30));
    }];
    
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(205)+titleSize.height + (CGFloatIn750(510) * (fixelH/fixelW)) + (subTitleSize.height > 10 ? (subTitleSize.height + CGFloatIn750(20)):0));
        make.width.mas_equalTo(CGFloatIn750(570));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    [self.contView addSubview:self.hintImageView];
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(titleLabel.mas_bottom).offset(CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(510) * (fixelH/fixelW));
        make.width.mas_equalTo(CGFloatIn750(510));
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subTitleLabel.textColor = [UIColor colorTextBlack];
    subTitleLabel.text = subTitle;
    subTitleLabel.numberOfLines = 0;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [subTitleLabel setFont:[UIFont fontContent]];
    [self.contView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.hintImageView.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    
    UIButton *leftBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorTextGray] forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont fontContent]];
    [leftBtn setBackgroundColor:[UIColor colorGrayLine] forState:UIControlStateNormal];
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



- (void)setTitle:(NSString *)title  subTitle:(NSString *)subTitle image:(UIImage *)image btnTitle:(NSString *)btnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    self.hintImageView.image = image;
//    [UIImage imageNamed:image];
    CGFloat fixelW = CGImageGetWidth(image.CGImage);
    CGFloat fixelH = CGImageGetHeight(image.CGImage);
    CGSize titleSize = [title sizeForFont:[UIFont boldFontMaxTitle] size:CGSizeMake(CGFloatIn750(570 - 60), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    CGSize subTitleSize = [subTitle sizeForFont:[UIFont fontContent] size:CGSizeMake(CGFloatIn750(570 - 60), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(205) + titleSize.height + (CGFloatIn750(510) * (fixelH/fixelW)) + (subTitleSize.height > 10 ?  (subTitleSize.height + CGFloatIn750(20)):0));
        make.width.mas_equalTo(CGFloatIn750(570));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor colorTextBlack];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont boldFontMaxTitle]];
    [self.contView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(30));
    }];
    
    
    [self.contView addSubview:self.hintImageView];
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(titleLabel.mas_bottom).offset(CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(510) * (fixelH/fixelW));
        make.width.mas_equalTo(CGFloatIn750(510));
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subTitleLabel.textColor = [UIColor colorTextBlack];
    subTitleLabel.text = subTitle;
    subTitleLabel.numberOfLines = 0;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [subTitleLabel setFont:[UIFont fontContent]];
    [self.contView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.hintImageView.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    
    UIButton *rightBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [rightBtn setTitle:btnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont fontContent]];
    [rightBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (handleBlock) {
            handleBlock(1);
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

+ (void)setAlertWithTitle:(NSString *)title  subTitle:(NSString *)subTitle image:(UIImage *)image leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZAlertImageView sharedManager] setTitle:title subTitle:subTitle image:image leftBtnTitle:leftBtnTitle rightBtnTitle:rightBtnTitle handlerBlock:handleBlock];
}

+ (void)setAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image btnTitle:(NSString *)btnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZAlertImageView sharedManager] setTitle:title subTitle:subTitle image:image btnTitle:btnTitle handlerBlock:handleBlock];
}

@end

