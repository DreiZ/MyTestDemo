//
//  ZOrganizationStudentTopFilterSeaarchView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/22.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentTopFilterSeaarchView.h"
#import "ZOrganizationTopFilterView.h"

@interface ZOrganizationStudentTopFilterSeaarchView ()
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIButton *midBtn;
@property (nonatomic,strong) UIImageView *leftArrow;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) UIImageView *midArrow;

@property (nonatomic,strong) UIView *contView;

@end

@implementation ZOrganizationStudentTopFilterSeaarchView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-0));
        make.height.mas_equalTo(CGFloatIn750(116));
    }];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(0));
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
    
    
    UIView *filterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:filterView];
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.bottom.equalTo(backView);
        make.right.equalTo(backView.mas_right);
    }];
    
    [filterView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.left.equalTo(filterView.mas_left).offset(CGFloatIn750(0));
        make.width.mas_equalTo(CGFloatIn750(160));
    }];
    
    [filterView addSubview:self.midBtn];
    [self.midBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.centerX.equalTo(filterView.mas_centerX);
        make.width.mas_equalTo(CGFloatIn750(160));
    }];
    
    [filterView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.right.equalTo(filterView.mas_right).offset(CGFloatIn750(-20));
        make.width.mas_equalTo(CGFloatIn750(160));
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
//        ViewRadius(_contView, CGFloatIn750(16));
    }
    return _contView;
}


- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_leftBtn setTitle:@"来源渠道" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:[UIFont fontSmall]];
        [_leftBtn addSubview:self.leftArrow];
        [self.leftArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftBtn.titleLabel.mas_right);
            make.centerY.equalTo(self.leftBtn.mas_centerY);
        }];
        [_leftBtn bk_whenTapped:^{
            [ZOrganizationTopFilterView showFilter];
        }];
    }
    return _leftBtn;
}

- (UIButton *)midBtn {
    if (!_midBtn) {
        _midBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_midBtn setTitle:@"来源渠道" forState:UIControlStateNormal];
        [_midBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_midBtn.titleLabel setFont:[UIFont fontSmall]];
        [_midBtn addSubview:self.midArrow];
        [self.midArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.midBtn.titleLabel.mas_right);
            make.centerY.equalTo(self.midBtn.mas_centerY);
        }];
    }
    return _midBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rightBtn setTitle:@"来源渠道" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:[UIFont fontSmall]];
        [_rightBtn addSubview:self.rightArrow];
        [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rightBtn.titleLabel.mas_right);
            make.centerY.equalTo(self.rightBtn.mas_centerY);
        }];
    }
    return _rightBtn;
}

- (UIImageView *)leftArrow {
    if (!_leftArrow) {
        _leftArrow = [[UIImageView alloc] init];
        _leftArrow.image = [UIImage imageNamed:@"mineLessonDown"];
    }
    return _leftArrow;
}

- (UIImageView *)midArrow {
    if (!_midArrow) {
        _midArrow = [[UIImageView alloc] init];
        _midArrow.image = [UIImage imageNamed:@"mineLessonDown"];
    }
    return _midArrow;
}

- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] init];
        _rightArrow.image = [UIImage imageNamed:@"mineLessonDown"];
    }
    return _rightArrow;
}
@end
