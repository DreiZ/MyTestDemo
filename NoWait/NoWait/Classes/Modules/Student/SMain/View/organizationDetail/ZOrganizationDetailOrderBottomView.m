//
//  ZOrganizationDetailOrderBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationDetailOrderBottomView.h"

@interface ZOrganizationDetailOrderBottomView ()
@property (nonatomic,strong) UIView *orderView;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *hintLabel;
@end

@implementation ZOrganizationDetailOrderBottomView
- (void)initMainView {
    [super initMainView];
    [self.backView addSubview:self.orderView];
    
    [self.telBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.backView);
        make.width.mas_equalTo(CGFloatIn750(128));
    }];
    
    [self.collectionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.backView);
        make.left.equalTo(self.telBtn.mas_right);
        make.width.mas_equalTo(CGFloatIn750(128));
    }];
    
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.backView);
        make.left.equalTo(self.collectionBtn.mas_right);
        make.width.mas_equalTo(CGFloatIn750(200));
    }];
    
    [self.handleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.backView);
        make.left.equalTo(self.orderView.mas_right).offset(CGFloatIn750(4));
    }];
    
    [self.orderView addSubview:self.hintLabel];
    [self.orderView addSubview:self.numLabel];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.orderView.mas_centerY).offset(-CGFloatIn750(2));
        make.centerX.equalTo(self.orderView.mas_centerX);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_centerY).offset(CGFloatIn750(2));
        make.centerX.equalTo(self.orderView.mas_centerX);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *orderBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [orderBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(3);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:orderBtn];
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.orderView);
    }];
}

- (UIView *)orderView {
    if (!_orderView) {
        _orderView = [[UIView alloc] init];
        _orderView.backgroundColor = [UIColor colorMain];
    }
    return _orderView;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [_numLabel setFont:[UIFont fontSmall]];
    }
    return _numLabel;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _hintLabel.numberOfLines = 1;
        _hintLabel.text = @"预约体验";
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        [_hintLabel setFont:[UIFont fontSmall]];
    }
    return _hintLabel;
}

- (void)setOrderPrice:(NSString *)orderPrice {
    _orderPrice = orderPrice;
    _numLabel.text = [NSString stringWithFormat:@"￥%@",orderPrice];
}
@end
