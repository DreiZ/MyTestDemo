//
//  ZStudentMainOrganizationSearchListItemCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainOrganizationSearchListItemCell.h"

@interface ZStudentMainOrganizationSearchListItemCell ()

@end

@implementation ZStudentMainOrganizationSearchListItemCell



- (void)setupView {
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:self.clubImageView];
    [self.contentView addSubview:self.pricebLabel];
    [self.contentView addSubview:self.clubLabel];
    
    [self.clubImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.contentView.mas_top);
//        make.centerY.equalTo(self.contentView.mas_centerY);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(CGFloatIn750(100));
        make.width.mas_equalTo(CGFloatIn750(150));
    }];
    
    [self.pricebLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.clubImageView.mas_bottom).offset(-CGFloatIn750(6));
    }];
    
    [self.clubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.clubImageView.mas_bottom).offset(CGFloatIn750(14));
    }];
}

-(UIImageView *)clubImageView {
    if (!_clubImageView) {
        _clubImageView = [[UIImageView alloc] init];
        _clubImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _clubImageView.clipsToBounds = YES;
        _clubImageView.layer.masksToBounds = YES;
        ViewRadius(_clubImageView, CGFloatIn750(12));
    }
    return _clubImageView;
}


- (UILabel *)clubLabel {
    if (!_clubLabel) {
        _clubLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _clubLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _clubLabel.numberOfLines = 1;
        _clubLabel.textAlignment = NSTextAlignmentCenter;
        [_clubLabel setFont:[UIFont fontSmall]];
    }
    return _clubLabel;
}


- (UILabel *)pricebLabel {
    if (!_pricebLabel) {
        _pricebLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _pricebLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorTextBlackDark]);
        
        _pricebLabel.numberOfLines = 1;
        _pricebLabel.textAlignment = NSTextAlignmentCenter;
        [_pricebLabel setFont:[UIFont fontContent]];
    }
    return _pricebLabel;
}

- (void)setModel:(ZStoresCourse *)model {
    _model = model;
    _pricebLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    _clubLabel.text = model.name;
    [_clubImageView tt_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"default_loadFail292"]];
}

+(CGSize)z_getCellSize:(id)sender {
    return CGSizeMake(CGFloatIn750(150), CGFloatIn750(184));
}
@end
