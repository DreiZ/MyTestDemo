//
//  ZStudentMineOrderDetailHandleBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderDetailHandleBottomView.h"
#import "ZAlertView.h"

@interface ZStudentMineOrderDetailHandleBottomView ()
@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UIButton *telBtn;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UIButton *evaBtn;
@property (nonatomic,strong) UIButton *refuseBtn;
@property (nonatomic,strong) UIButton *receivedBtn;
@property (nonatomic,strong) UIImageView *telImageView;

@property (nonatomic,strong) UIButton *receivedNOBtn;
@property (nonatomic,strong) UIButton *refundSureBtn;//同意退款
@property (nonatomic,strong) UIButton *refundRefectBtn;//协商退款
@property (nonatomic,strong) UIButton *refundOSureBtn;//商家同意
@property (nonatomic,strong) UIButton *refundORefectBtn;//商家拒绝
@property (nonatomic,strong) UIButton *refundPayBtn;//商家拒绝
@property (nonatomic,strong) UILabel *statusLabel;


@property (nonatomic,strong) UIView *bottomView;

@end

@implementation ZStudentMineOrderDetailHandleBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(100));
        make.bottom.equalTo(self.mas_bottom).offset(-safeAreaBottom());
    }];
    [self.bottomView addSubview:self.telBtn];
    
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(0));
        make.top.bottom.equalTo(self.bottomView);
        make.width.mas_equalTo(CGFloatIn750(200));
    }];
    
    [self.bottomView addSubview:self.payBtn];
    [self.bottomView addSubview:self.evaBtn];
    [self.bottomView addSubview:self.cancleBtn];
    [self.bottomView addSubview:self.delBtn];
    [self.bottomView addSubview:self.refuseBtn];
    [self.bottomView addSubview:self.receivedBtn];
    
    [self.bottomView addSubview:self.receivedNOBtn];
    [self.bottomView addSubview:self.refundSureBtn];
    [self.bottomView addSubview:self.refundRefectBtn];
    [self.bottomView addSubview:self.refundOSureBtn];
    [self.bottomView addSubview:self.refundORefectBtn];
    [self.bottomView addSubview:self.refundPayBtn];
    [self.bottomView addSubview:self.statusLabel];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.receivedNOBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.refundSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.refundRefectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.refundOSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.refundORefectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.refundPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.evaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.refuseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    [self.receivedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_top);
    }];
    
    self.payBtn.hidden = YES;
    self.cancleBtn.hidden = YES;
    self.evaBtn.hidden = YES;
    self.delBtn.hidden = YES;
    self.refuseBtn.hidden =  YES;
    self.receivedBtn.hidden = YES;
    self.receivedNOBtn.hidden = YES;
    self.refundSureBtn.hidden = YES;
    self.refundRefectBtn.hidden = YES;
    self.refundOSureBtn.hidden = YES;
    self.refundORefectBtn.hidden = YES;
    self.refundPayBtn.hidden = YES;
    self.statusLabel.hidden = YES;
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        __weak typeof(self) weakSelf = self;
        _payBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont fontContent]];
        _payBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewBorderRadius(_payBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_payBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypePay);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        __weak typeof(self) weakSelf = self;
        _cancleBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_cancleBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_cancleBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_cancleBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeCancel);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        __weak typeof(self) weakSelf = self;
        _delBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_delBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_delBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_delBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_delBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeDelete);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}


- (UIButton *)evaBtn {
    if (!_evaBtn) {
        __weak typeof(self) weakSelf = self;
        _evaBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_evaBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_evaBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_evaBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_evaBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_evaBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeEva);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaBtn;
}


