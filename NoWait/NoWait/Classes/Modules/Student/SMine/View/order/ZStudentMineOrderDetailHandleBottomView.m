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
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayBGDark]);
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
        make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.equalTo(self.bottomView);
        make.width.mas_equalTo(CGFloatIn750(180));
    }];
    
    [self.bottomView addSubview:self.payBtn];
    [self.bottomView addSubview:self.evaBtn];
    [self.bottomView addSubview:self.cancleBtn];
    [self.bottomView addSubview:self.delBtn];
    [self.bottomView addSubview:self.refuseBtn];
    [self.bottomView addSubview:self.receivedBtn];
    
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
        _payBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont fontContent]];
        _payBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewBorderRadius(_payBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_payBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        }];
    }
    return _payBtn;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        __weak typeof(self) weakSelf = self;
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_cancleBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_cancleBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_cancleBtn bk_whenTapped:^{
            [ZAlertView setAlertWithTitle:@"取消订单" subTitle:@"确定取消订单？" leftBtnTitle:@"不取消" rightBtnTitle:@"取消" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    if (weakSelf.handleBlock) {
                        weakSelf.handleBlock(1);
                    };
                }
            }];
            
        }];
    }
    return _cancleBtn;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        __weak typeof(self) weakSelf = self;
        _delBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_delBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_delBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_delBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_delBtn bk_whenTapped:^{
            [ZAlertView setAlertWithTitle:@"删除订单" subTitle:@"确定删除订单？删除订单后不可找回" leftBtnTitle:@"不删除" rightBtnTitle:@"删除" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    if (weakSelf.handleBlock) {
                        weakSelf.handleBlock(2);
                    };
                }
            }];
            
        }];
    }
    return _delBtn;
}


- (UIButton *)evaBtn {
    if (!_evaBtn) {
        __weak typeof(self) weakSelf = self;
        _evaBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_evaBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_evaBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_evaBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_evaBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_evaBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(3);
            };
        }];
    }
    return _evaBtn;
}


- (UIButton *)telBtn {
    if (!_telBtn) {
        _telBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _telBtn.layer.masksToBounds = YES;
//        [_telBtn setImage:[UIImage imageNamed:@"default_bigPhone_mainColor"] forState:UIControlStateNormal];
        _telBtn.imageView.size = CGSizeMake(CGFloatIn750(22), CGFloatIn750(28));
        [_telBtn setTitle:@"  联系商家" forState:UIControlStateNormal];
        [_telBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]) forState:UIControlStateNormal];
        [_telBtn.titleLabel setFont:[UIFont boldFontContent]];
        
        __weak typeof(self) weakSelf = self;
        [_telBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(101);
            }
        }];
        
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
        _refuseBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_refuseBtn setTitle:@"同意退款" forState:UIControlStateNormal];
        [_refuseBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_refuseBtn.titleLabel setFont:[UIFont fontContent]];
        _refuseBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewBorderRadius(_refuseBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_refuseBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(5);
            };
        }];
    }
    return _refuseBtn;
}

- (UIButton *)receivedBtn {
    if (!_receivedBtn) {
        __weak typeof(self) weakSelf = self;
        _receivedBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_receivedBtn setTitle:@"接受预约" forState:UIControlStateNormal];
        [_receivedBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_receivedBtn.titleLabel setFont:[UIFont fontContent]];
        _receivedBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
//        ViewBorderRadius(_receivedBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_receivedBtn bk_whenTapped:^{
            [ZAlertView setAlertWithTitle:@"小提示" subTitle:@"确定接受预约？" leftBtnTitle:@"不取消" rightBtnTitle:@"接受" handlerBlock:^(NSInteger index) {
                if (index == 1) {
                    if (weakSelf.handleBlock) {
                        weakSelf.handleBlock(4);
                    };
                }
            }];
        }];
    }
    return _receivedBtn;
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
        
        if (model.order_type == ZStudentOrderTypeOrderForReceived
            || model.order_type == ZStudentOrderTypeForRefundComplete
            || model.order_type == ZStudentOrderTypeHadEva
            || model.order_type == ZStudentOrderTypeOrderRefuse
            || model.order_type == ZStudentOrderTypeOrderComplete
            || model.order_type == ZStudentOrderTypeForRefund//退款
            || model.order_type == ZStudentOrderTypeRefundReceive//退款
            || model.order_type == ZStudentOrderTypeRefunding//退款中
            || model.order_type == ZStudentOrderTypeForRefundComplete) {
            [self.telBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.right.left.equalTo(self.bottomView);
                make.height.mas_equalTo(CGFloatIn750(88));
            }];
            
        }else if(model.order_type == ZStudentOrderTypeForRefund
                 || model.order_type == ZStudentOrderTypeRefundReceive
                 || model.order_type == ZStudentOrderTypeRefunding) {
            
            [self.telBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(0));
                make.top.bottom.equalTo(self.bottomView);
                make.width.mas_equalTo(CGFloatIn750(126));
            }];
            
            [self.telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.width.mas_equalTo(CGFloatIn750(31));
               make.height.mas_equalTo(CGFloatIn750(31));
               make.center.equalTo(self.telBtn);
            }];
            
            [_telBtn setTitle:@"" forState:UIControlStateNormal];
            _telImageView.tintColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        }else{
            
            [self.telBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bottomView.mas_left).offset(CGFloatIn750(20));
                make.top.bottom.equalTo(self.bottomView);
                make.width.mas_equalTo(CGFloatIn750(180));
            }];
        }
    }
    
    switch (model.order_type) {
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
            self.evaBtn.hidden = NO;
            
            [self.evaBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
        }
            break;
        case ZStudentOrderTypeOutTime:
        case ZStudentOrderTypeOrderOutTime:
        case ZStudentOrderTypeCancel:
        case ZOrganizationOrderTypeOutTime:
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
