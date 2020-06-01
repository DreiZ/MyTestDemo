//
//  ZRewardCenterDetailCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZRewardCenterDetailCell.h"

@interface ZRewardCenterDetailCell ()

@property (nonatomic,strong) UILabel *leftContentLabel;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightContentLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;
@property (nonatomic,strong) UIView *backContentView;

@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *moneyHintLabel;
@property (nonatomic,strong) UILabel *logLabel;
@property (nonatomic,strong) UIImageView *logImageView;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *detailImageView;
@end

@implementation ZRewardCenterDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.backContentView];
    [self.backContentView addSubview:self.leftContentLabel];
    [self.backContentView addSubview:self.leftTitleLabel];
    [self.backContentView addSubview:self.rightContentLabel];
    [self.backContentView addSubview:self.rightTitleLabel];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
    }];

    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(40));
        make.right.equalTo(self.backContentView.mas_centerX);
        make.top.equalTo(self.backContentView.mas_top).offset(CGFloatIn750(60));
    }];
    
    [self.leftContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_left);
        make.top.equalTo(self.leftTitleLabel.mas_bottom).offset(CGFloatIn750(18));
        make.centerX.equalTo(self.backContentView.mas_centerX);
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_right).offset(CGFloatIn750(40));
        make.right.equalTo(self.backContentView.mas_right);
        make.centerY.equalTo(self.leftTitleLabel.mas_centerY);
    }];
    
    [self.rightContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right);
        make.top.equalTo(self.rightTitleLabel.mas_bottom).offset(CGFloatIn750(18));
        make.left.equalTo(self.rightTitleLabel.mas_left);
    }];
    
    
    [self.backContentView addSubview:self.moneyLabel];
    [self.backContentView addSubview:self.moneyHintLabel];
    [self.backContentView addSubview:self.logImageView];
    [self.backContentView addSubview:self.logLabel];
    [self.backContentView addSubview:self.detailImageView];
    [self.backContentView addSubview:self.detailLabel];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView.mas_right).multipliedBy(1/6.0f);
        make.top.equalTo(self.leftContentLabel.mas_bottom).offset(CGFloatIn750(76));
    }];
    
    [self.logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView.mas_right).multipliedBy(0.5);
        make.centerY.equalTo(self.moneyLabel.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView.mas_right).multipliedBy(5/6.0f);
        make.centerY.equalTo(self.moneyLabel.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.moneyHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.moneyLabel.mas_centerX);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(CGFloatIn750(16));
    }];
    
    [self.logLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logImageView.mas_centerX);
        make.top.equalTo(self.logImageView.mas_bottom).offset(CGFloatIn750(16));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detailImageView.mas_centerX);
        make.top.equalTo(self.detailImageView.mas_bottom).offset(CGFloatIn750(16));
    }];
    
    UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectZero];
    leftLineView.backgroundColor = [UIColor colorWhite];
    leftLineView.alpha = 0.1;
    [self.backContentView addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moneyLabel.mas_bottom).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.backContentView.mas_right).multipliedBy(1/3.0f);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
    
    UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectZero];
    rightLineView.backgroundColor = [UIColor colorWhite];
    rightLineView.alpha = 0.1;
    [self.backContentView addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moneyLabel.mas_bottom).offset(CGFloatIn750(20));
        make.centerX.equalTo(self.backContentView.mas_right).multipliedBy(2/3.0f);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(CGFloatIn750(56));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *leftBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [leftBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyHintLabel.mas_left).offset(-CGFloatIn750(20));
        make.right.equalTo(self.moneyHintLabel.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.moneyLabel.mas_top).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.moneyHintLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    UIButton *midBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [midBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(1);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:midBtn];
    [midBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logLabel.mas_left).offset(-CGFloatIn750(20));
        make.right.equalTo(self.logLabel.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.logImageView.mas_top).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.logLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    UIButton *rightBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [rightBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(2);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailLabel.mas_left).offset(-CGFloatIn750(20));
        make.right.equalTo(self.detailLabel.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.detailImageView.mas_top).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.detailLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
}


#pragma mark -Getter
- (UILabel *)leftContentLabel {
    if (!_leftContentLabel) {
        _leftContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftContentLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        
        _leftContentLabel.numberOfLines = 1;
        _leftContentLabel.textAlignment = NSTextAlignmentLeft;
        [_leftContentLabel setFont:[UIFont boldFontMax2Title]];
    }
    return _leftContentLabel;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        _leftTitleLabel.text = @"奖励金(元)";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont fontSmall]];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        _rightTitleLabel.text = @"已提现金额";
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_rightTitleLabel setFont:[UIFont fontSmall]];
    }
    return _rightTitleLabel;
}

- (UILabel *)rightContentLabel {
    if (!_rightContentLabel) {
        _rightContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightContentLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        
        _rightContentLabel.numberOfLines = 1;
        _rightContentLabel.textAlignment = NSTextAlignmentLeft;
        [_rightContentLabel setFont:[UIFont boldFontMax2Title]];
    }
    return _rightContentLabel;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor colorRedDefault], [UIColor colorRedDefault]);
        ViewRadius(_backContentView, CGFloatIn750(16));
        ViewShadowRadius(_backContentView, CGFloatIn750(10), CGSizeMake(2, 2), 0.5, isDarkModel() ? [UIColor colorRedDefault] : [UIColor colorRedDefault]);
//F43E06
    }
    return _backContentView;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _moneyLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [_moneyLabel setFont:[UIFont fontContent]];
    }
    return _moneyLabel;
}

- (UILabel *)moneyHintLabel {
    if (!_moneyHintLabel) {
        _moneyHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _moneyHintLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        _moneyHintLabel.text = @"去提现(元)";
        _moneyHintLabel.numberOfLines = 1;
        _moneyHintLabel.textAlignment = NSTextAlignmentCenter;
        [_moneyHintLabel setFont:[UIFont fontContent]];
    }
    return _moneyHintLabel;
}


- (UILabel *)logLabel {
    if (!_logLabel) {
        _logLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _logLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        _logLabel.numberOfLines = 1;
        _logLabel.text = @"提现记录";
        _logLabel.textAlignment = NSTextAlignmentCenter;
        [_logLabel setFont:[UIFont fontContent]];
    }
    return _logLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        _detailLabel.numberOfLines = 1;
        _detailLabel.text = @"奖励明细";
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontContent]];
    }
    return _detailLabel;
}


- (UIImageView *)logImageView {
    if (!_logImageView) {
        _logImageView = [[UIImageView alloc] init];
        _logImageView.image = [UIImage imageNamed:@"moneyLog"];
        _logImageView.layer.masksToBounds = YES;
        _logImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _logImageView;
}

- (UIImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[UIImageView alloc] init];
        _detailImageView.image = [UIImage imageNamed:@"moneyDetail"];
        _detailImageView.layer.masksToBounds = YES;
        _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _detailImageView;
}

- (void)setModel:(ZRewardInfoModel *)model {
    _model = model;
    _moneyLabel.text = [NSString stringWithFormat:@"%.2f",[model.cash_out_amount doubleValue]];
    _rightContentLabel.text = [NSString stringWithFormat:@"%.2f",[model.cash_out doubleValue]];
    _leftContentLabel.text = [NSString stringWithFormat:@"%.2f",[model.total_amount doubleValue]];
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(402);
}

@end


