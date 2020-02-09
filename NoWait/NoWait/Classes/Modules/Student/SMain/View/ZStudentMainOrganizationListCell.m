//
//  ZStudentMainOrganizationListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainOrganizationListCell.h"

@interface ZStudentMainOrganizationListCell ()

@property (nonatomic,strong) UIImageView *goodsImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *payPeopleNumLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIView *introductionView;
@property (nonatomic,strong) UIView *activityView;


@end

@implementation ZStudentMainOrganizationListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = KAdaptAndDarkColor(KWhiteColor,K1aBackColor);
    
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.payPeopleNumLabel];
    [self.contentView addSubview:self.addressLabel];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.width.height.mas_equalTo(CGFloatIn750(140));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.goodsImageView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.payPeopleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(120));
        make.centerY.equalTo(self.payPeopleNumLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.payPeopleNumLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
        make.height.mas_equalTo(CGFloatIn750(30));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KLineColor;
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self setActivityData];
}


#pragma mark -Getter
-(UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.image = [UIImage imageNamed:@"serverTopbg"];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        _goodsImageView.clipsToBounds = YES;
    }
    
    return _goodsImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KAdaptAndDarkColor(KFont2Color,KFont9Color);
        _titleLabel.text = @"图形俱乐部";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(32)]];
    }
    return _titleLabel;
}


- (UILabel *)payPeopleNumLabel {
    if (!_payPeopleNumLabel) {
        _payPeopleNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _payPeopleNumLabel.textColor = KAdaptAndDarkColor(KFont9Color,KFont6Color);
        _payPeopleNumLabel.text = @"300人已付款";
        _payPeopleNumLabel.numberOfLines = 1;
        _payPeopleNumLabel.textAlignment = NSTextAlignmentLeft;
        [_payPeopleNumLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
    }
    return _payPeopleNumLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = KAdaptAndDarkColor(KFont9Color,KFont6Color);
        _addressLabel.text = @"<1.3km";
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentRight;
        [_addressLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(20)]];
    }
    return _addressLabel;
}


- (UIView *)introductionView {
    if (!_introductionView) {
        _introductionView = [[UIView alloc] init];
        _introductionView.layer.masksToBounds = YES;
    }
    return _introductionView;
}

- (UIView *)activityView {
    if (!_activityView) {
        _activityView = [[UIView alloc] init];
        _activityView.layer.masksToBounds = YES;
    }
    return _activityView;
}



+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(200);
}


- (void)setActivityData {
    [self.activityView removeAllSubviews];
    NSArray *textArr = @[@"满减10", @"收单优惠"];
    
    CGFloat leftX = 0;
    for (int i = 0; i < textArr.count; i++) {
        UIView *label = [self getViewWithText:textArr[i] leftX:leftX];
        [self.activityView addSubview:label];
        leftX = label.right + CGFloatIn750(8);
    }
}

- (UIView *)getViewWithText:(NSString *)text leftX:(CGFloat)leftX{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(28)] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
    
    UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, 0, tempSize.width+6, CGFloatIn750(30))];
    actLabel.backgroundColor = KAdaptAndDarkColor(KWhiteColor,K2eBackColor);
    actLabel.textColor = kHN_OrangeHColor;
    actLabel.layer.masksToBounds = YES;
    actLabel.layer.cornerRadius = 2;
    actLabel.layer.borderColor = kHN_OrangeHColor.CGColor;
    actLabel.layer.borderWidth = 0.5;
    actLabel.text = text;
    actLabel.numberOfLines = 0;
    actLabel.textAlignment = NSTextAlignmentCenter;
    [actLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(20)]];
    
    
    return actLabel;
}
@end
