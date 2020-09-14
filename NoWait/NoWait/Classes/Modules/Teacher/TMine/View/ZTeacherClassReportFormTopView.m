//
//  ZTeacherClassReportFormTopView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTeacherClassReportFormTopView.h"

@interface ZTeacherClassReportFormTopView ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;

@end

@implementation ZTeacherClassReportFormTopView

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
    
    
    self.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    
    [self addSubview:self.titleLabel];
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
    
    self.arrowImageView.hidden = NO;
    
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
        make.left.equalTo(self.titleLabel.mas_left).offset(-10);
        make.right.equalTo(self.arrowImageView.mas_right).offset(10);
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
        _titleLabel.text = @"班级名称";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont fontContent]];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}
@end




