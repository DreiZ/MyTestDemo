//
//  ZReflectHintTopCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZReflectHintTopCell.h"

@interface ZReflectHintTopCell ()
@property (nonatomic,strong) UILabel *hintLabel;

@end

@implementation ZReflectHintTopCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    {
        UIView *one1 = [[UIView alloc] init];
        
        one1.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        one1.transform = CGAffineTransformMakeRotation(0.32);
        ViewRadius(one1, CGFloatIn750(8));
        [self.contentView addSubview:one1];
        [one1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(16));
            make.height.mas_equalTo(CGFloatIn750(20));
            make.right.equalTo(self.hintLabel.mas_left).offset(-CGFloatIn750(30));
            make.centerY.equalTo(self.hintLabel.mas_centerY);
        }];
        
        UIView *one2 = [[UIView alloc] init];
        
        one2.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(one2, CGFloatIn750(6));
        one2.transform = CGAffineTransformMakeRotation(0.32);
        [self.contentView addSubview:one2];
        [one2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(12));
            make.height.mas_equalTo(CGFloatIn750(16));
            make.right.equalTo(one1.mas_left).offset(-CGFloatIn750(6));
            make.centerY.equalTo(self.hintLabel.mas_centerY);
        }];
    }
    
    {
        UIView *one1 = [[UIView alloc] init];
        
        one1.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        one1.transform = CGAffineTransformMakeRotation(0.32);
        ViewRadius(one1, CGFloatIn750(8));
        [self.contentView addSubview:one1];
        [one1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(16));
            make.height.mas_equalTo(CGFloatIn750(20));
            make.left.equalTo(self.hintLabel.mas_right).offset(CGFloatIn750(30));
            make.centerY.equalTo(self.hintLabel.mas_centerY);
        }];
        
        UIView *one2 = [[UIView alloc] init];
        one2.transform = CGAffineTransformMakeRotation(0.32);
        one2.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        ViewRadius(one2, CGFloatIn750(6));
        [self.contentView addSubview:one2];
        [one2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(12));
            make.height.mas_equalTo(CGFloatIn750(16));
            make.left.equalTo(one1.mas_right).offset(CGFloatIn750(6));
            make.centerY.equalTo(self.hintLabel.mas_centerY);
        }];
    }
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _hintLabel.text = @"奖励说明";
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        [_hintLabel setFont:[UIFont fontContent]];
    }
    return _hintLabel;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(30);
}
@end
