//
//  ZOrganizationAccountSchoolListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAccountSchoolListCell.h"

@interface ZOrganizationAccountSchoolListCell ()

@property (nonatomic,strong) UILabel *zhuanPriceLabel;
@property (nonatomic,strong) UILabel *zhiLabel;
@property (nonatomic,strong) UILabel *feiLabel;
@property (nonatomic,strong) UILabel *daoLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIView *contView;
@end

@implementation ZOrganizationAccountSchoolListCell

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
    
    
    [self.contView addSubview:self.zhiLabel];
    [self.contView addSubview:self.timeLabel];
    [self.contView addSubview:self.zhuanPriceLabel];
    [self.contView addSubview:self.daoLabel];
    [self.contView addSubview:self.feiLabel];
    
    [self.zhuanPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.contView.mas_top).offset(CGFloatIn750(38));
    }];

    [self.zhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zhuanPriceLabel.mas_left);
        make.top.equalTo(self.zhuanPriceLabel.mas_bottom).offset(CGFloatIn750(24));
    }];
    
    [self.feiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zhiLabel.mas_right).offset(CGFloatIn750(26));
        make.centerY.equalTo(self.zhiLabel.mas_centerY);
    }];
    
    [self.daoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.zhuanPriceLabel.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zhuanPriceLabel.mas_left).offset(CGFloatIn750(6));
        make.bottom.equalTo(self.contView.mas_bottom).offset(CGFloatIn750(-40));
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

- (UILabel *)zhuanPriceLabel {
    if (!_zhuanPriceLabel) {
        _zhuanPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _zhuanPriceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _zhuanPriceLabel.numberOfLines = 1;
        _zhuanPriceLabel.textAlignment = NSTextAlignmentLeft;
        [_zhuanPriceLabel setFont:[UIFont boldFontContent]];
    }
    return _zhuanPriceLabel;
}


- (UILabel *)zhiLabel {
    if (!_zhiLabel) {
        _zhiLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _zhiLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _zhiLabel.numberOfLines = 1;
        _zhiLabel.textAlignment = NSTextAlignmentCenter;
        [_zhiLabel setFont:[UIFont fontMin]];
    }
    return _zhiLabel;
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

- (UILabel *)feiLabel {
    if (!_feiLabel) {
        _feiLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _feiLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _feiLabel.numberOfLines = 1;
        _feiLabel.textAlignment = NSTextAlignmentCenter;
        [_feiLabel setFont:[UIFont fontMin]];
    }
    return _feiLabel;
}

- (void)setModel:(ZStoresAccountDetaliListModel *)model {
    _model = model;
    _daoLabel.text = [NSString stringWithFormat:@"￥%@",SafeStr(model.should_amount)];
    _feiLabel.text = @"";
    _timeLabel.text = [NSString stringWithFormat:@"%@~%@",[SafeStr(model.start_time) timeStringWithFormatter:@"yyyy-MM-dd HH:MM"],[SafeStr(model.end_time) timeStringWithFormatter:@"yyyy-MM-dd HH:MM"]];
    _zhiLabel.text = [NSString stringWithFormat:@"￥%@",SafeStr(model.title)];
    _zhuanPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[SafeStr(model.should_amount) doubleValue]];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(202);
}

@end





