//
//  ZMineOrderDetailCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineOrderDetailCell.h"
#import "ZStudentMineOrderDetailSubDesCell.h"

@interface ZMineOrderDetailCell ()
@property (nonatomic,strong) UILabel *orderNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *statelabel;

@property (nonatomic,strong) UIImageView *leftImageView;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *midView;


@end

@implementation ZMineOrderDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(40));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(40));
    }];
    [self.contView addSubview:self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contView);
    }];
    
    [self.midView addSubview:self.leftImageView];
    [self.midView addSubview:self.priceLabel];
    [self.midView addSubview:self.detailLabel];
    [self.midView addSubview:self.orderNameLabel];
    [self.midView addSubview:self.timeLabel];

   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.midView.mas_left).offset(CGFloatIn750(30));
       make.top.bottom.equalTo(self.midView);
       make.width.mas_equalTo(CGFloatIn750(240));
   }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.detailLabel.mas_centerY);
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];

    [self.orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.leftImageView.mas_top).offset(CGFloatIn750(2));
        make.right.equalTo(self.priceLabel.mas_left).offset(-CGFloatIn750(10));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.orderNameLabel.mas_bottom).offset(CGFloatIn750(38));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(30));
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(CGFloatIn750(14));
    }];
 
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
 
         _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}

- (UIView *)midView {
    if (!_midView) {
        _midView = [[UIView alloc] init];
        _midView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
        _midView.clipsToBounds = YES;
    }
    return _midView;
}

- (UILabel *)orderNameLabel {
    if (!_orderNameLabel) {
        _orderNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderNameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _orderNameLabel.text = @"";
        _orderNameLabel.numberOfLines = 1;
        _orderNameLabel.textAlignment = NSTextAlignmentLeft;
        [_orderNameLabel setFont:[UIFont boldFontContent]];
    }
    return _orderNameLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _priceLabel.text = @"";
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldFontContent]];
    }
    return _priceLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        ViewRadius(_leftImageView, CGFloatIn750(12));
    }
    return _leftImageView;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [_detailLabel setFont:[UIFont fontSmall]];
    }
    return _detailLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _timeLabel.text = @"";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [_timeLabel setFont:[UIFont fontSmall]];
    }
    return _timeLabel;
}


- (UILabel *)statelabel {
    if (!_statelabel) {
        _statelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statelabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _statelabel.text = @"";
        _statelabel.numberOfLines = 1;
        _statelabel.textAlignment = NSTextAlignmentRight;
        [_statelabel setFont:[UIFont boldFontSmall]];
    }
    return _statelabel;
}


#pragma mark - set model
- (void)setModel:(ZOrderDetailModel *)model {
    _model = model;
    [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:model.course_image_url] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    self.orderNameLabel.text = SafeStr(model.course_name);
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",SafeStr(self.model.order_amount)];
    self.detailLabel.text = [NSString stringWithFormat:@"教师：%@",SafeStr(self.model.teacher_name)];
    self.timeLabel.text = [NSString stringWithFormat:@"课节：%@节",SafeStr(self.model.course_number)];
}


+ (CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(240);
}
@end