- (UIButton *)telBtn {
    if (!_telBtn) {
        _telBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        _telBtn.layer.masksToBounds = YES;
//        [_telBtn setImage:[UIImage imageNamed:@"default_bigPhone_mainColor"] forState:UIControlStateNormal];
        _telBtn.imageView.size = CGSizeMake(CGFloatIn750(22), CGFloatIn750(28));
        [_telBtn setTitle:@"  联系商家" forState:UIControlStateNormal];
        [_telBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_telBtn.titleLabel setFont:[UIFont boldFontContent]];
        _telBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        __weak typeof(self) weakSelf = self;
        [_telBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeTel);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_telBtn addSubview:self.telImageView];
        [self.telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.mas_equalTo(CGFloatIn750(22));
           make.height.mas_equalTo(CGFloatIn750(28));
           make.right.equalTo(self.telBtn.titleLabel.mas_left);
           make.centerY.equalTo(self.telBtn.mas_centerY);
        }];
    }
    return _telBtn;
}

-(UIImageView *)telImageView {
    if (!_telImageView) {
        _telImageView = [[UIImageView alloc] init];
        _telImageView.image = [[UIImage imageNamed:@"default_bigPhone_mainColor"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _telImageView.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }
    return _telImageView;
}
- (UIButton *)refuseBtn {
    if (!_refuseBtn) {
        __weak typeof(self) weakSelf = self;
        _refuseBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refuseBtn setTitle:@"同意退款" forState:UIControlStateNormal];
        [_refuseBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_refuseBtn.titleLabel setFont:[UIFont fontContent]];
        _refuseBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewBorderRadius(_refuseBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_refuseBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeORefund);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refuseBtn;
}

- (UIButton *)receivedBtn {
    if (!_receivedBtn) {
        __weak typeof(self) weakSelf = self;
        _receivedBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_receivedBtn setTitle:@"接受预约" forState:UIControlStateNormal];
        [_receivedBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_receivedBtn.titleLabel setFont:[UIFont fontContent]];
        _receivedBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
//        ViewBorderRadius(_receivedBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_receivedBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeOrderReceive);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _receivedBtn;
}


- (UIButton *)receivedNOBtn {
    if (!_receivedNOBtn) {
        __weak typeof(self) weakSelf = self;
        _receivedNOBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_receivedNOBtn setTitle:@"拒绝预约" forState:UIControlStateNormal];
        [_receivedNOBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_receivedNOBtn.titleLabel setFont:[UIFont boldFontContent]];
        ViewBorderRadius(_receivedNOBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_receivedNOBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeOrderNOReceive);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _receivedBtn;
}

- (UIButton *)refundSureBtn {
    if (!_refundSureBtn) {
        __weak typeof(self) weakSelf = self;
        _refundSureBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refundSureBtn setTitle:@"接受退款" forState:UIControlStateNormal];
        [_refundSureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_refundSureBtn.titleLabel setFont:[UIFont boldFontContent]];
        _refundSureBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_refundSureBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeSRefund);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundSureBtn;
}

- (UIButton *)refundRefectBtn {
    if (!_refundRefectBtn) {
        __weak typeof(self) weakSelf = self;
        _refundRefectBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refundRefectBtn setTitle:@"协商退款" forState:UIControlStateNormal];
        [_refundRefectBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_refundRefectBtn.titleLabel setFont:[UIFont boldFontContent]];
        _refundRefectBtn.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        [_refundRefectBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeSRefundReject);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundRefectBtn;
}


- (UIButton *)refundOSureBtn {
    if (!_refundOSureBtn) {
        __weak typeof(self) weakSelf = self;
        _refundOSureBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refundOSureBtn setTitle:@"同意退款" forState:UIControlStateNormal];
        [_refundOSureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_refundOSureBtn.titleLabel setFont:[UIFont boldFontContent]];
        _refundOSureBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_refundOSureBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeORefund);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundOSureBtn;
}


- (UIButton *)refundORefectBtn {
    if (!_refundORefectBtn) {
        __weak typeof(self) weakSelf = self;
        _refundORefectBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refundORefectBtn setTitle:@"协商退款" forState:UIControlStateNormal];
        [_refundORefectBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_refundORefectBtn.titleLabel setFont:[UIFont boldFontContent]];
        _refundORefectBtn.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        [_refundORefectBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeORefundReject);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundORefectBtn;
}


