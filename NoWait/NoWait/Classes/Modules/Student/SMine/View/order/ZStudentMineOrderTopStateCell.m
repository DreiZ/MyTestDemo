//
//  ZStudentMineOrderTopStateCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderTopStateCell.h"

@interface ZStudentMineOrderTopStateCell ()
@property (nonatomic,strong) UILabel *statelabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *detailLabel;

@end


@implementation ZStudentMineOrderTopStateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = [UIColor colorMain];
    [self.contentView addSubview:self.statelabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.detailLabel];
    
    [self.statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(40));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statelabel.mas_bottom).offset(CGFloatIn750(30));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
        make.centerX.equalTo(self.mas_centerX);
    }];
}


- (UILabel *)statelabel {
    if (!_statelabel) {
        _statelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statelabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _statelabel.text = @"待付款";
        _statelabel.numberOfLines = 1;
        _statelabel.textAlignment = NSTextAlignmentCenter;
        [_statelabel setFont:[UIFont boldFontSmall]];
    }
    return _statelabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _priceLabel.text = @"￥500";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(52)]];
    }
    return _priceLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _detailLabel.text = @"萨嘎李国红我爱过我欧威欧风我水电费第三方的身高多少";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontMin]];
    }
    return _detailLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(252);
}
@end
