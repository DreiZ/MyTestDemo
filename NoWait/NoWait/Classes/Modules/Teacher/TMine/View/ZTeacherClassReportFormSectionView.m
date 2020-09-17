//
//  ZTeacherClassReportFormSectionView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassReportFormSectionView.h"

@interface ZTeacherClassReportFormSectionView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *weekBtn;
@property (nonatomic,strong) UIButton *dayBtn;
@property (nonatomic,strong) UIButton *mouthBtn;

@property (nonatomic,strong) UIButton *fitleBtn;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation ZTeacherClassReportFormSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.contView];
    [self.contView addSubview:self.dayBtn];
//    [self.contView addSubview:self.weekBtn];
    [self.contView addSubview:self.mouthBtn];
    [self.contView addSubview:self.fitleBtn];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(1);
    }];
    
    [self.contView addSubview:self.lineView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [self.dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(68));
        make.width.mas_equalTo((KScreenWidth-CGFloatIn750(176))/3.0);
    }];
    
//    [self.weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.dayBtn.mas_right).offset(CGFloatIn750(0));
//        make.height.mas_equalTo(CGFloatIn750(68));
//        make.width.equalTo(self.dayBtn.mas_width);
//    }];
    
    [self.mouthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayBtn.mas_right).offset(CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(68));
        make.width.equalTo(self.dayBtn.mas_width);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn750(6));
        make.width.mas_equalTo(CGFloatIn750(30));
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.dayBtn.mas_centerX);
    }];
    
    [self.fitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(0));
        make.height.mas_equalTo(CGFloatIn750(68));
        make.width.mas_equalTo(CGFloatIn750(176));
    }];
    
    
    UIView *spacLineView = [[UIView alloc] initWithFrame:CGRectZero];
    spacLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self.contView addSubview:spacLineView];
    [spacLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fitleBtn.mas_left);
        make.centerY.equalTo(self.fitleBtn.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(24));
        make.width.mas_equalTo(1);
    }];
    
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.layer.masksToBounds = YES;
        _lineView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
    }
    return _lineView;
}


- (UIButton *)fitleBtn {
    if (!_fitleBtn) {
        __weak typeof(self) weakSelf = self;
        _fitleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_fitleBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_fitleBtn.titleLabel setFont:[UIFont fontContent]];
        [_fitleBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_fitleBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateSelected];
        [_fitleBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(4);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _fitleBtn;
}


- (UIButton *)mouthBtn {
    if (!_mouthBtn) {
        __weak typeof(self) weakSelf = self;
        _mouthBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_mouthBtn setTitle:@"月报" forState:UIControlStateNormal];
        [_mouthBtn.titleLabel setFont:[UIFont fontContent]];
        [_mouthBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_mouthBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateSelected];
        [_mouthBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2);
            }
            self.type = 2;
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _mouthBtn;
}

- (UIButton *)weekBtn {
    if (!_weekBtn) {
        __weak typeof(self) weakSelf = self;
        _weekBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_weekBtn setTitle:@"周报" forState:UIControlStateNormal];
        [_weekBtn.titleLabel setFont:[UIFont fontContent]];
        [_weekBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_weekBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateSelected];
        [_weekBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            }
            self.type = 1;
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _weekBtn;
}

- (UIButton *)dayBtn {
    if (!_dayBtn) {
        __weak typeof(self) weakSelf = self;
        _dayBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_dayBtn setTitle:@"日报" forState:UIControlStateNormal];
        [_dayBtn.titleLabel setFont:[UIFont fontContent]];
        [_dayBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_dayBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateSelected];
        [_dayBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
            self.type = 0;
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _dayBtn;
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (_type == 0) {
        [_dayBtn.titleLabel setFont:[UIFont boldFontContent]];
//        [_weekBtn.titleLabel setFont:[UIFont fontContent]];
        [_mouthBtn.titleLabel setFont:[UIFont fontContent]];
        
        [_dayBtn setSelected:YES];
//        [_weekBtn setSelected:NO];
        [_mouthBtn setSelected:NO];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(6));
            make.width.mas_equalTo(CGFloatIn750(30));
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.dayBtn.mas_centerX);
        }];
    }else if (_type == 1) {
//        [_weekBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_dayBtn.titleLabel setFont:[UIFont fontContent]];
        [_mouthBtn.titleLabel setFont:[UIFont fontContent]];
        [_dayBtn setSelected:NO];
//        [_weekBtn setSelected:YES];
        [_mouthBtn setSelected:NO];
        
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(6));
            make.width.mas_equalTo(CGFloatIn750(30));
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.weekBtn.mas_centerX);
        }];
    }else {
        [_mouthBtn.titleLabel setFont:[UIFont boldFontContent]];
        [_dayBtn.titleLabel setFont:[UIFont fontContent]];
//        [_weekBtn.titleLabel setFont:[UIFont fontContent]];
        [_dayBtn setSelected:NO];
//        [_weekBtn setSelected:NO];
        [_mouthBtn setSelected:YES];
        
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFloatIn750(6));
            make.width.mas_equalTo(CGFloatIn750(30));
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.mouthBtn.mas_centerX);
        }];
    }
}
@end

