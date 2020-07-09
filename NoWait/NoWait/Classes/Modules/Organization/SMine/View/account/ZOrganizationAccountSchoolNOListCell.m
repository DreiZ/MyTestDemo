//
//  ZOrganizationAccountSchoolNOListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAccountSchoolNOListCell.h"

@interface ZOrganizationAccountSchoolNOListCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *orderNOLabel;
@property (nonatomic,strong) UILabel *daoLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIView *contView;
@end

@implementation ZOrganizationAccountSchoolNOListCell

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
    
    
    [self.contView addSubview:self.orderNOLabel];
    [self.contView addSubview:self.timeLabel];
    [self.contView addSubview:self.nameLabel];
    [self.contView addSubview:self.daoLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(38));
    }];

    [self.orderNOLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    
    [self.daoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(CGFloatIn750(6));
        make.bottom.equalTo(self.contView.mas_bottom).offset(CGFloatIn750(-34));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
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


- (UILabel *)orderNOLabel {
    if (!_orderNOLabel) {
        _orderNOLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderNOLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _orderNOLabel.numberOfLines = 1;
        _orderNOLabel.textAlignment = NSTextAlignmentLeft;
        [_orderNOLabel setFont:[UIFont fontContent]];
    }
    return _orderNOLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}


- (UILabel *)daoLabel {
    if (!_daoLabel) {
        _daoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _daoLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMainDark]);
        
        _daoLabel.numberOfLines = 1;
        _daoLabel.textAlignment = NSTextAlignmentRight;
        [_daoLabel setFont:[UIFont boldFontContent]];
    }
    return _daoLabel;
}

- (void)setModel:(ZStoresAccountBillListModel *)model {
    _model = model;
    _daoLabel.text = [NSString stringWithFormat:@"%.2f",[model.show_amount doubleValue]];
    _timeLabel.text = [model.end_time timeStringWithFormatter:@"yyyy-MM-dd HH:mm"];
    _orderNOLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.order_no];
    _nameLabel.text = SafeStr(model.title);
    
    if ([model.show_amount doubleValue] > 0.0001) {
        _daoLabel.textColor = [UIColor colorYellow];
    }else{
        _daoLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
    }
}


+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(202);
}

@end






