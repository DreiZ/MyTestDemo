//
//  ZOrganizationAccountSchoolCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAccountSchoolCell.h"

@interface ZOrganizationAccountSchoolCell ()
@property (nonatomic,strong) UIView *leftHintView;
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic,strong) UILabel *zhuanPriceLabel;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@end

@implementation ZOrganizationAccountSchoolCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    
    [self.contentView addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(-CGFloatIn750(30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.mas_bottom).offset(CGFloatIn750(-10));
    }];
    
    [self.contView addSubview:self.leftHintView];
    [self.contView addSubview:self.leftTitleLabel];
    [self.contView addSubview:self.zhuanPriceLabel];
    [self.contentView addSubview:self.arrowImageView];
    
    [self.leftHintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(10));
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftHintView.mas_right).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
    
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contView.mas_right).offset(CGFloatIn750(-20));
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
    
    [self.zhuanPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).offset(CGFloatIn750(-20));
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
}


#pragma mark - Getter
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        ViewShadowRadius(_contView, CGFloatIn750(20), CGSizeMake(0, 0), 0.5, isDarkModel() ? [UIColor colorGrayContentBGDark] : [UIColor colorGrayContentBG]);
        _contView.layer.cornerRadius = CGFloatIn750(12);
    }
    return _contView;
}

- (UIView *)leftHintView {
    if (!_leftHintView) {
        _leftHintView = [[UIView alloc] init];
        ViewRadius(_leftHintView, CGFloatIn750(5));
        _leftHintView.backgroundColor = randomColor();
    }
    return _leftHintView;
}

- (UILabel *)zhuanPriceLabel {
    if (!_zhuanPriceLabel) {
        _zhuanPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _zhuanPriceLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _zhuanPriceLabel.text = @"";
        _zhuanPriceLabel.numberOfLines = 1;
        _zhuanPriceLabel.textAlignment = NSTextAlignmentRight;
        [_zhuanPriceLabel setFont:[UIFont fontContent]];
    }
    return _zhuanPriceLabel;
}


- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _leftTitleLabel.text = @"";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTitleLabel setFont:[UIFont boldFontContent]];
    }
    return _leftTitleLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"rightBlackArrowN"];
        _arrowImageView.layer.masksToBounds = YES;
    }
    return _arrowImageView;
}

- (void)setModel:(ZBaseSingleCellModel *)model {
    _leftTitleLabel.text = model.leftTitle;
    _zhuanPriceLabel.text = model.rightTitle;
    _arrowImageView.hidden = model.isHiddenLine;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(126);
}

@end
