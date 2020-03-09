//
//  ZStudentOrganizationCouponCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationCouponCell.h"

@interface ZStudentOrganizationCouponCell ()
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *manLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *handleLabel;
@property (nonatomic,strong) UIView *backView;

@end

@implementation ZStudentOrganizationCouponCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(140));
    }];
    
    [self.backView addSubview:self.priceLabel];
    [self.backView addSubview:self.manLabel];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.manLabel];
    [self.backView addSubview:self.handleLabel];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayBGDark]);
    [self.backView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.backView);
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(192));
        make.width.mas_equalTo(0.5);
    }];
    
    
    UILabel *priceHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    priceHintLabel.textColor = [UIColor colorRedForLabel];
    priceHintLabel.text = @"￥";
    [priceHintLabel setFont:[UIFont fontSmall]];
    [self.backView addSubview:priceHintLabel];
    [priceHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(40));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceHintLabel.mas_right);
        make.bottom.equalTo(priceHintLabel.mas_bottom).offset(CGFloatIn750(10));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(10));
           make.centerY.equalTo(self.priceLabel.mas_centerY);
           make.right.equalTo(bottomLineView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceHintLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(16));
        make.right.equalTo(self.priceLabel.mas_right);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(10));
        make.centerY.equalTo(self.manLabel.mas_centerY);
        make.right.equalTo(bottomLineView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.handleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomLineView.mas_left);
        make.centerY.equalTo(self.backView.mas_centerY);
        make.right.equalTo(self.backView.mas_right);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *allBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [allBtn bk_whenTapped:^{
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    }];
    [self.backView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backView);
    }];
}


#pragma mark -Getter
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
        _priceLabel.text = @"40";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(50)]];
    }
    return _priceLabel;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
        _nameLabel.text = @"泉山区建国西路锦绣家园7路";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
        [_nameLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _nameLabel;
}


- (UILabel *)manLabel {
    if (!_manLabel) {
        _manLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _manLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
        _manLabel.text = @"满400可用地方还是";
        _manLabel.numberOfLines = 1;
        _manLabel.textAlignment = NSTextAlignmentLeft;
        [_manLabel setFont:[UIFont fontMin]];
        [_manLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _manLabel;
}


- (UILabel *)handleLabel {
    if (!_handleLabel) {
        _handleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _handleLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
        _handleLabel.text = @"立即领取";
        _handleLabel.numberOfLines = 1;
        _handleLabel.textAlignment = NSTextAlignmentCenter;
        [_handleLabel setFont:[UIFont fontContent]];
    }
    return _handleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
        _timeLabel.text = @"营业时间：09:00-21:30";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontMin]];
        [_timeLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _timeLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        ViewRadius(_backView, CGFloatIn750(20));
        _backView.backgroundColor = [UIColor colorRedForLabelSub];
    }
    return _backView;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(160);
}

@end

