//
//  ZRewardAlertView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardAlertView.h"

@interface ZRewardAlertView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) void (^seeBlock)(void);
@end

@implementation ZRewardAlertView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor(HexAColor(0x000000, 0.5), HexAColor(0xffffff, 0.5));
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIImageView *rewardImageView = [[UIImageView alloc] init];
    rewardImageView.image = [UIImage imageNamed:@"rewardAlert"];
    rewardImageView.layer.masksToBounds = YES;
    rewardImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contView addSubview:rewardImageView];
    [rewardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView);
        make.centerY.equalTo(self.contView.mas_bottom).multipliedBy(2.0f/5);
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(50));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(50));
    }];
   
    UILabel *rewardBtn = [[UILabel alloc] initWithFrame:CGRectZero];
    rewardBtn.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlack]);
    rewardBtn.text = @"奖励中心";
    rewardBtn.numberOfLines = 0;
    rewardBtn.textAlignment = NSTextAlignmentLeft;
    [rewardBtn setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(56)]];
    [self.contView addSubview:rewardBtn];
    [rewardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contView.mas_centerX);
        make.centerY.equalTo(rewardImageView.mas_centerY).offset(-CGFloatIn750(10));
    }];
    
    
    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    oneLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlack]);
    oneLabel.text = @"1. 推荐培训机构入驻似锦APP，可收取该机构在平台第一年内平台线上交易额的0.5%返佣奖励";
    oneLabel.numberOfLines = 0;
    oneLabel.textAlignment = NSTextAlignmentLeft;
    [oneLabel setFont:[UIFont fontContent]];
    [self.contView addSubview:oneLabel];
    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(90));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(90));
        make.top.equalTo(rewardBtn.mas_bottom).offset(CGFloatIn750(30));
    }];
    
    UILabel *twoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    twoLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlack]);
    twoLabel.text = @"2. 推荐用户下载似锦APP，可收取该用户在平台第一年内平台线上交易额的1%返佣奖励";
    twoLabel.numberOfLines = 0;
    twoLabel.textAlignment = NSTextAlignmentLeft;
    [twoLabel setFont:[UIFont fontContent]];
    [self.contView addSubview:twoLabel];
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(90));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(90));
        make.top.equalTo(oneLabel.mas_bottom).offset(CGFloatIn750(24));
    }];
    
    [ZPublicTool setLineSpacing:CGFloatIn750(12) label:twoLabel];
    [ZPublicTool setLineSpacing:CGFloatIn750(12) label:oneLabel];
    
    UIButton *seeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [seeBtn setTitle:@"去看看" forState:UIControlStateNormal];
    [seeBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [seeBtn.titleLabel setFont:[UIFont fontContent]];
    seeBtn.backgroundColor = [UIColor colorMain];
    ViewRadius(seeBtn, CGFloatIn750(40));
    [seeBtn bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (self.seeBlock) {
                self.seeBlock();
            }
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:seeBtn];
    [seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(432));
        make.height.mas_equalTo(CGFloatIn750(80));
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(twoLabel.mas_bottom).offset(CGFloatIn750(18));
    }];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [closeBtn setImage:[[UIImage imageNamed:@"lessonSelectClose"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    closeBtn.tintColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlack]);
    [closeBtn bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(60));
        make.centerX.equalTo(self.contView.mas_centerX);
        make.top.equalTo(seeBtn.mas_bottom).offset(CGFloatIn750(10));
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
    }
    return _contView;
}

+ (void)showRewardSeeBlock:(void (^)(void))block {
    ZRewardAlertView *rewardView = [[ZRewardAlertView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    rewardView.seeBlock = block;
    
    [[AppDelegate shareAppDelegate].window addSubview:rewardView];
    rewardView.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        rewardView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
@end
