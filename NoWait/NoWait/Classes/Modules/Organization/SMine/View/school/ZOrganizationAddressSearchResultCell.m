//
//  ZOrganizationAddressSearchResultCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAddressSearchResultCell.h"
@interface ZOrganizationAddressSearchResultCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@end

@implementation ZOrganizationAddressSearchResultCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(CGFloatIn750(-30));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.contentView.mas_centerY).offset(CGFloatIn750(-12));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(12));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(120));
    }];
    
}


#pragma mark -Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMainDark]);
        _titleLabel.text = @"一品香";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont fontMaxTitle]];
    }
    return _titleLabel;
}


- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        _subTitleLabel.text = @"徐州市鼓楼区和平大道21号";
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_subTitleLabel setFont:[UIFont fontSmall]];
    }
    return _subTitleLabel;
}


- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = adaptAndDarkColor([UIColor colorTextGray1],[UIColor colorTextGray1Dark]);
        _addressLabel.text = @"345m";
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentRight;
        [_addressLabel setFont:[UIFont fontSmall]];
    }
    return _addressLabel;
}

- (void)setModel:(ZLocationModel *)model {
    _model = model;
    
    self.titleLabel.text = model.name;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.address];
    if (model.isSelected) {
        self.titleLabel.textColor = adaptAndDarkColor([UIColor colorMain],[UIColor colorMainDark]);
    }else{
        self.titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
    }
    
    self.addressLabel.text = [NSString stringWithFormat:@"%ldm",(long)model.distance];
}


+(CGFloat)z_getCellHeight:(id)sender {
    ZLocationModel *model = (ZLocationModel *)sender;
    CGSize tempSize = [[NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.address] tt_sizeWithFont:[UIFont fontSmall] constrainedToWidth:KScreenWidth - CGFloatIn750(150)];
    return CGFloatIn750(106) + tempSize.height;
}

@end