- (UIButton *)refundPayBtn {
    if (!_refundPayBtn) {
        __weak typeof(self) weakSelf = self;
        _refundPayBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refundPayBtn setTitle:@"支付退款" forState:UIControlStateNormal];
        [_refundPayBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_refundPayBtn.titleLabel setFont:[UIFont boldFontContent]];
        _refundPayBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_refundPayBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeRefundPay);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundPayBtn;
}


- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _statusLabel.text = @"";
        _statusLabel.numberOfLines = 1;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [_statusLabel setFont:[UIFont boldFontContent]];
        _statusLabel.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    }
    return _statusLabel;
}


#pragma mark - set model
- (void)setModel:(ZOrderDetailModel *)model {
    _model = model;
    
    self.payBtn.hidden = YES;
    self.cancleBtn.hidden = YES;
    self.evaBtn.hidden = YES;
    self.delBtn.hidden = YES;
    self.refuseBtn.hidden =  YES;
    self.receivedBtn.hidden = YES;
    self.telBtn.hidden = YES;
    self.receivedNOBtn.hidden = YES;
    self.refundSureBtn.hidden = YES;
    self.refundRefectBtn.hidden = YES;
    self.refundOSureBtn.hidden = YES;
    self.refundORefectBtn.hidden = YES;
    self.refundPayBtn.hidden = YES;
    self.statusLabel.hidden = YES;

    
    if (model.isStudent) {
        self.telBtn.hidden = NO;
        [_telBtn setTitle:@"  联系商家" forState:UIControlStateNormal];
        _telImageView.image = [[UIImage imageNamed:@"default_bigPhone_mainColor"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _telImageView.tintColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        [self.telImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.width.mas_equalTo(CGFloatIn750(22));
           make.height.mas_equalTo(CGFloatIn750(28));
           make.right.equalTo(self.telBtn.titleLabel.mas_left);
           make.centerY.equalTo(self.telBtn.mas_centerY);
        }];
        
        if (model.isRefund) {
            [self.telBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(0));
                make.top.bottom.equalTo(self.bottomView);
                make.width.mas_equalTo(CGFloatIn750(126));
            }];
            
            [self.telImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
               make.width.mas_equalTo(CGFloatIn750(31));
               make.height.mas_equalTo(CGFloatIn750(31));
               make.center.equalTo(self.telBtn);
            }];
            
            [_telBtn setTitle:@"" forState:UIControlStateNormal];
            _telImageView.tintColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
            if ([model.refund_status intValue] == 2) {
                self.refundSureBtn.hidden = NO;
                self.refundRefectBtn.hidden = NO;
                [self.refundSureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.right.bottom.equalTo(self.bottomView);
                    make.width.mas_equalTo(CGFloatIn750(384));
                }];
                [self.refundRefectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(self.bottomView);
                    make.left.equalTo(self.telBtn.mas_right);
                    make.right.equalTo(self.refundSureBtn.mas_left);
                }];
            }else{
                self.statusLabel.hidden = NO;
                [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.right.bottom.equalTo(self.bottomView);
                    make.left.equalTo(self.telBtn.mas_right);
                }];
                if ([model.refund_status intValue] == 1){
                    self.statusLabel.text = @"已申请，待商家确认";
                }else if ([model.refund_status intValue] == 3){
                    self.statusLabel.text = @"已拒绝，待商家确认";
                }else if ([model.refund_status intValue] == 4){
                    self.statusLabel.text = @"已同意商家提议金额，待商家退款";
                }else if ([model.refund_status intValue] == 5){
                    self.statusLabel.text = @"商家已同意，待商家退款";
                }else if ([model.refund_status intValue] == 6){
                    self.statusLabel.text = @"已取消退款";
                }else if ([model.refund_status intValue] == 7){
                    self.statusLabel.text = @"退款已完成";
                }else{
                    self.statusLabel.hidden = YES;
                }
            }
        }else{
            if (model.order_type == ZStudentOrderTypeOrderForReceived
                || model.order_type == ZStudentOrderTypeHadEva
                || model.order_type == ZStudentOrderTypeOrderRefuse
                || model.order_type == ZStudentOrderTypeOrderComplete
                || (model.order_type == ZStudentOrderTypeHadPay && [model.can_comment intValue] != 1)) {
                
                [self.telBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.right.left.equalTo(self.bottomView);
                    make.height.mas_equalTo(CGFloatIn750(88));
                }];
                
            }else{
                [self.telBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(0));
                    make.top.bottom.equalTo(self.bottomView);
                    make.width.mas_equalTo(CGFloatIn750(200));
                }];
            }
            [self setNormalState];
        }
    }else{
        if (model.isRefund) {
            //状态：1：学员申请 2：商家拒绝 3：学员拒绝 4：学员同意 5：商家同意 6:学员取消 7：商家支付成功
            if ([model.refund_status intValue] == 1 || [model.refund_status intValue] == 3) {
                self.refundOSureBtn.hidden = NO;
                self.refundORefectBtn.hidden = NO;
                [self.refundOSureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.right.bottom.equalTo(self.bottomView);
                    make.left.equalTo(self.bottomView.mas_centerX);
                }];
                [self.refundORefectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self.bottomView);
                    make.right.equalTo(self.bottomView.mas_centerX);
                }];
            }else if ([model.refund_status intValue] == 4 || [model.refund_status intValue] == 5){
                self.refundPayBtn.hidden = NO;
                [self.refundPayBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.right.bottom.equalTo(self.bottomView);
                }];
            }else if ([model.refund_status intValue] == 2 || [model.refund_status intValue] == 6 || [model.refund_status intValue] == 7){
                
                self.statusLabel.hidden = NO;
                [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.right.bottom.equalTo(self.bottomView);
                }];
                if ([model.refund_status intValue] == 2) {
                    self.statusLabel.text = @"已拒绝学员退款，待学员确认";
                }else if ([model.refund_status intValue] == 6) {
                    self.statusLabel.text = @"学员已取消退款";
                }else if ([model.refund_status intValue] == 7) {
                    self.statusLabel.text = @"退款已完成";
                }
                
            }else {
                self.statusLabel.hidden = YES;
            }
        }else{
            [self setNormalState];
        }
    }
}

