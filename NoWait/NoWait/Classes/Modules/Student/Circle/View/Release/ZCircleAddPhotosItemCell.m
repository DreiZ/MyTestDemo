//
//  ZCircleAddPhotosItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleAddPhotosItemCell.h"

@interface ZCircleAddPhotosItemCell ()
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZCircleAddPhotosItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

- (void)initMainView {
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    self.clipsToBounds = YES;
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = adaptAndDarkColor([UIColor colorWithHexString:@"bbbbbb"], [UIColor colorWithHexString:@"999999"]);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(CGFloatIn750(4));
        make.width.mas_equalTo(CGFloatIn750(48));
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = adaptAndDarkColor([UIColor colorWithHexString:@"bbbbbb"], [UIColor colorWithHexString:@"999999"]);
    [self.contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(CGFloatIn750(4));
        make.height.mas_equalTo(CGFloatIn750(48));
    }];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
        ViewRadius(_backView, CGFloatIn750(8));
    }
    return _backView;
}

+ (CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(CGFloatIn750(213), CGFloatIn750(214));
}
@end
