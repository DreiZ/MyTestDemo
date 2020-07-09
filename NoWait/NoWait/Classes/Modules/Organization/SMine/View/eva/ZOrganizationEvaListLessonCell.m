//
//  ZOrganizationEvaListLessonCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationEvaListLessonCell.h"

@interface ZOrganizationEvaListLessonCell ()

@property (nonatomic,strong) UIImageView *lessonImageVIew;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *lessonLabel;
@property (nonatomic,strong) UILabel *cocahLabel;

@end

@implementation ZOrganizationEvaListLessonCell

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];


    [self.contView addSubview:self.priceLabel];
    [self.contView addSubview:self.lessonImageVIew];
    [self.contView addSubview:self.lessonLabel];
    [self.contView addSubview:self.cocahLabel];
    
    [self.lessonImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.width.mas_equalTo(CGFloatIn750(192));
    }];
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageVIew.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.lessonImageVIew.mas_top);
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.cocahLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageVIew.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.lessonImageVIew.mas_centerY);
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessonImageVIew.mas_right).offset(CGFloatIn750(20));
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.bottom.equalTo(self.lessonImageVIew.mas_bottom);
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
-(UIImageView *)lessonImageVIew {
    if (!_lessonImageVIew) {
        _lessonImageVIew = [[UIImageView alloc] init];
        _lessonImageVIew.contentMode = UIViewContentModeScaleAspectFill;
        
        ViewRadius(_lessonImageVIew, CGFloatIn750(12));
    }
    
    return _lessonImageVIew;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldFontContent]];
    }
    return _priceLabel;
}


- (UILabel *)lessonLabel {
    if (!_lessonLabel) {
        _lessonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lessonLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        
        _lessonLabel.numberOfLines = 1;
        _lessonLabel.textAlignment = NSTextAlignmentLeft;
        [_lessonLabel setFont:[UIFont boldFontContent]];
    }
    return _lessonLabel;
}


- (UILabel *)cocahLabel {
    if (!_cocahLabel) {
        _cocahLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cocahLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1], [UIColor colorTextGray1Dark]);
        
        _cocahLabel.numberOfLines = 1;
        _cocahLabel.textAlignment = NSTextAlignmentLeft;
        [_cocahLabel setFont:[UIFont fontSmall]];
    }
    return _cocahLabel;
}

- (void)setModel:(ZOrderEvaListModel *)model {
    _model = model;
    _cocahLabel.text = [NSString stringWithFormat:@"教师：%@",SafeStr(model.teacher_name)];
    _lessonLabel.text = model.stores_courses_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",SafeStr(model.pay_amount)];
    [_lessonImageVIew tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(model.stores_courses_image)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
}

- (void)setDetailModel:(ZOrderEvaDetailModel *)detailModel {
    _detailModel = detailModel;
    _cocahLabel.text = [NSString stringWithFormat:@"教师：%@",SafeStr(detailModel.teacher_nick_name)];
    _lessonLabel.text = detailModel.courses_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",SafeStr(detailModel.pay_amount)];
    [_lessonImageVIew tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(detailModel.courses_image_url)] placeholderImage:[UIImage imageNamed:@"default_image32"]];
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(128);
}
@end


