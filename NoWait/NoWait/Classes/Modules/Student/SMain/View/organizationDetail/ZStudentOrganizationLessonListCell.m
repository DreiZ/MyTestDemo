//
//  ZStudentOrganizationLessonListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationLessonListCell.h"

@interface ZStudentOrganizationLessonListCell ()

@property (nonatomic,strong) UIImageView *lessonImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *favourablePriceLabel;
@property (nonatomic,strong) UILabel *goodReputationLabel;
@property (nonatomic,strong) UILabel *sellCountLabel;
@end

@implementation ZStudentOrganizationLessonListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KAdaptAndDarkColor(KWhiteColor, K1aBackColor);
    
    [self.contentView addSubview:self.lessonImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.favourablePriceLabel];
    [self.contentView addSubview:self.goodReputationLabel];
    [self.contentView addSubview:self.sellCountLabel];
    
    [self.lessonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(40));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(160));
        make.height.mas_equalTo(CGFloatIn750(120));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.lessonImageView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(120));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(10));
    }];
    
    [self.favourablePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.priceLabel.mas_bottom).offset(-3);
        make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(4));
    }];
    
    [self.goodReputationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.favourablePriceLabel.mas_bottom).offset(CGFloatIn750(12));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(120));
    }];
    
    [self.sellCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KAdaptAndDarkColor(KLineColor, K2eBackColor);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self.lessonImageView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
}


#pragma mark -Getter
-(UIImageView *)lessonImageView {
    if (!_lessonImageView) {
        _lessonImageView = [[UIImageView alloc] init];
        _lessonImageView.image = [UIImage imageNamed:@"wallhaven5"];
        _lessonImageView.contentMode = UIViewContentModeScaleAspectFill;
        _lessonImageView.clipsToBounds = YES;
        _lessonImageView.layer.cornerRadius = 3;
        _lessonImageView.layer.masksToBounds = YES;
    }
    
    return _lessonImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KAdaptAndDarkColor(KFont2Color, KFont9Color);
        _titleLabel.text = @"图形俱乐部";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
    }
    return _titleLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = KRedColor;
        _priceLabel.text = @"￥543";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _priceLabel;
}

- (UILabel *)favourablePriceLabel {
    if (!_favourablePriceLabel) {
        _favourablePriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _favourablePriceLabel.textColor = KAdaptAndDarkColor(KFont9Color, KFont6Color);
        _favourablePriceLabel.text = @"￥256";
        _favourablePriceLabel.numberOfLines = 1;
        _favourablePriceLabel.textAlignment = NSTextAlignmentRight;
        [_favourablePriceLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(20)]];
    }
    return _favourablePriceLabel;
}

- (UILabel *)goodReputationLabel {
    if (!_goodReputationLabel) {
        _goodReputationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodReputationLabel.textColor = KAdaptAndDarkColor(KFont9Color, KFont6Color);
        _goodReputationLabel.text = @"90%好评";
        _goodReputationLabel.numberOfLines = 1;
        _goodReputationLabel.textAlignment = NSTextAlignmentLeft;
        [_goodReputationLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(20)]];
    }
    return _goodReputationLabel;
}

- (UILabel *)sellCountLabel {
    if (!_sellCountLabel) {
        _sellCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _sellCountLabel.textColor = KAdaptAndDarkColor(KFont9Color, KFont6Color);
        _sellCountLabel.text = @"已售200>";
        _sellCountLabel.numberOfLines = 1;
        _sellCountLabel.textAlignment = NSTextAlignmentRight;
        [_sellCountLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(20)]];
    }
    return _sellCountLabel;
}



+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(200);
}
@end
