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
- (void)setTitle:(NSString *)title image:(NSString *)image leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    self.hintImageView.image = [UIImage imageNamed:image];
    
    CGSize titleSize = [title sizeForFont:[UIFont boldFontMaxTitle] size:CGSizeMake(CGFloatIn750(570 - 60), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(205)+titleSize.height + CGFloatIn750(110));
        make.width.mas_equalTo(CGFloatIn750(570));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    [self.contView addSubview:self.hintImageView];
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(110));
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
        make.top.equalTo(self.hintImageView.mas_bottom).offset(CGFloatIn750(30));
    }];
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
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
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont fontContent]];
    [rightBtn setBackgroundColor:[UIColor  colorMain] forState:UIControlStateNormal];
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



- (void)setTitle:(NSString *)title image:(NSString *)image btnTitle:(NSString *)btnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    
    [self.contView removeAllSubviews];
    self.hintImageView.image = [UIImage imageNamed:image];
    
    CGSize titleSize = [title sizeForFont:[UIFont boldFontMaxTitle] size:CGSizeMake(CGFloatIn750(570 - 60), MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    [self.contView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(205)+titleSize.height + CGFloatIn750(110));
        make.width.mas_equalTo(CGFloatIn750(570));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(80));
    }];
    
    [self.contView addSubview:self.hintImageView];
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(110));
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
        make.top.equalTo(self.hintImageView.mas_bottom).offset(CGFloatIn750(30));
    }];
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
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

+ (void)setAlertWithTitle:(NSString *)title image:(NSString *)image leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZAlertImageView sharedManager] setTitle:title image:image leftBtnTitle:leftBtnTitle rightBtnTitle:rightBtnTitle handlerBlock:handleBlock];
}

+ (void)setAlertWithTitle:(NSString *)title image:(NSString *)image btnTitle:(NSString *)btnTitle handlerBlock:(void(^)(NSInteger))handleBlock {
    [[ZAlertImageView sharedManager] setTitle:title image:(NSString *)image btnTitle:btnTitle handlerBlock:handleBlock];
}

+ (void)setAlertWithType:(ZAlertType)type  handlerBlock:(void(^)(NSInteger))handleBlock {
    NSString *image = @"repealSubscribeSuccess";
    if (type == ZAlertTypeSubscribeFail) {
        image = @"repealSubscribeFail";
        [[ZAlertImageView sharedManager] setTitle:@"预约失败" image:image leftBtnTitle:@"返回首页" rightBtnTitle:@"重新预约" handlerBlock:handleBlock];
    }else if (type == ZAlertTypeRepealSubscribe){
        image = @"repealSubscribe";
        [[ZAlertImageView sharedManager] setTitle:@"确定撤销预约" image:image leftBtnTitle:@"取消" rightBtnTitle:@"确定" handlerBlock:handleBlock];
    }else if (type == ZAlertTypeRepealSubscribeSuccess){
        image = @"repealSubscribeSuccess";
        [[ZAlertImageView sharedManager] setTitle:@"撤销预约成功" image:image btnTitle:@"返回首页" handlerBlock:handleBlock];
    }else if (type == ZAlertTypeRepealSubscribeFail){
        image = @"repealSubscribeFail";
        [[ZAlertImageView sharedManager] setTitle:@"撤销失败" image:image leftBtnTitle:@"取消" rightBtnTitle:@"重新撤销" handlerBlock:handleBlock];
    }
}
@end