- (void)setNormalState {
    switch (self.model.order_type) {
        case ZStudentOrderTypeOrderForPay:
        case ZStudentOrderTypeForPay: //待付款（去支付，取消）
        {
            self.payBtn.hidden = NO;
            self.cancleBtn.hidden = NO;
            
            [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(142));
            }];
            
            [self.cancleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.payBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        case ZStudentOrderTypeHadPay:
        {
            if ([self.model.can_comment intValue] == 1) {
                self.evaBtn.hidden = NO;
                
                [self.evaBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.bottomView.mas_centerY);
                    make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                    make.height.mas_equalTo(CGFloatIn750(56));
                    make.width.mas_equalTo(CGFloatIn750(116));
                }];
            }
        }
            break;
        case ZStudentOrderTypeOutTime:
//        case ZStudentOrderTypeOrderOutTime:
        case ZStudentOrderTypeCancel:
//        case ZOrganizationOrderTypeOutTime:
        case ZOrganizationOrderTypeCancel:
        {
            self.delBtn.hidden = NO;
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        case ZStudentOrderTypeOrderRefuse:
        {
            self.payBtn.hidden = YES;
            self.cancleBtn.hidden = YES;
            
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = YES;
            
        }
            break;
        case ZOrganizationOrderTypeOrderRefuse:
        {
            self.refuseBtn.hidden = NO;
            
            [self.refuseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        case ZOrganizationOrderTypeOrderForReceived:
        {
            self.receivedBtn.hidden = NO;
            
            [self.receivedBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.bottomView);
                make.height.mas_equalTo(CGFloatIn750(88));
            }];
        }
            break;
        default:
            break;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_evaBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    ViewBorderRadius(_refuseBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    ViewBorderRadius(_cancleBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    
}
@end
