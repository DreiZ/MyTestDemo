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
@property (nonatomic,strong) UILabel *priceHintLabel;

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
    
    
    
    [self.backView addSubview:self.priceHintLabel];
    [self.priceHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(40));
        make.width.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceHintLabel.mas_right);
        make.bottom.equalTo(self.priceHintLabel.mas_bottom).offset(CGFloatIn750(10));
        make.width.mas_equalTo(CGFloatIn750(120));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(10));
           make.centerY.equalTo(self.priceLabel.mas_centerY);
           make.right.equalTo(bottomLineView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceHintLabel.mas_left);
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
            weakSelf.handleBlock(self.model);
        }
    }];
    [self.backView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backView);
    }];
}


#pragma mark -Getter
- (UILabel *)priceHintLabel {
    if (!_priceHintLabel) {
        _priceHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceHintLabel.textColor = [UIColor colorRedForLabel];
        _priceHintLabel.text = @"￥";
        [_priceHintLabel setFont:[UIFont boldFontSmall]];
    }
    return _priceHintLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
        
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setAdjustsFontSizeToFitWidth:YES];
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(50)]];
    }
    return _priceLabel;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
        
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

- (void)setModel:(ZOriganizationCardListModel *)model {
    _model = model;
    if ([model.limit_end intValue] == 0) {
        _timeLabel.text = [NSString stringWithFormat:@"有效期：%@",@"无时间限制"];
    }else{
        _timeLabel.text = [NSString stringWithFormat:@"有效期：%@至%@",[model.limit_start timeStringWithFormatter:@"yyyy-MM-dd"],[model.limit_end timeStringWithFormatter:@"yyyy-MM-dd"]];
    }
    
    _manLabel.text = [NSString stringWithFormat:@"满%@可用",model.min_amount];
    _nameLabel.text = model.title;
    _priceLabel.text = model.amount;
    if (model.isUse) {
        _handleLabel.text = @"立即使用";
    }else{
        _handleLabel.text = @"立即领取";
        if ([model.received intValue] == 0) {
            _handleLabel.text = @"已领取";
            _manLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
            _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);;
            _priceLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
            _handleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
            _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
            _priceHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
            _backView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        }else{
            _manLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
            _nameLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);;
            _priceLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
            _handleLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
            _timeLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
            _priceHintLabel.textColor = adaptAndDarkColor([UIColor colorRedForLabel], [UIColor colorRedForLabel]);
            _backView.backgroundColor = [UIColor colorRedForLabelSub];
        }
    }
    
    
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(160);
}

@end

