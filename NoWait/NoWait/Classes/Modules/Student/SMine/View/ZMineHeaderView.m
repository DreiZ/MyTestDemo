//
//  ZMineHeaderView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineHeaderView.h"

#define headImageHeight CGFloatIn750(82)

@interface ZMineHeaderView ()
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIView *settingView;
@property (nonatomic,strong) UIImageView *settingImageView;

@property (nonatomic,strong) UIButton *userInfoBtn;

@property (nonatomic,strong) UIView *backView;

@end

@implementation ZMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackDarkBG]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.backView];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.settingView];
    [self.settingView addSubview:self.settingImageView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    
    [self.settingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.settingView);
        make.height.width.mas_equalTo(CGFloatIn750(44));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView.mas_centerY);
        make.left.equalTo(self.headImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self addSubview:self.userInfoBtn];
    [self.userInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.userInfoBtn);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *setBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [setBtn bk_whenTapped:^{
        if (weakSelf.topHandleBlock) {
            weakSelf.topHandleBlock(1);
        }
    }];
    [self addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGFloatIn750(88));
        make.center.equalTo(self.settingView);
    }];
    
    [self setSubViewFrame];
}

#pragma mark -设置frame
- (void)setSubViewFrame {
    self.headImageView.frame = CGRectMake(CGFloatIn750(30), self.height - CGFloatIn750(30) - headImageHeight, headImageHeight, headImageHeight);
    
    
    self.settingView.frame = CGRectMake(KScreenWidth - CGFloatIn750(90), self.height - (CGFloatIn750(90) + CGFloatIn750(50)), CGFloatIn750(90), CGFloatIn750(90));
    
    self.nameLabel.font = [UIFont systemFontOfSize:CGFloatIn750(36)];
    self.nameLabel.alpha = 1;
    self.headImageView.layer.cornerRadius = CGFloatIn750(41);
    
    self.backView.alpha = 0;
}

- (void)setAnimationSubViewFrame {

    self.nameLabel.alpha = (self.height-kTopHeight)/(44);
    
    self.nameLabel.font = [UIFont systemFontOfSize:(CGFloatIn750(36) - (1 - self.nameLabel.alpha)*CGFloatIn750(10))];
    
    self.headImageView.frame = CGRectMake(CGFloatIn750(30) + (1 - self.nameLabel.alpha)*((KScreenWidth - CGFloatIn750(60) - headImageHeight)/2), self.height - CGFloatIn750(30) - headImageHeight + (1 - self.nameLabel.alpha)*CGFloatIn750(12), headImageHeight - (1 - self.nameLabel.alpha)*CGFloatIn750(20), headImageHeight - (1 - self.nameLabel.alpha)*CGFloatIn750(20));
    
    self.settingView.frame = CGRectMake(KScreenWidth - CGFloatIn750(90), self.height - (CGFloatIn750(90) + CGFloatIn750(50)) + (1 - self.nameLabel.alpha)*CGFloatIn750(30) , CGFloatIn750(90), CGFloatIn750(90));
    
    self.headImageView.layer.cornerRadius = self.headImageView.height/2;
    self.settingImageView.transform = CGAffineTransformRotate(self.settingImageView.transform, M_PI_4 * 0.05);
    
    self.backView.alpha = (1 - self.nameLabel.alpha);
    
}

#pragma mark --懒加载---
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"headImage"];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = CGFloatIn750(41);
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextGray1]);
        _nameLabel.text = @"尖耳朵的兔子";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(36)]];
    }
    return _nameLabel;
}

- (UIImageView *)settingImageView {
    if (!_settingImageView) {
        _settingImageView = [[UIImageView alloc] init];
        _settingImageView.image = [[UIImage imageNamed:@"mineSetting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _settingImageView.tintColor = [UIColor  colorMain];
        _settingImageView.layer.masksToBounds = YES;
        _settingImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _settingImageView;
}

- (UIButton *)userInfoBtn {
    if (!_userInfoBtn) {
        __weak typeof(self) weakSelf = self;
        _userInfoBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_userInfoBtn bk_whenTapped:^{
            if (weakSelf.topHandleBlock) {
                weakSelf.topHandleBlock(0);
            }
        }];
    }
    return _userInfoBtn;
}


- (UIView *)settingView {
    if (!_settingView) {
        _settingView = [[UIView alloc] init];
        _settingView.layer.masksToBounds = YES;
//        _settingView.backgroundColor =[UIColor colorWhite];
    }
    return _settingView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor  colorMain];
    }
    return _backView;
}

#pragma mark - 更新frame
- (void)updateSubViewFrame {
    [self setSubViewFrame];
    if (self.height > kTopHeight + kStatusBarHeight) {
        [self setSubViewFrame];
    }else {
//        NSLog(@"------xia--%f",self.height);
        [self setAnimationSubViewFrame];
    }
}
@end
