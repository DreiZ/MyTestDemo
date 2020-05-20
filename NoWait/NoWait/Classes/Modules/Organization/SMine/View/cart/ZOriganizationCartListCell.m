//
//  ZOriganizationCartListCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationCartListCell.h"


@interface ZOriganizationCartListCell ()

@property (nonatomic,strong) UILabel *priceHintLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *validityTimeLabel;
@property (nonatomic,strong) UILabel *conditionLabel;
@property (nonatomic,strong) UILabel *remainNumLabel;

@property (nonatomic,strong) UIView *menuBackView;
@property (nonatomic,strong) UIView *backContentView;
@property (nonatomic,strong) UIButton *openBtn;
@property (nonatomic,strong) UIButton *seeBtn;
@property (nonatomic,strong) UIButton *useBtn;
@end

@implementation ZOriganizationCartListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    
    
    [self.contentView addSubview:self.backContentView];
    [self.backContentView addSubview:self.menuBackView];
    
    [self.backContentView addSubview:self.priceHintLabel];
    [self.backContentView addSubview:self.priceLabel];
    [self.backContentView addSubview:self.nameLabel];
    [self.backContentView addSubview:self.validityTimeLabel];
    [self.backContentView addSubview:self.conditionLabel];
    [self.backContentView addSubview:self.remainNumLabel];
    
    [self.backContentView addSubview:self.openBtn];
    [self.menuBackView addSubview:self.seeBtn];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self.mas_top).offset(CGFloatIn750(10));
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(10));
    }];
    
    [self.menuBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.backContentView);
        make.height.mas_equalTo(CGFloatIn750(100));
    }];
    
    [self.priceHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.backContentView.mas_top).offset(CGFloatIn750(80));
        make.width.mas_equalTo(CGFloatIn750(26));
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(20));
        make.centerY.equalTo(self.priceLabel.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(104));
        make.height.mas_equalTo(CGFloatIn750(52));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceHintLabel.mas_right).offset(-CGFloatIn750(8));
        make.bottom.equalTo(self.priceHintLabel.mas_bottom).offset(CGFloatIn750(16));
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(120));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(CGFloatIn750(20));
        make.top.equalTo(self.backContentView.mas_top).offset(CGFloatIn750(40));
        make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.validityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    [self.remainNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.validityTimeLabel.mas_bottom).offset(CGFloatIn750(10));
        make.right.equalTo(self.openBtn.mas_left).offset(-CGFloatIn750(20));
    }];
    
    
    [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceHintLabel.mas_left);
        make.top.equalTo(self.priceHintLabel.mas_bottom).offset(CGFloatIn750(14));
        make.width.mas_lessThanOrEqualTo(CGFloatIn750(120));
    }];
    
    [self.menuBackView addSubview:self.seeBtn];
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.menuBackView.mas_left).offset(CGFloatIn750(172));
        make.top.bottom.equalTo(self.menuBackView);
    }];
    
    [self.menuBackView addSubview:self.useBtn];
    [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.seeBtn.mas_centerY);
        make.right.equalTo(self.menuBackView.mas_right).offset(-CGFloatIn750(20));
        make.width.mas_equalTo(CGFloatIn750(132));
        make.height.mas_equalTo(CGFloatIn750(50));
    }];
}


#pragma mark - Getter
- (UILabel *)priceHintLabel {
    if (!_priceHintLabel) {
        _priceHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceHintLabel.textColor = adaptAndDarkColor([UIColor redColor],[UIColor redColor]);
        _priceHintLabel.text = @"￥";
        _priceHintLabel.numberOfLines = 1;
        _priceHintLabel.textAlignment = NSTextAlignmentLeft;
        [_priceHintLabel setFont:[UIFont fontMin]];
    }
    return _priceHintLabel;
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textColor = adaptAndDarkColor([UIColor redColor],[UIColor redColor]);
        _priceLabel.numberOfLines = 1;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(72)]];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[UIFont fontTitle]];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}


- (UILabel *)conditionLabel {
    if (!_conditionLabel) {
        _conditionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _conditionLabel.textColor = adaptAndDarkColor([UIColor redColor],[UIColor redColor]);
        
        _conditionLabel.numberOfLines = 1;
        _conditionLabel.textAlignment = NSTextAlignmentLeft;
        [_conditionLabel setFont:[UIFont fontMin]];
        _conditionLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _conditionLabel;
}

- (UILabel *)validityTimeLabel {
    if (!_validityTimeLabel) {
        _validityTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _validityTimeLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _validityTimeLabel.numberOfLines = 1;
        _validityTimeLabel.textAlignment = NSTextAlignmentLeft;
        [_validityTimeLabel setFont:[UIFont fontMin]];
    }
    return _validityTimeLabel;
}


- (UILabel *)remainNumLabel {
    if (!_remainNumLabel) {
        _remainNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _remainNumLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorTextBlackDark]);
        
        _remainNumLabel.numberOfLines = 1;
        _remainNumLabel.textAlignment = NSTextAlignmentLeft;
        [_remainNumLabel setFont:[UIFont fontMin]];
    }
    return _remainNumLabel;
}


