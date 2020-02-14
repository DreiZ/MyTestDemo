//
//  ZStudentLessonDetailPeoplesItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonDetailPeoplesItemCell.h"

@implementation ZStudentLessonDetailPeoplesItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    self.contentView.backgroundColor = KAdaptAndDarkColor([UIColor colorWhite], K1aBackColor);
    self.clipsToBounds = YES;
    
    
    [self.contentView addSubview:self.userImageView];
    
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *titelBack = [[UIView alloc] initWithFrame:CGRectZero];
    titelBack.backgroundColor = [UIColor colorWithRGB:0xffffff alpha:0.7];
    [self.contentView addSubview:titelBack];
    [titelBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.userImageView);
        make.height.mas_equalTo(CGFloatIn750(46));
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(titelBack);
    }];
}


- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = 4;
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _userImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KAdaptAndDarkColor(KFont3Color, KFont9Color);
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _titleLabel;
}

@end

