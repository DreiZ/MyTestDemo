//
//  ZStudentMineOrderDetailHandleBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderDetailHandleBottomView.h"

@interface ZStudentMineOrderDetailHandleBottomView ()
@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UIButton *telBtn;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UIButton *evaBtn;
@property (nonatomic,strong) UIButton *refuseBtn;
@property (nonatomic,strong) UIButton *receivedBtn;

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
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIView *contView = [[UIView alloc] init];
    self.bottomView = contView;
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(100));
        make.bottom.equalTo(self.mas_bottom).offset(-safeAreaBottom());
    }];
    [contView addSubview:self.telBtn];
    
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.equalTo(contView);
        make.width.mas_equalTo(CGFloatIn750(180));
    }];
    
    [self.bottomView addSubview:self.payBtn];
    [self.bottomView addSubview:self.evaBtn];
    [self.bottomView addSubview:self.cancleBtn];
    [self.bottomView addSubview:self.delBtn];
    [self.bottomView addSubview:self.refuseBtn];
    [self.bottomView addSubview:self.receivedBtn];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.evaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);;
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.refuseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.receivedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
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
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
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
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2);
            };
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
        [_telBtn setImage:[UIImage imageNamed:@"orderRigthtTel"] forState:UIControlStateNormal];
        [_telBtn setTitle:@"  联系商家" forState:UIControlStateNormal];
        [_telBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_telBtn.titleLabel setFont:[UIFont fontSmall]];
        
        __weak typeof(self) weakSelf = self;
        [_telBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(4);
            }
        }];
    }
    return _telBtn;
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
        ViewBorderRadius(_receivedBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_receivedBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(6);
            };
        }];
    }
    return _receivedBtn;
}

- (void)setModel:(ZStudentOrderListModel *)model {
    _model = model;
    
    self.payBtn.hidden = YES;
    self.cancleBtn.hidden = YES;
    self.evaBtn.hidden = YES;
    self.delBtn.hidden = YES;
    self.refuseBtn.hidden =  YES;
    self.receivedBtn.hidden = YES;
    
    switch (model.type) {
            case ZStudentOrderTypeOrderForPay:
        case ZStudentOrderTypeForPay: //待付款（去支付，取消）
        {
            self.payBtn.hidden = NO;
            self.cancleBtn.hidden = NO;
            
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = YES;
            
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
            self.payBtn.hidden = YES;
            self.cancleBtn.hidden = YES;
            
            self.evaBtn.hidden = NO;
            self.delBtn.hidden = NO;
            
            
            [self.evaBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(116));
            }];
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.evaBtn.mas_left).offset(CGFloatIn750(-20));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        case ZStudentOrderTypeHadEva:
        {
            self.payBtn.hidden = YES;
            self.cancleBtn.hidden = YES;
            
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = NO;
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
            
        }
            break;
        case ZStudentOrderTypeOutTime:
        {
            self.payBtn.hidden = YES;
            self.cancleBtn.hidden = YES;
            
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = NO;
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
            
        }
            break;
        case ZStudentOrderTypeCancel:
        {
            self.payBtn.hidden = YES;
            self.cancleBtn.hidden = YES;
            
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = NO;
            
            [self.delBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
            
        }
            break;
        case ZStudentOrderTypeOrderForReceived:
        {
            self.payBtn.hidden = YES;
            self.cancleBtn.hidden = YES;
            
            self.evaBtn.hidden = YES;
            self.delBtn.hidden = YES;
        }
            break;
        case ZStudentOrderTypeOrderComplete:
        {
            self.payBtn.hidden = YES;
            self.cancleBtn.hidden = YES;
            
            self.evaBtn.hidden = YES;
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
                make.centerY.equalTo(self.bottomView.mas_centerY);
                make.right.equalTo(self.bottomView.mas_right).offset(CGFloatIn750(-30));
                make.height.mas_equalTo(CGFloatIn750(56));
                make.width.mas_equalTo(CGFloatIn750(172));
            }];
        }
            break;
        default:
            break;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_payBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    ViewBorderRadius(_evaBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    ViewBorderRadius(_refuseBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    ViewBorderRadius(_receivedBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    
}
@end
