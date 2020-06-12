//
//  ZTeacherSignTopTitleView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/13.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherSignTopTitleView.h"
@interface ZTeacherSignTopTitleView ()
@property (nonatomic,strong) UIImageView *stateImageView;

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *lastBtn;
@property (nonatomic,strong) UIButton *nextBtn;

@end

@implementation ZTeacherSignTopTitleView

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
    [self addSubview:self.timeLabel];
    [self addSubview:self.stateImageView];
    
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self);
        make.width.mas_equalTo(CGFloatIn750(132));
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.mas_equalTo(CGFloatIn750(132));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-CGFloatIn750(16));
    }];
    
    [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(14));
        make.height.mas_equalTo(CGFloatIn750(8));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleLabel.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(6));
    }];
    
    self.stateImageView.hidden = YES;
}


#pragma mark - Getter

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _timeLabel.text = @"";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_timeLabel setFont:[UIFont fontMin]];
    }
    return _timeLabel;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont boldFontContent]];
    }
    return _titleLabel;
}

- (UIImageView *)stateImageView {
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] init];
        _stateImageView.layer.masksToBounds = YES;
        _stateImageView.image = [[UIImage imageNamed:@"upBlackArrow"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _stateImageView.transform =  CGAffineTransformRotate(self.stateImageView.transform, M_PI);
        _stateImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    }
    return _stateImageView;
}


- (UIButton *)lastBtn {
    if (!_lastBtn) {
        __weak typeof(self) weakSelf = self;
        _lastBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_lastBtn setTitle:@"上一节" forState:UIControlStateNormal];
        [_lastBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_lastBtn.titleLabel setFont:[UIFont boldFontSmall]];
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
        [_nextBtn setTitle:@"下一节" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_nextBtn.titleLabel setFont:[UIFont boldFontSmall]];
        [_nextBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}


- (void)setModel:(ZOriganizationClassDetailModel *)model {
    _model = model;
    if (model.index <= 1) {
        _lastBtn.hidden = YES;
    }else {
        _lastBtn.hidden = NO;
    }
    
    
    _titleLabel.text = [NSString stringWithFormat:@"第%ld节课",model.index];
}

- (void)setTime:(NSString *)time {
    if ([time isEqualToString:@"0"]) {
        _timeLabel.text = @"未开课";
    }else{
        _timeLabel.text = [time timeStringWithFormatter:@"yyyy-MM-dd HH:mm"];
    }
    
}
@end


