//
//  ZMineOrderListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineOrderListCell.h"
#import "ZAlertView.h"

@interface ZMineOrderListCell ()
@end

@implementation ZMineOrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    [self.contView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [self.topView addSubview:self.userImgeView];
    [self.userImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.topView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(40));
    }];
    
    [self.contView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contView);
        make.height.mas_equalTo(CGFloatIn750(136));
    }];
    
    [self.contView addSubview:self.failView];
    [self.failView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.height.mas_equalTo(50);
    }];
    
    [self.contView addSubview:self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.failView.mas_top);
    }];
    
    [self.topView addSubview:self.clubLabel];
    [self.topView addSubview:self.statelabel];
    
    [self.clubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImgeView.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    [self.topView addSubview:self.clubImageView];
    [self.clubImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clubLabel.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *clubBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [clubBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(100, weakSelf.model);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:clubBtn];
    [clubBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.topView);
        make.right.equalTo(self.clubImageView.mas_right).offset(CGFloatIn750(20));
    }];
    
    [self.statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    [self.midView addSubview:self.leftImageView];
    [self.midView addSubview:self.priceLabel];
    [self.midView addSubview:self.detailLabel];
    [self.midView addSubview:self.orderNameLabel];
    
   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.midView.mas_left).offset(CGFloatIn750(30));
       make.top.bottom.equalTo(self.midView);
       make.width.mas_equalTo(CGFloatIn750(240));
   }];

    [self.orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.leftImageView.mas_top).offset(CGFloatIn750(2));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.top.equalTo(self.orderNameLabel.mas_bottom).offset(CGFloatIn750(38));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.bottom.equalTo(self.leftImageView.mas_bottom).offset(CGFloatIn750(-8));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.bottomView addSubview:self.payBtn];
    [self.bottomView addSubview:self.evaBtn];
    [self.bottomView addSubview:self.cancleBtn];
    [self.bottomView addSubview:self.delBtn];
    [self.bottomView addSubview:self.receivedBtn];
    [self.bottomView addSubview:self.refundOSureBtn];
    [self.bottomView addSubview:self.refundSureBtn];
    
    [self.bottomView addSubview:self.refundRefectBtn];
    [self.bottomView addSubview:self.refundCancle];
    [self.bottomView addSubview:self.refundOSureBtn];
    [self.bottomView addSubview:self.refundORefectBtn];
    [self.bottomView addSubview:self.refundPayBtn];
    [self.bottomView addSubview:self.receivedNOBtn];
    
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
    
    [self.refundSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.receivedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.receivedNOBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.refundRefectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    [self.refundCancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    [self.refundOSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    [self.refundORefectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    [self.refundPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
    
    [self.failView addSubview:self.failHintLabel];
    [self.failView addSubview:self.failLabel];
    [self.failHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.failView);
    }];

    [self.failLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.failView);
    }];
    [ZPublicTool setLineSpacing:CGFloatIn750(10) label:self.failLabel];
}

#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
         _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}

- (UIView *)failView {
    if (!_failView) {
        _failView = [[UIView alloc] init];
        _failView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _failView.clipsToBounds = YES;
    }
    return _failView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _topView.clipsToBounds = YES;
        _topView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _topView;
}

- (UIView *)midView {
    if (!_midView) {
        _midView = [[UIView alloc] init];
        _midView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _midView.clipsToBounds = YES;
    }
    return _midView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _bottomView.clipsToBounds = YES;
        _bottomView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _bottomView;
}
-(UIImageView *)clubImageView {
    if (!_clubImageView) {
        _clubImageView = [[UIImageView alloc] init];
        _clubImageView.image = [[UIImage imageNamed:@"rightBlackArrowN"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _clubImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    }
    return _clubImageView;
}

- (UILabel *)orderNameLabel {
    if (!_orderNameLabel) {
        _orderNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderNameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _orderNameLabel.text = @"";
        _orderNameLabel.numberOfLines = 1;
        _orderNameLabel.textAlignment = NSTextAlignmentLeft;
        [_orderNameLabel setFont:[UIFont boldFontContent]];
    }
    return _orderNameLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _priceLabel.text = @"";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldFontContent]];
    }
    return _priceLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_leftImageView, CGFloatIn750(12));
    }
    return _leftImageView;
}

- (UIImageView *)userImgeView {
    if (!_userImgeView) {
        _userImgeView = [[UIImageView alloc] init];
        _userImgeView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_userImgeView, CGFloatIn750(20));
    }
    return _userImgeView;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontSmall]];
    }
    return _detailLabel;
}

