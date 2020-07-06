//
//  ZHotListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZHotListItemCell.h"

@interface ZHotListItemCell ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *hotLabel;
@property (nonatomic,strong) UIImageView *hotImageView;


@end

@implementation ZHotListItemCell


- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.hotLabel];
    [self.backView addSubview:self.hotImageView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.backView.mas_centerY);
        make.right.lessThanOrEqualTo(self.backView.mas_right).offset(-CGFloatIn750(36));
    }];
    
    [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hotLabel.mas_centerY);
        make.left.equalTo(self.hotLabel.mas_right).offset(CGFloatIn750(12));
    }];
    
    self.hotLabel.text = @"水果可那是肯定给你";
}


#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = CGFloatIn750(12);
        
    }
    return _backView;
}


- (UILabel *)hotLabel {
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hotLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _hotLabel.numberOfLines = 1;
        _hotLabel.textAlignment = NSTextAlignmentLeft;
        [_hotLabel setFont:[UIFont fontContent]];
    }
    return _hotLabel;
}

- (UIImageView *)hotImageView {
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc] init];
        _hotImageView.image = [UIImage imageNamed:@"hotLesson"];
        _hotImageView.layer.masksToBounds = YES;
        _hotImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _hotImageView;
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake((KScreenWidth - CGFloatIn750(0))/2.0f-2, CGFloatIn750(60));
}
@end


