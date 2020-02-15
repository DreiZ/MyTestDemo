//
//  ZStudentMineOrderDetailHandleBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderDetailHandleBottomView.h"

@interface ZStudentMineOrderDetailHandleBottomView ()
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UIButton *telBtn;

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
    
    [self addSubview:self.telBtn];
    [self addSubview:self.payBtn];
    [self addSubview:self.cancelBtn];
    
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(CGFloatIn750(180));
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(46));
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.payBtn.mas_left).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(46));
        make.width.mas_equalTo(CGFloatIn750(130));
    }];
}



- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 3;
        _cancelBtn.layer.borderColor = [UIColor colorRedDefault].CGColor;
        _cancelBtn.layer.borderWidth = 1;
        [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorRedDefault] forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(22)]];
        
        __weak typeof(self) weakSelf = self;
        [_cancelBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypeCancel);
            }
        }];
    }
    return _cancelBtn;
}


- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.cornerRadius = 3;
        _payBtn.layer.borderColor = [UIColor colorRedDefault].CGColor;
        _payBtn.layer.borderWidth = 1;
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor colorRedDefault] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont fontSmall]];
        
        __weak typeof(self) weakSelf = self;
        [_payBtn bk_whenTapped:^{
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(ZLessonOrderHandleTypePay);
            }
        }];
    }
    return _payBtn;
}


- (UIButton *)telBtn {
    if (!_telBtn) {
        _telBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _telBtn.layer.masksToBounds = YES;
        [_telBtn setImage:[UIImage imageNamed:@"orderRigthtTel"] forState:UIControlStateNormal];
        [_telBtn setTitle:@"  联系商家" forState:UIControlStateNormal];
        [_telBtn setTitleColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_telBtn.titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
        
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
