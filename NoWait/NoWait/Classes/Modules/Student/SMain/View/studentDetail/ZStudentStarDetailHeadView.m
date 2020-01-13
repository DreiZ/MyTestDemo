//
//  ZStudentStarDetailHeadView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentStarDetailHeadView.h"

@interface ZStudentStarDetailHeadView ()
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIImageView *userHeaderImageView;
@end

@implementation ZStudentStarDetailHeadView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;

    [self addSubview:self.headImageView];
    [self addSubview:self.userHeaderImageView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(500));
    }];
    
    [self.userHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(14));
        make.width.mas_equalTo(CGFloatIn750(532));
        make.height.mas_equalTo(CGFloatIn750(430));
    }];
}


#pragma mark --懒加载---
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"studentStarHeaderBack"];        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UIImageView *)userHeaderImageView {
    if (!_userHeaderImageView) {
        _userHeaderImageView = [[UIImageView alloc] init];
        _userHeaderImageView.image = [UIImage imageNamed:@"studentDetaiUserHead"];
        _userHeaderImageView.layer.masksToBounds = YES;
        _userHeaderImageView.layer.cornerRadius = CGFloatIn750(10);
        _userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userHeaderImageView.layer.shadowOffset = CGSizeMake(0, 2);
        _userHeaderImageView.layer.shadowOpacity = 0.8;
        _userHeaderImageView.layer.shadowColor = [UIColor colorWithHexString:@"eeeeee"].CGColor;
    }
    return _userHeaderImageView;
}


- (void)updateSubViewFrame {
    
}
@end
