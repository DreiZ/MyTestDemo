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
        _nameLabel.text = @"课程收入";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontContent]];
    }
    return _nameLabel;
}


- (UILabel *)orderNOLabel {
    if (!_orderNOLabel) {
        _orderNOLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderNOLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark    ]);
        _orderNOLabel.text = @"订单编号：030923905209";
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
        _timeLabel.text = @"2020-01-02 15:25";
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
        _daoLabel.text = @"￥23";
        _daoLabel.numberOfLines = 1;
        _daoLabel.textAlignment = NSTextAlignmentRight;
        [_daoLabel setFont:[UIFont boldFontContent]];
    }
    return _daoLabel;
}



+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(202);
}

@end






