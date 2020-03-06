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
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *evaBtn;
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
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(100));
        make.bottom.equalTo(self.mas_bottom).offset(-safeAreaBottom());
    }];
    [contView addSubview:self.telBtn];
    [contView addSubview:self.payBtn];
    [contView addSubview:self.closeBtn];
    
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.equalTo(contView);
        make.width.mas_equalTo(CGFloatIn750(180));
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(contView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.payBtn.mas_left).offset(-CGFloatIn750(20));
        make.centerY.equalTo(contView.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(56));
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
}


- (UIButton *)payBtn {
    if (!_payBtn) {
        __weak typeof(self) weakSelf = self;
        _payBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont fontContent]];
        _payBtn.backgroundColor = [UIColor colorMain];
        ViewBorderRadius(_payBtn, CGFloatIn750(28), CGFloatIn750(2), [UIColor colorMain]);
        [_payBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(0);
            };
        }];
    }
    return _payBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        __weak typeof(self) weakSelf = self;
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_closeBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_closeBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
        [_closeBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1);
            };
        }];
    }
    return _closeBtn;
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
        [_evaBtn setTitleColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]) forState:UIControlStateNormal];
        [_evaBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_evaBtn, CGFloatIn750(28), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]));
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
        [_telBtn setTitleColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_telBtn.titleLabel setFont:[UIFont fontSmall]];
        
        __weak typeof(self) weakSelf = self;
        [_telBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeTel);
            }
        }];
    }
    return _telBtn;
}
@end
