//
//  ZOrganizationLessonTPirceCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/24.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationLessonTPirceCell.h"

@interface ZOrganizationLessonTPirceCell ()
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *orderPriceLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *orderNumLabel;

@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UILabel *orderHintLabel;

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *orderBackView;
@end

@implementation ZOrganizationLessonTPirceCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.orderBackView];
    
    [self.orderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_centerX).offset(-CGFloatIn750(15));
        make.height.mas_equalTo(CGFloatIn750(42*4));
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(CGFloatIn750(15));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.height.mas_equalTo(CGFloatIn750(42*4));
    }];
    
    [self.orderBackView addSubview:self.orderPriceLabel];
    [self.orderBackView addSubview:self.orderNumLabel];
    [self.orderBackView addSubview:self.orderHintLabel];
    
    [self.backView addSubview:self.priceLabel];
    [self.backView addSubview:self.numLabel];
    [self.backView addSubview:self.hintLabel];
    
    [self.orderHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderBackView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.orderBackView.mas_top).offset(CGFloatIn750(18));
        make.right.equalTo(self.orderBackView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderBackView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.orderHintLabel.mas_bottom).offset(CGFloatIn750(12));
        make.right.equalTo(self.orderBackView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderBackView.mas_left).offset(CGFloatIn750(28));
        make.top.equalTo(self.orderPriceLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.orderBackView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.backView.mas_top).offset(CGFloatIn750(18));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(20));
        make.top.equalTo(self.hintLabel.mas_bottom).offset(CGFloatIn750(12));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(CGFloatIn750(28));
        make.top.equalTo(self.priceLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.backView.mas_right).offset(-CGFloatIn750(20));
    }];
}


#pragma mark -Getter
- (UILabel *)orderHintLabel {
    if (!_orderHintLabel) {
        _orderHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderHintLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        _orderHintLabel.text = @"体验课";
        [_orderHintLabel setFont:[UIFont boldFontTitle]];
    }
    return _orderHintLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldFontTitle]];
    }
    return _priceLabel;
}


- (UILabel *)orderPriceLabel {
    if (!_orderPriceLabel) {
        _orderPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderPriceLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        
        _orderPriceLabel.numberOfLines = 1;
        _orderPriceLabel.textAlignment = NSTextAlignmentLeft;
        [_orderPriceLabel setFont:[UIFont boldFontTitle]];
    }
    return _orderPriceLabel;
}


- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentLeft;
        [_numLabel setFont:[UIFont fontSmall]];
    }
    return _numLabel;
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        _hintLabel.text = @"正式课";
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentLeft;
        [_hintLabel setFont:[UIFont boldFontTitle]];
    }
    return _hintLabel;
}

- (UILabel *)orderNumLabel {
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderNumLabel.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
        
        _orderNumLabel.numberOfLines = 1;
        _orderNumLabel.textAlignment = NSTextAlignmentLeft;
        [_orderNumLabel setFont:[UIFont fontSmall]];
    }
    return _orderNumLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        ViewRadius(_backView, CGFloatIn750(12));
        _backView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _backView;
}

- (UIView *)orderBackView {
    if (!_orderBackView) {
        _orderBackView = [[UIView alloc] init];
        ViewRadius(_orderBackView, CGFloatIn750(12));
        _orderBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _orderBackView;
}

- (void)setModel:(ZOriganizationLessonDetailModel *)model {
    _model = model;
    
    if ([model.is_experience intValue] == 1) {
        self.orderBackView.hidden = NO;
        [self.orderBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
            make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
            make.right.equalTo(self.contentView.mas_centerX).offset(-CGFloatIn750(10));
            make.height.mas_equalTo(CGFloatIn750(42*4));
        }];
        
        [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX).offset(CGFloatIn750(10));
            make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
            make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
            make.height.mas_equalTo(CGFloatIn750(42*4));
        }];
        self.orderNumLabel.text = [NSString stringWithFormat:@"已售 %@",model.experience_pay_nums];
        self.orderPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.experience_price];
    }else{
        self.orderBackView.hidden = YES;
        [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
            make.top.equalTo(self.mas_top).offset(CGFloatIn750(30));
            make.right.equalTo(self.contentView.mas_centerX).offset(-CGFloatIn750(10));
            make.height.mas_equalTo(CGFloatIn750(42*4));
        }];
    }
    
    self.numLabel.text = [NSString stringWithFormat:@"已售 %@",model.ordinary_pay_nums];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(42 * 4) + CGFloatIn750(50);
}

@end