- (UIButton *)openBtn {
    if (!_openBtn) {
        __weak typeof(self) weakSelf = self;
        _openBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_openBtn.titleLabel setFont:[UIFont fontContent]];
        ViewBorderRadius(_openBtn, CGFloatIn750(26), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_openBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(1,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}


- (UIButton *)useBtn {
    if (!_useBtn) {
        __weak typeof(self) weakSelf = self;
        _useBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_useBtn.titleLabel setFont:[UIFont fontSmall]];
        [_useBtn setTitle:@"去使用" forState:UIControlStateNormal];
        ViewBorderRadius(_useBtn, CGFloatIn750(26), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
        _useBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        [_useBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _useBtn;
}

- (UIButton *)seeBtn {
    if (!_seeBtn) {
        __weak typeof(self) weakSelf = self;
        _seeBtn = [[ZButton alloc] initWithFrame:CGRectZero];
        [_seeBtn setTitle:@"查看可用课程 >" forState:UIControlStateNormal];
        [_seeBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_seeBtn.titleLabel setFont:[UIFont fontSmall]];
        [_seeBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(2,self.model);
            };
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _seeBtn;
}

- (UIView *)menuBackView {
    if (!_menuBackView) {
        _menuBackView = [[UIView alloc] init];
        _menuBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _menuBackView.clipsToBounds = YES;
    }
    return _menuBackView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        _backContentView.layer.cornerRadius = CGFloatIn750(12);
        ViewShadowRadius(_backContentView, CGFloatIn750(30), CGSizeMake(CGFloatIn750(0), CGFloatIn750(0)), 1, isDarkModel() ? [UIColor colorGrayBGDark] : [UIColor colorGrayBG]);

    }
    return _backContentView;
}

- (void)setModel:(ZOriganizationCardListModel *)model {
    _model = model;
    _priceLabel.text = SafeStr(model.amount);
    _remainNumLabel.text = [NSString stringWithFormat:@"剩余%@/%@张",model.unused_nums,model.nums];
    if (![model.limit_start isEqualToString:@"0"]) {
        _validityTimeLabel.text = [NSString stringWithFormat:@"有效期%@至%@",[model.limit_start timeStringWithFormatter:@"yyyy-MM-dd"],[model.limit_end timeStringWithFormatter:@"yyyy-MM-dd"]];
    }else{
        _validityTimeLabel.text = @"长期有效";
    }
    
    _nameLabel.text = SafeStr(model.title);
    _conditionLabel.text = [NSString stringWithFormat:@"满%@可用",model.min_amount];
    
    
    if ([model.type intValue] == 1) {
        _seeBtn.enabled = NO;
        [_seeBtn setTitle:@"全部课程可用" forState:UIControlStateNormal];
    }else{
        _seeBtn.enabled = YES;
        [_seeBtn setTitle:@"查看可用课程 >" forState:UIControlStateNormal];
    }
    
    _openBtn.enabled = YES;
    _useBtn.hidden = !model.isStudent;
    if (model.isStudent) {
        _remainNumLabel.hidden = YES;
        if ([model.status intValue] == 2) {
            _openBtn.hidden = YES;
            _openBtn.enabled = NO;
            _useBtn.hidden = YES;
            [_openBtn setTitle:@"停用" forState:UIControlStateNormal];
            [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
            ViewBorderRadius(_openBtn, CGFloatIn750(26), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
            _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        }else{
            _openBtn.hidden = YES;
            _useBtn.hidden = NO;
        }
    }else{
        _remainNumLabel.hidden = NO;
        if ([model.status intValue] == 1) {
            _openBtn.hidden = NO;
            [_openBtn setTitle:@"停用" forState:UIControlStateNormal];
            [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
            ViewBorderRadius(_openBtn, CGFloatIn750(26), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
            _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        }else{
            _openBtn.hidden = YES;
            [_openBtn setTitle:@"启用" forState:UIControlStateNormal];
            [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
            ViewBorderRadius(_openBtn, CGFloatIn750(26), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
            _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        }
    }
    
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(280);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_menuBackView, CGFloatIn750(26), 1, isDarkModel() ? [UIColor colorGrayBG] : [UIColor colorTextBlackDark]);
    
    if (self.model.isStudent) {
        if ([self.model.status intValue] == 2) {
            _openBtn.hidden = NO;
            _openBtn.enabled = NO;
            [_openBtn setTitle:@"停用" forState:UIControlStateNormal];
            [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
            ViewBorderRadius(_openBtn, CGFloatIn750(26), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
            _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        }else{
            _openBtn.hidden = YES;
        }
    }else{
        if ([self.model.status intValue] == 1) {
            _openBtn.hidden = NO;
            [_openBtn setTitle:@"停用" forState:UIControlStateNormal];
            [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
            ViewBorderRadius(_openBtn, CGFloatIn750(26), CGFloatIn750(2), adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]));
            _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
        }else{
            _openBtn.hidden = YES;
            [_openBtn setTitle:@"启用" forState:UIControlStateNormal];
            [_openBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]) forState:UIControlStateNormal];
            ViewBorderRadius(_openBtn, CGFloatIn750(26), CGFloatIn750(2), adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]));
            _openBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        }
    }
}
@end


