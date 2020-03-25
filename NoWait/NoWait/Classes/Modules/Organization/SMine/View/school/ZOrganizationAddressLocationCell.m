//
//  ZOrganizationAddressLocationCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAddressLocationCell.h"
@interface ZOrganizationAddressLocationCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UIImageView *leftImageView;

@end

@implementation ZOrganizationAddressLocationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(CGFloatIn750(30));
        make.bottom.equalTo(self.contentView.mas_centerY).offset(CGFloatIn750(-12));
        make.width.mas_equalTo(CGFloatIn750(24));
        make.height.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(16));
        make.centerY.equalTo(self.leftImageView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatIn750(12));
        make.right.equalTo(self.contentView.mas_right).offset(-CGFloatIn750(20));
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine], [UIColor colorGrayLine]);
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
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

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"hnglocaladdress"];
    }
    return _leftImageView;
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
}

+(CGFloat)z_getCellHeight:(id)sender {
    ZLocationModel *model = (ZLocationModel *)sender;
    CGSize tempSize = [[NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.address] tt_sizeWithFont:[UIFont fontSmall] constrainedToWidth:KScreenWidth - CGFloatIn750(86)];
    return CGFloatIn750(110) + tempSize.height;
}

@end



