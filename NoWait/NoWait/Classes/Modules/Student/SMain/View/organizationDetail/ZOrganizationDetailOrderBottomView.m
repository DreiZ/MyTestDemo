//
//  ZOrganizationDetailOrderBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationDetailOrderBottomView.h"

@interface ZOrganizationDetailOrderBottomView ()
@property (nonatomic,strong) UILabel *numLabel;

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
        make.left.equalTo(self.orderView.mas_right).offset(CGFloatIn750(0));
    }];
    
    [self.orderView addSubview:self.hintLabel];
    [self.orderView addSubview:self.numLabel];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.orderView.mas_centerY).offset(-CGFloatIn750(1));
        make.centerX.equalTo(self.orderView.mas_centerX);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_centerY).offset(CGFloatIn750(1));
        make.centerX.equalTo(self.orderView.mas_centerX);
    }];
    
    [self.orderView addSubview:self.orderBtn];
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.orderView);
    }];
    
    UIView *heightLineView = [[UIView alloc] init];
    heightLineView.backgroundColor = [UIColor colorWhite];
    [self.orderView addSubview:heightLineView];
    [heightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(3));
        make.height.mas_equalTo(CGFloatIn750(30));
        make.centerY.equalTo(self.orderView.mas_centerY);
        make.right.equalTo(self.orderView.mas_right);
    }];
}

- (UIButton *)orderBtn {
    if (!_orderBtn) {
        __weak typeof(self) weakSelf = self;
        _orderBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_orderBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(3);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderBtn;
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
        [_numLabel setFont:[UIFont boldFontSmall]];
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
        [_hintLabel setFont:[UIFont boldFontSmall]];
    }
    return _hintLabel;
}

- (void)setOrderPrice:(NSString *)orderPrice {
    _orderPrice = orderPrice;
    _numLabel.text = [NSString stringWithFormat:@"￥%@",orderPrice];
}


- (void)setIsExperience:(BOOL)isExperience {
    _isExperience = isExperience;
    if (isExperience) {
        [self.orderView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.backView);
            make.left.equalTo(self.collectionBtn.mas_right);
            make.width.equalTo(self.handleBtn.mas_width);
        }];
        
        [self.handleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self.backView);
            make.left.equalTo(self.orderView.mas_right).offset(CGFloatIn750(0));
        }];
        self.orderView.hidden = NO;
    }else{
        self.orderView.hidden = YES;
        
        [self.handleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self.backView);
            make.left.equalTo(self.collectionBtn.mas_right).offset(CGFloatIn750(0));
        }];
    }
}
@end
