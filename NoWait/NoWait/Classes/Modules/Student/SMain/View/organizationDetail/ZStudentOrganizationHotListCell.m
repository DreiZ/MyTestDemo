//
//  ZStudentOrganizationHotListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentOrganizationHotListCell.h"

@interface ZStudentOrganizationHotListCell ()
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *orignLabel;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *hintImageView;
@property (nonatomic,strong) UIView *topLineView;
@property (nonatomic,strong) UIView *orignLineView;

@end

@implementation ZStudentOrganizationHotListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.topLineView];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30) + CGFloatIn750(210) + CGFloatIn750(30));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.contentView addSubview:self.hintImageView];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.orignLabel];
    [self.contentView addSubview:self.orignLineView];
    
    [self.hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.topLineView.mas_left);
        make.height.width.mas_equalTo(CGFloatIn750(28));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hintImageView.mas_right).offset(CGFloatIn750(10));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self.orignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(10));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self.orignLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.orignLabel);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(1);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orignLabel.mas_right).offset(CGFloatIn750(6));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}


#pragma mark - lazy loading
- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.layer.masksToBounds = YES;
        _topLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]);
    }
    return _topLineView;
}

- (UIView *)orignLineView {
    if (!_orignLineView) {
        _orignLineView = [[UIView alloc] init];
        _orignLineView.layer.masksToBounds = YES;
        _orignLineView.backgroundColor = adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGray]);
    }
    return _orignLineView;
}

- (UIImageView *)hintImageView {
    if (!_hintImageView) {
        _hintImageView = [[UIImageView alloc] init];
//        _hintImageView.image = [UIImage imageNamed:@"<#imagename#>"];
//        _hintImageView.backgroundColor = [UIColor colorGrayLine];
        _hintImageView.layer.masksToBounds = YES;
        _hintImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _hintImageView.layer.cornerRadius = CGFloatIn750(4);
    }
    return _hintImageView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor colorMain];
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldFontSmall]];
    }
    return _priceLabel;
}


- (UILabel *)orignLabel {
    if (!_orignLabel) {
        _orignLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orignLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _orignLabel.numberOfLines = 1;
        _orignLabel.textAlignment = NSTextAlignmentLeft;
        [_orignLabel setFont:[UIFont fontSmall]];
    }
    return _orignLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontSmall]];
    }
    return _nameLabel;
}

- (void)setModel:(ZStoresCourse *)model {
    _model = model;
    
    self.nameLabel.text = model.name;
    
    if ([model.is_experience intValue] == 1) {
        self.hintImageView.image = [UIImage imageNamed:@"orderLesson"];
        CGSize priceSize = [[NSString stringWithFormat:@"￥%@",model.price] tt_sizeWithFont:[UIFont fontSmall]];
        
        CGSize expriceSize = [[NSString stringWithFormat:@"￥%@",model.experience_price] tt_sizeWithFont:[UIFont boldFontSmall]];
        
        [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hintImageView.mas_right).offset(CGFloatIn750(10));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(expriceSize.width + 2);
        }];
        
        [self.orignLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(10));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(priceSize.width + 2);
        }];
        
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.orignLabel.mas_right).offset(CGFloatIn750(6));
            make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.experience_price];
        self.orignLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        self.priceLabel.textColor = [UIColor colorMain];
        self.orignLabel.hidden = NO;
        self.orignLineView.hidden = NO;
    }else{
        CGSize priceSize = [[NSString stringWithFormat:@"￥%@",model.price] tt_sizeWithFont:[UIFont boldFontSmall]];
        self.hintImageView.image = [UIImage imageNamed:@"hotLesson"];
        [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hintImageView.mas_right).offset(CGFloatIn750(10));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(priceSize.width + 2);
        }];
        
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(6));
            make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(30));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        self.orignLabel.hidden = YES;
        self.orignLineView.hidden = YES;
        self.priceLabel.textColor = [UIColor colorOrangeHot];
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(60);
}
@end
