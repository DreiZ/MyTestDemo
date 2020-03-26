//
//  ZStudentMineOrderLessonEvaCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineOrderLessonEvaCell.h"

@interface ZStudentMineOrderLessonEvaCell ()
@property (nonatomic,strong) UILabel *orderNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIView *midView;

@end

@implementation ZStudentMineOrderLessonEvaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.contView addSubview:self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contView);
    }];
    
    [self.midView addSubview:self.leftImageView];
    [self.midView addSubview:self.priceLabel];
    [self.midView addSubview:self.detailLabel];
    [self.midView addSubview:self.orderNameLabel];
    
   [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.midView.mas_left).offset(CGFloatIn750(30));
       make.centerY.equalTo(self.midView.mas_centerY);
       make.height.mas_equalTo(CGFloatIn750(160));
       make.width.mas_equalTo(CGFloatIn750(240));
   }];

    [self.orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.leftImageView.mas_top).offset(CGFloatIn750(14));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.top.equalTo(self.orderNameLabel.mas_bottom).offset(CGFloatIn750(28));
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNameLabel.mas_left);
        make.bottom.equalTo(self.leftImageView.mas_bottom).offset(CGFloatIn750(-8));
        make.right.equalTo(self.midView.mas_right).offset(-CGFloatIn750(20));
    }];
    
}

#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewShadowRadius(_contView, CGFloatIn750(30), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
         _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}


- (UIView *)midView {
    if (!_midView) {
        _midView = [[UIView alloc] init];
        _midView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
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
        [_orderNameLabel setFont:[UIFont boldFontTitle]];
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

#pragma mark - set model
- (void)setModel:(ZOrderListModel *)model {
    _model = model;
   
    [self.leftImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.courses_image_url)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    
    self.orderNameLabel.text = model.courses_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.pay_amount];
    
    if ([model.orderType intValue] == 1) {
        self.detailLabel.text = [NSString stringWithFormat:@"教师：%@",model.teacher_name];
    }else{
        self.detailLabel.text = [NSString stringWithFormat:@"体验时长：%@",model.experience_duration];
    }
 
}

+ (CGFloat)z_getCellHeight:(id)sender {
    
    return CGFloatIn750(200);
}

@end

