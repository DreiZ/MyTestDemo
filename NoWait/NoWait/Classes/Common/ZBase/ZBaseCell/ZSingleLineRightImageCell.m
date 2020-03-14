//
//  ZSingleLineRightImageCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSingleLineRightImageCell.h"

@interface ZSingleLineRightImageCell ()
@property (nonatomic,strong) UIImageView *midImageView;
@end


@implementation ZSingleLineRightImageCell
- (void)initMainView {
    [super initMainView];
    [self.contentView addSubview:self.midImageView];
    [self.midImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightTitleLabel.mas_left).offset(-CGFloatIn750(10));
        make.centerY.equalTo(self.rightTitleLabel.mas_centerY);
    }];
}

- (UIImageView *)midImageView {
    if (!_midImageView) {
        _midImageView = [[UIImageView alloc] init];
        _midImageView.image = [UIImage imageNamed:@"orderRigthtTel"];
        _midImageView.layer.masksToBounds = YES;
        _midImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _midImageView;
}

@end
