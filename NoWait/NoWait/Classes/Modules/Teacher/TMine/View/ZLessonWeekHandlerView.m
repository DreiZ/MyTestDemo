//
//  ZLessonWeekHandlerView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLessonWeekHandlerView.h"

@interface ZLessonWeekHandlerView ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *lastBtn;
@property (nonatomic,strong) UIButton *nextBtn;
@property (nonatomic,strong) UIImageView *arrowImageView;

@end

@implementation ZLessonWeekHandlerView

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
    
    
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self addSubview:self.lastBtn];
    [self addSubview:self.nextBtn];
    [self addSubview:self.titleLabel];
    
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(40));
        make.width.mas_equalTo(CGFloatIn750(132));
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-40));
        make.width.mas_equalTo(CGFloatIn750(132));
    }];
    
    UIImageView *leftImage = [[UIImageView alloc] init];
    leftImage.image = [[UIImage imageNamed:@"leftBlackArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    leftImage.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    
    [self.lastBtn addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lastBtn.titleLabel.mas_left).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UIImageView *rightImage = [[UIImageView alloc] init];
    rightImage.image = [[UIImage imageNamed:@"rightBlackArrowN"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    rightImage.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    
    [self.nextBtn addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nextBtn.titleLabel.mas_right).offset(CGFloatIn750(20));;
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_right).offset(CGFloatIn750(20));
        make.width.mas_equalTo(CGFloatIn750(14));
        make.height.mas_equalTo(CGFloatIn750(8));
    }];
    
    self.arrowImageView.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    UIButton *midBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [midBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.moreBlock) {
            weakSelf.moreBlock(3);
        }
    }forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:midBtn];
    [midBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(CGFloatIn750(180));
    }];
}


- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [[UIImage imageNamed:@"upBlackArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _arrowImageView.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, M_PI);
        _arrowImageView.layer.masksToBounds = YES;
    }
    return _arrowImageView;
}


#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _titleLabel.text = @"本周";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont boldFontTitle]];
    }
    return _titleLabel;
}


- (UIButton *)lastBtn {
    if (!_lastBtn) {
        __weak typeof(self) weakSelf = self;
        _lastBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_lastBtn setTitle:@"上周" forState:UIControlStateNormal];
        [_lastBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_lastBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateHighlighted];
        [_lastBtn.titleLabel setFont:[UIFont fontContent]];
        [_lastBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastBtn;
}


- (UIButton *)nextBtn {
    if (!_nextBtn) {
        __weak typeof(self) weakSelf = self;
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_nextBtn setTitle:@"下周" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_nextBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateHighlighted];
        
        [_nextBtn.titleLabel setFont:[UIFont fontContent]];
        [_nextBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    _arrowImageView.hidden = YES;
    if (index == 0) {
        _lastBtn.hidden = YES;
        if (!self.isOrganization) {
            _titleLabel.hidden = NO;
        }else{
            _arrowImageView.hidden = NO;
        }
        
    }else{
        if (!self.isOrganization) {
            _titleLabel.hidden = YES;
        }else{
            _arrowImageView.hidden = NO;
        }
        
        _lastBtn.hidden = NO;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}
@end



