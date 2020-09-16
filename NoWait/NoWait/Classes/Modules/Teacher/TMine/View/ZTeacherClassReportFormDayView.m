//
//  ZTeacherClassReportFormDayView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassReportFormDayView.h"

@interface ZTeacherClassReportFormDayView ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *resetBtn;

@end

@implementation ZTeacherClassReportFormDayView


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
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(40));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self addSubview:self.resetBtn];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(50));
        make.width.mas_equalTo(CGFloatIn750(120));
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _titleLabel.text = @"2020-01-01至2020-01-01";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontSmall]];
    }
    return _titleLabel;
}

- (void)setTime:(NSString *)time {
    _time = time;
    _titleLabel.text = time;
}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        __weak typeof(self) weakSelf = self;
        _resetBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_resetBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            }
        }];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor colorWithHexString:@"f7c173"] forState:UIControlStateNormal];
        ViewBorderRadius(_resetBtn, CGFloatIn750(8), 1, [UIColor colorWithHexString:@"f7c173"]);
        [_resetBtn.titleLabel setFont:[UIFont fontSmall]];
    }
    return _resetBtn;
}
@end
