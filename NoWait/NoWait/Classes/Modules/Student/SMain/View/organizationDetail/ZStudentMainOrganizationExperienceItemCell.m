//
//  ZStudentMainOrganizationExperienceItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainOrganizationExperienceItemCell.h"

@interface ZStudentMainOrganizationExperienceItemCell ()

@end

@implementation ZStudentMainOrganizationExperienceItemCell

- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.clubImageView];
    [self.clubImageView addSubview:self.pricebLabel];
    [self.contentView addSubview:self.clubLabel];
    [self.contentView addSubview:self.numLabel];
    
    [self.clubImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(CGFloatIn750(140));
        make.width.mas_equalTo(CGFloatIn750(210));
    }];
    
    [self.pricebLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(26));
        make.bottom.equalTo(self.clubImageView.mas_bottom).offset(0);
    }];
    
    [self.clubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(6));
        make.top.equalTo(self.clubImageView.mas_bottom).offset(CGFloatIn750(14));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(6));
        make.top.equalTo(self.clubLabel.mas_bottom).offset(CGFloatIn750(14));
    }];
}

-(UIImageView *)clubImageView {
    if (!_clubImageView) {
        _clubImageView = [[UIImageView alloc] init];
        _clubImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _clubImageView.clipsToBounds = YES;
        _clubImageView.layer.masksToBounds = YES;
        
        ViewBorderRadius(_clubImageView, CGFloatIn750(12), 1, adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLineDark]));
    }
    return _clubImageView;
}


- (UILabel *)clubLabel {
    if (!_clubLabel) {
        _clubLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _clubLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _clubLabel.numberOfLines = 1;
        _clubLabel.textAlignment = NSTextAlignmentLeft;
        [_clubLabel setFont:[UIFont fontSmall]];
    }
    return _clubLabel;
}


- (UILabel *)pricebLabel {
    if (!_pricebLabel) {
        _pricebLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _pricebLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorTextBlackDark]);
        _pricebLabel.backgroundColor = HexAColor(0x000000, 0.5);
        _pricebLabel.numberOfLines = 1;
        _pricebLabel.textAlignment = NSTextAlignmentCenter;
        [_pricebLabel setFont:[UIFont fontMin]];
    }
    return _pricebLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        _numLabel.numberOfLines = 1;
        _numLabel.textAlignment = NSTextAlignmentLeft;
        [_numLabel setFont:[UIFont fontMin]];
    }
    return _numLabel;
}

- (void)setModel:(ZOriganizationLessonListModel *)model {
    _model = model;
    _pricebLabel.text = [NSString stringWithFormat:@"  ￥%@",SafeStr(model.experience_price)];
    _clubLabel.text = model.name;
    [_clubImageView tt_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"default_loadFail292"]];
    _numLabel.text = [NSString stringWithFormat:@"已售 %@",model.pay_nums];
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(CGFloatIn750(212), CGFloatIn750(230));
}
@end
