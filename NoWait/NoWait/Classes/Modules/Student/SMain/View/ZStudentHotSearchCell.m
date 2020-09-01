//
//  ZStudentHotSearchCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/9/1.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentHotSearchCell.h"

@interface ZStudentHotSearchCell ()
@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZStudentHotSearchCell

- (void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.hintLabel];
    [self.contentView addSubview:self.contentLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(66));
        make.width.mas_equalTo(CGFloatIn750(350));
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30+20));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.width.mas_equalTo(CGFloatIn750(28));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hintLabel.mas_right).offset(CGFloatIn750(14));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(50));
    }];
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
        _hintLabel.text = @"热";
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        [_hintLabel setFont:[UIFont fontMin]];
        _hintLabel.backgroundColor = [UIColor colorRedForLabel];
        ViewRadius(_hintLabel, CGFloatIn750(4));
    }
    return _hintLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _contentLabel.text = @"奥科吉尴尬伤筋动骨";
        _contentLabel.numberOfLines = 1;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        [_contentLabel setFont:[UIFont fontContent]];
    }
    return _contentLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        ViewRadius(_backView, CGFloatIn750(8));
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _backView;
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    if ([data objectForKey:@"hint"]) {
        _hintLabel.text = data[@"hint"];
    }
    
    if ([data objectForKey:@"content"]) {
        _contentLabel.text = data[@"content"];
    }
    
    CGSize tempSize = [SafeStr(_contentLabel.text) tt_sizeWithFont:[UIFont fontContent] constrainedToSize:CGSizeMake(KScreenWidth - CGFloatIn750(90) - CGFloatIn750(50), CGFloatIn750(66))];
    
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(66));
        make.width.mas_equalTo(CGFloatIn750(80) + tempSize.width);
    }];
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(66);
}
@end
