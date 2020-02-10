//
//  ZStudentOrganizationDetailDesCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationDetailDesCell.h"

@interface ZStudentOrganizationDetailDesCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *businessHoursLabel;
@property (nonatomic,strong) UIView *introductionView;
@property (nonatomic,strong) UIView *activityView;

@end

@implementation ZStudentOrganizationDetailDesCell

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
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.businessHoursLabel];
    [self.contentView addSubview:self.addressLabel];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(40));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(40));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.titleLabel.mas_left);
           make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(16));
           make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
    }];
    
    [self.businessHoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(CGFloatIn750(16));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
    }];
    
   [self.contentView addSubview:self.introductionView ];
   [self.introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.titleLabel.mas_left);
       make.top.equalTo(self.businessHoursLabel.mas_bottom).offset(CGFloatIn750(18));
       make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
       make.height.mas_equalTo(CGFloatIn750(30));
   }];
    
    [self.contentView addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.introductionView.mas_bottom).offset(CGFloatIn750(18));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(30));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = KAdaptAndDarkColor(KLineColor, K2eBackColor);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self setActivityData];
}


#pragma mark -Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = KAdaptAndDarkColor(KFont2Color, KFont9Color);
        _titleLabel.text = @"图形俱乐部";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(36)]];
    }
    return _titleLabel;
}


- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = KAdaptAndDarkColor(KFont9Color, KFont6Color);
        _addressLabel.text = @"泉山区建国西路锦绣家园7路 0233-2342352";
        _addressLabel.numberOfLines = 0;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _addressLabel;
}



- (UILabel *)businessHoursLabel {
    if (!_businessHoursLabel) {
        _businessHoursLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _businessHoursLabel.textColor = KAdaptAndDarkColor(KFont9Color, KFont6Color);
        _businessHoursLabel.text = @"营业时间：09:00-21:30";
        _businessHoursLabel.numberOfLines = 1;
        _businessHoursLabel.textAlignment = NSTextAlignmentLeft;
        [_businessHoursLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _businessHoursLabel;
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
    return CGFloatIn750(280);
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
    
    NSArray *text1Arr = @[@"满减10", @"收单优惠"];
    
    CGFloat leftX1= 0;
    for (int i = 0; i < text1Arr.count; i++) {
        UIView *label = [self getViewWithText:text1Arr[i] leftX:leftX1];
        [self.introductionView addSubview:label];
        leftX1 = label.right + CGFloatIn750(8);
    }
}

- (UIView *)getViewWithText:(NSString *)text leftX:(CGFloat)leftX{
     CGSize tempSize = [text tt_sizeWithFont:[UIFont systemFontOfSize:CGFloatIn750(28)] constrainedToSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
    
    UILabel *actLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, 0, tempSize.width+6, CGFloatIn750(30))];
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
