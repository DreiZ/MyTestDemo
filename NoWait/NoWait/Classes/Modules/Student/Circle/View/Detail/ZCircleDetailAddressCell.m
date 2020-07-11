//
//  ZCircleDetailAddressCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleDetailAddressCell.h"

@interface ZCircleDetailAddressCell ()
@property (nonatomic,strong) UIView *addressBackView;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *distanceLabel;

@property (nonatomic,strong) UIImageView *addressImageView;
@end

@implementation ZCircleDetailAddressCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.addressBackView];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.addressImageView];
    
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(18));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImageView.mas_right).offset(CGFloatIn750(8));
        make.centerY.equalTo(self.addressImageView.mas_centerY);
        make.width.mas_lessThanOrEqualTo((KScreenWidth - CGFloatIn750(120))/2.0);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(CGFloatIn750(14));
        make.centerY.equalTo(self.addressImageView.mas_centerY);
    }];
    
    [self.addressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImageView.mas_left).offset(-CGFloatIn750(10));
        make.right.equalTo(self.distanceLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.addressImageView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(32));
    }];
}

- (UIView *)addressBackView {
    if (!_addressBackView) {
        _addressBackView = [[UIView alloc] init];
        _addressBackView.layer.masksToBounds = YES;
        ViewBorderRadius(_addressBackView, CGFloatIn750(16), 1, [UIColor colorMain]);
        _addressBackView.backgroundColor = [UIColor colorMainSub];
    }
    return _addressBackView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont fontMin]];
    }
    return _addressLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _distanceLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        _distanceLabel.numberOfLines = 1;
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        [_distanceLabel setFont:[UIFont fontMin]];
    }
    return _distanceLabel;
}

- (UIImageView *)addressImageView {
    if (!_addressImageView) {
        _addressImageView = [[UIImageView alloc] init];
        _addressImageView.contentMode = UIViewContentModeScaleAspectFill;
        _addressImageView.image = [UIImage imageNamed:@"finderLocationGreen"];
    }
    return _addressImageView;
}

- (void)setModel:(ZCircleDynamicInfo *)model {
    _model = model;
    
    self.addressLabel.text = model.address;
    self.distanceLabel.text = model.show_distance;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(72);
}
@end
