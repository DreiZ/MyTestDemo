//
//  ZOrganizationLessonDetailPriceCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonDetailPriceCell.h"

@interface ZOrganizationLessonDetailPriceCell ()

@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *priceHintLabel;
@property (nonatomic,strong) UILabel *numLabel;

@property (nonatomic,strong) UIImageView *numHintImageView;

@end

@implementation ZOrganizationLessonDetailPriceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    [self.contentView addSubview:self.priceHintLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.numHintImageView];
    [self.contentView addSubview:self.numLabel];
    
    [self.priceHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY).offset(CGFloatIn750(4));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceHintLabel.mas_right);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.numHintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_left).offset(-CGFloatIn750(12));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}


#pragma mark -Getter
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMain]);
        _priceLabel.text = @"140";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont fontContent]];
    }
    return _priceLabel;
}


- (UILabel *)priceHintLabel {
    if (!_priceHintLabel) {
        _priceHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceHintLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMain]);
        _priceHintLabel.text = @"￥";
        _priceHintLabel.numberOfLines = 1;
        _priceHintLabel.textAlignment = NSTextAlignmentCenter;
        [_priceHintLabel setFont:[UIFont fontSmall]];
    }
    return _priceHintLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _numLabel.text = @"30人";
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [_numLabel setFont:[UIFont fontSmall]];
    }
    return _numLabel;
}


- (UIImageView *)numHintImageView {
    if (!_numHintImageView) {
        _numHintImageView = [[UIImageView alloc] init];
        _numHintImageView.image = [[UIImage imageNamed:@"mineSetting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _numHintImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _numHintImageView.layer.masksToBounds = YES;
        _numHintImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _numHintImageView;
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(90);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    _numHintImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
}
@end

