//
//  ZOriganizationAccountFilteView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationAccountFilteView.h"

@interface ZOriganizationAccountFilteView ()
@property (nonatomic,strong) UILabel *inLabel;
@property (nonatomic,strong) UILabel *outLabel;
@property (nonatomic,strong) UILabel *inHintLabel;
@property (nonatomic,strong) UILabel *outHintLabel;

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;

@end

@implementation ZOriganizationAccountFilteView


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
    
    [self addSubview:self.inLabel];
    [self addSubview:self.inHintLabel];
    [self addSubview:self.outLabel];
    [self addSubview:self.outHintLabel];
    
    [self.inLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(CGFloatIn750(-8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
    }];

    [self.inHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inLabel.mas_centerY);
        make.right.equalTo(self.inLabel.mas_left);
    }];
    
    [self.outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(CGFloatIn750(8));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
    }];
    
    [self.outHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.outLabel.mas_centerY);
        make.right.equalTo(self.outLabel.mas_left);
    }];
    
    
    
    UIView *timeBack = [[UIView alloc] init];
    timeBack.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    ViewRadius(timeBack, CGFloatIn750(23));
    [self addSubview:timeBack];
    
    [self addSubview:self.timeLabel];
    [self addSubview:self.arrowImageView];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(50));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(CGFloatIn750(12));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [timeBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_left).offset(CGFloatIn750(-30));
        make.right.equalTo(self.arrowImageView.mas_right).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *allBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [allBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(3);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeBack.mas_left).offset(-CGFloatIn750(10));
        make.right.equalTo(timeBack.mas_right).offset(CGFloatIn750(10));
        make.top.equalTo(timeBack.mas_top).offset(-CGFloatIn750(40));
        make.bottom.equalTo(timeBack.mas_bottom).offset(CGFloatIn750(40));
    }];
}


- (UILabel *)inLabel {
    if (!_inLabel) {
        _inLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _inLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _inLabel.numberOfLines = 1;
        _inLabel.textAlignment = NSTextAlignmentRight;
        [_inLabel setFont:[UIFont fontSmall]];
    }
    return _inLabel;
}

- (UILabel *)outLabel {
    if (!_outLabel) {
        _outLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _outLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _outLabel.numberOfLines = 1;
        _outLabel.textAlignment = NSTextAlignmentRight;
        [_outLabel setFont:[UIFont fontSmall]];
    }
    return _outLabel;
}


- (UILabel *)inHintLabel {
    if (!_inHintLabel) {
        _inHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _inHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _inHintLabel.numberOfLines = 1;
        _inHintLabel.textAlignment = NSTextAlignmentRight;
        [_inHintLabel setFont:[UIFont fontSmall]];
    }
    return _inHintLabel;
}


- (UILabel *)outHintLabel {
    if (!_outHintLabel) {
        _outHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _outHintLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _outHintLabel.numberOfLines = 1;
        _outHintLabel.textAlignment = NSTextAlignmentRight;
        [_outHintLabel setFont:[UIFont fontSmall]];
    }
    return _outHintLabel;
}



- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}


- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [[UIImage imageNamed:@"fillArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _arrowImageView.tintColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]);
        _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    return _arrowImageView;
}

- (void)setIsHandle:(BOOL)isHandle {
    _isHandle = isHandle;
    if (isHandle) {
        self.arrowImageView.hidden = NO;
        [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_right).offset(CGFloatIn750(12));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }else{
        self.arrowImageView.hidden = YES;
        [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.timeLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
}

- (void)setModel:(ZStoresAccountBillListNetModel *)model {
    _model = model;
    _timeLabel.text = [NSString stringWithFormat:@"%@至%@",[SafeStr(model.start_time) timeStringWithFormatter:@"yyyy-MM-dd"],[SafeStr(model.end_time) timeStringWithFormatter:@"yyyy-MM-dd"]];
    _outHintLabel.text = @"支出￥";
    _inHintLabel.text = @"收入￥";
    _outLabel.text = ValidStr(model.spending) ? [NSString stringWithFormat:@"%.2f",[SafeStr(model.spending) doubleValue]]:@"0.00";
    _inLabel.text = ValidStr(model.income) ? [NSString stringWithFormat:@"%.2f",[SafeStr(model.income) doubleValue]]:@"0.00";
}
@end

