//
//  ZStudentLessonBottomView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/11.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentLessonBottomView.h"

@interface ZStudentLessonBottomView ()
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *payBtn;

@end

@implementation ZStudentLessonBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorBlackBG]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.payBtn];
    self.payBtn.hidden = YES;
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(90));
    }];
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.backgroundColor = [UIColor  colorMain];
        [_cancelBtn setTitle:@"撤销预约" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont fontMaxTitle]];
    }
    return _cancelBtn;
}


- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.borderColor = [UIColor  colorMain].CGColor;
        _payBtn.layer.borderWidth = 1;
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor  colorMain] forState:UIControlStateNormal];
        [_payBtn.titleLabel setFont:[UIFont fontMaxTitle]];
    }
    return _payBtn;
}

- (void)setOrderType:(ZLessonOrderType)orderType {
    if (orderType == ZLessonOrderTypeWaitPay) {
        _payBtn.hidden = NO;

        [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
            make.right.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(CGFloatIn750(90));
        }];
        
        [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX);
            make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(CGFloatIn750(90));
        }];
    }else{
        _payBtn.hidden = YES;

        [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(CGFloatIn750(20));
            make.right.equalTo(self.mas_right).offset(-CGFloatIn750(20));
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(CGFloatIn750(90));
        }];
        
    }
}
@end
