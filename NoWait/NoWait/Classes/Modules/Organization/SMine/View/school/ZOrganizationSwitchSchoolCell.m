//
//  ZOrganizationSwitchSchoolCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSwitchSchoolCell.h"
@interface ZOrganizationSwitchSchoolCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *hintLabel;

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIView *hintBackView;

@property (nonatomic,strong) UIView *backContentView;
@end

@implementation ZOrganizationSwitchSchoolCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    
    [self.contentView addSubview:self.backContentView];
    [self.backContentView addSubview:self.leftImageView];
    [self.backContentView addSubview:self.titleLabel];
    [self.backContentView addSubview:self.subTitleLabel];
    [self.leftImageView addSubview:self.hintBackView];
    [self.leftImageView addSubview:self.hintLabel];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-0));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(20));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(20));
        make.centerY.equalTo(self.backContentView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(210));
        make.height.mas_equalTo(CGFloatIn750(132));
    }];
    
    [self.hintBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.leftImageView);
        make.height.mas_equalTo(CGFloatIn750(30));
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.hintBackView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(16));
        make.bottom.equalTo(self.leftImageView.mas_centerY).offset(-CGFloatIn750(8));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(CGFloatIn750(16));
        make.top.equalTo(self.leftImageView.mas_centerY).offset(CGFloatIn750(8));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *addBtn = [[ZButton alloc] initWithFrame:CGRectZero];
    [addBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.backContentView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backContentView);
    }];
}


#pragma mark -Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont boldFontMax1Title]];
    }
    return _titleLabel;
}


- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = adaptAndDarkColor([UIColor colorTextGray],[UIColor colorTextGrayDark]);
        
        _subTitleLabel.numberOfLines = 1;
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_subTitleLabel setFont:[UIFont fontSmall]];
    }
    return _subTitleLabel;
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _hintLabel.text = @"上传图片";
        _hintLabel.numberOfLines = 1;
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        [_hintLabel setFont:[UIFont fontMin]];
    }
    return _hintLabel;
}


- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"default_image32"];
        ViewRadius(_leftImageView, CGFloatIn750(8));
    }
    return _leftImageView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor whiteColor], [UIColor colorBlackBGDark]);
        ViewRadius(_backContentView, CGFloatIn750(16));
        ViewShadowRadius(_backContentView, CGFloatIn750(10), CGSizeMake(2, 2), 0.5, [UIColor colorGrayBG]);

    }
    return _backContentView;
}

- (UIView *)hintBackView {
    if (!_hintBackView) {
        _hintBackView = [[UIView alloc] init];
        _hintBackView.backgroundColor = adaptAndDarkColor([UIColor colorWithWhite:0 alpha:0.5], [UIColor colorWithWhite:0 alpha:0.5]);
    }
    return _hintBackView;
}

- (void)setModel:(ZOriganizationSchoolDetailModel *)model {
    _model = model;
    _subTitleLabel.text = [NSString stringWithFormat:@"店铺ID：%@",model.schoolID];
    _titleLabel.text = model.name;
    if (ValidStr(model.image)) {
        [_leftImageView tt_setImageWithURL:[NSURL URLWithString:imageFullUrl(SafeStr(model.image))] placeholderImage:[UIImage imageNamed:@"default_image32"]];
    }else if (ValidClass(model.image, [UIImage class])) {
        _leftImageView.image = model.image;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(212);
}

@end


