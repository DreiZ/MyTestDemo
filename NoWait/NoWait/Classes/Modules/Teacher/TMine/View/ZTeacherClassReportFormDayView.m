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
}

#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _titleLabel.text = @"2020-12-21至2020-12-31";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontSmall]];
    }
    return _titleLabel;
}
@end