- (UILabel *)clubLabel {
    if (!_clubLabel) {
        _clubLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _clubLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _clubLabel.text = @"";
        _clubLabel.numberOfLines = 1;
        _clubLabel.textAlignment = NSTextAlignmentLeft;
        [_clubLabel setFont:[UIFont fontContent]];
    }
    return _clubLabel;
}


- (UILabel *)statelabel {
    if (!_statelabel) {
        _statelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _statelabel.text = @"";
        _statelabel.numberOfLines = 1;
        _statelabel.textAlignment = NSTextAlignmentRight;
        [_statelabel setFont:[UIFont boldFontSmall]];
    }
    return _statelabel;
}


- (UILabel *)failHintLabel {
    if (!_failHintLabel) {
        _failHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _failHintLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _failHintLabel.text = @"退款金额：";
        _failHintLabel.numberOfLines = 1;
        _failHintLabel.textAlignment = NSTextAlignmentLeft;
        [_failHintLabel setFont:[UIFont fontSmall]];
    }
    return _failHintLabel;
}


- (UILabel *)failLabel {
    if (!_failLabel) {
        _failLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _failLabel.textColor = adaptAndDarkColor([UIColor colorRedDefault],[UIColor colorRedDefault]);
        _failLabel.text = @"";
        _failLabel.numberOfLines = 0;
        _failLabel.textAlignment = NSTextAlignmentLeft;
        [_failLabel setFont:[UIFont fontSmall]];
    }
    return _failLabel;
}

#pragma mark - btn handle
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
                weakSelf.handleBlock(ZLessonOrderHandleTypePay,self.model);
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
                weakSelf.handleBlock(ZLessonOrderHandleTypeCancel,self.model);
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
                weakSelf.handleBlock(ZLessonOrderHandleTypeDelete,self.model);
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
                weakSelf.handleBlock(ZLessonOrderHandleTypeEva,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaBtn;
}


- (UIButton *)receivedBtn {
    if (!_receivedBtn) {
        __weak typeof(self) weakSelf = self;
        _receivedBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_receivedBtn setTitle:@"接受预约" forState:UIControlStateNormal];
        [_receivedBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_receivedBtn.titleLabel setFont:[UIFont fontContent]];
        _receivedBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewBorderRadius(_receivedBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_receivedBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeOrderReceive,self.model);
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
        [_receivedNOBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_receivedNOBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_receivedNOBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeOrderNOReceive,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _receivedNOBtn;
}

- (UIButton *)refundSureBtn {
    if (!_refundSureBtn) {
        __weak typeof(self) weakSelf = self;
        _refundSureBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refundSureBtn setTitle:@"接受退款" forState:UIControlStateNormal];
        [_refundSureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_refundSureBtn.titleLabel setFont:[UIFont fontContent]];
        _refundSureBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewBorderRadius(_refundSureBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_refundSureBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeSRefund,self.model);
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
        [_refundRefectBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_refundRefectBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_refundRefectBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeSRefundReject,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundRefectBtn;
}


- (UIButton *)refundCancle {
    if (!_refundCancle) {
        __weak typeof(self) weakSelf = self;
        _refundCancle = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refundCancle setTitle:@"取消退款" forState:UIControlStateNormal];
        [_refundCancle setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_refundCancle.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_refundCancle, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_refundCancle bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeSRefundCancle,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundCancle;
}


- (UIButton *)refundOSureBtn {
    if (!_refundOSureBtn) {
        __weak typeof(self) weakSelf = self;
        _refundOSureBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_refundOSureBtn setTitle:@"同意退款" forState:UIControlStateNormal];
        [_refundOSureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_refundOSureBtn.titleLabel setFont:[UIFont fontContent]];
        _refundOSureBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewBorderRadius(_refundOSureBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_refundOSureBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeORefund,self.model);
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
        [_refundORefectBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_refundORefectBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_refundORefectBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeORefundReject,self.model);
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
        [_refundPayBtn.titleLabel setFont:[UIFont fontContent]];
        _refundPayBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewBorderRadius(_refundPayBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        [_refundPayBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeRefundPay,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundPayBtn;
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_cancleBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    
    ViewBorderRadius(_delBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
    
    _clubImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
    
    ViewBorderRadius(_payBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    
    ViewBorderRadius(_evaBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    
    ViewBorderRadius(_refundSureBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    
    ViewBorderRadius(_receivedBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    
    ViewBorderRadius(_refundOSureBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
    
    ViewBorderRadius(_refundPayBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
}

- (void)setModel:(ZOrderListModel *)model {
    _model = model;
}
@end

