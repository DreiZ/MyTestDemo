//
//  ZReflectListLogCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZReflectListLogCell.h"

@interface ZReflectListLogCell ()

@property (nonatomic,strong) UILabel *typeTitleLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIView *contView;
@end

@implementation ZReflectListLogCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(0));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(0));
    }];
    
    
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.timeLabel];
    [self.contView addSubview:self.typeTitleLabel];
    [self.contView addSubview:self.statusLabel];
    [self.contView addSubview:self.moneyLabel];
    
    [self.typeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(38));
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeTitleLabel.mas_left);
        make.top.equalTo(self.typeTitleLabel.mas_bottom).offset(CGFloatIn750(18));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.typeTitleLabel.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeTitleLabel.mas_left).offset(CGFloatIn750(6));
        make.bottom.equalTo(self.contView.mas_bottom).offset(CGFloatIn750(-40));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.timeLabel.mas_centerY);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(0.5);
    }];
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (UILabel *)typeTitleLabel {
    if (!_typeTitleLabel) {
        _typeTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _typeTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _typeTitleLabel.numberOfLines = 1;
        _typeTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_typeTitleLabel setFont:[UIFont fontContent]];
    }
    return _typeTitleLabel;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontMin]];
    }
    return _timeLabel;
}


- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMainDark]);
        
        _statusLabel.numberOfLines = 1;
        _statusLabel.textAlignment = NSTextAlignmentRight;
        [_statusLabel setFont:[UIFont fontSmall]];
    }
    return _statusLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _moneyLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [_moneyLabel setFont:[UIFont boldFontContent]];
    }
    return _moneyLabel;
}

- (void)setModel:(ZRewardReflectListModel *)model {
    _model = model;
    _moneyLabel.text = model.amount;
    _statusLabel.text = model.status;
    _timeLabel.text = model.created_at;
    _nameLabel.text = model.real_name;
    _typeTitleLabel.text = model.tip;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(204);
}

@end







