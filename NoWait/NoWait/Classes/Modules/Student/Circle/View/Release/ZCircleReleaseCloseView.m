//
//  ZCircleReleaseCloseView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleReleaseCloseView.h"

@interface ZCircleReleaseCloseView ()
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ZCircleReleaseCloseView


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
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [closeBtn setImage:[[UIImage imageNamed:@"lessonSelectClose"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    closeBtn.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    [closeBtn bk_addEventHandler:^(id sender) {
        if (self.backBlock) {
            self.backBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.width.height.mas_equalTo(CGFloatIn750(80));
       make.centerY.equalTo(self.mas_centerY);
       make.left.equalTo(self.mas_left).offset(CGFloatIn750(10));
    }];

    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(closeBtn.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(110));
        make.centerY.equalTo(self.mas_centerY);
    }];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont boldFontContent]];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
