//
//  ZOriganizationStatisticsCell.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOriganizationStatisticsCell.h"

@interface ZOriganizationStatisticsCell ()

@property (nonatomic,strong) UILabel *refreshLabel;
@property (nonatomic,strong) UILabel *leftContentLabel;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightContentLabel;
@property (nonatomic,strong) UILabel *rightTitleLabel;
@property (nonatomic,strong) UIView *menuBackView;
@property (nonatomic,strong) UIView *backContentView;

@property (nonatomic,strong) NSMutableArray *menuBtnArr;


@end

@implementation ZOriganizationStatisticsCell

-(void)setupView {
    [super setupView];
    
    self.contentView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG],[UIColor colorGrayBGDark]);
    _menuBtnArr = @[].mutableCopy;
    
    UIView *topBackView = [[UIView alloc] init];
    
    topBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    [self.contentView addSubview:topBackView];
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(48));
    }];
    
    [self.contentView addSubview:self.backContentView];
    [self.backContentView addSubview:self.menuBackView];
    [self.backContentView addSubview:self.refreshLabel];
    [self.backContentView addSubview:self.leftContentLabel];
    [self.backContentView addSubview:self.leftTitleLabel];
    [self.backContentView addSubview:self.rightContentLabel];
    [self.backContentView addSubview:self.rightTitleLabel];
    
    [self.backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.mas_right).offset(CGFloatIn750(-30));
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-CGFloatIn750(20));
    }];
    
    [self.refreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(34));
        make.top.equalTo(self.backContentView.mas_top).offset(CGFloatIn750(20));
    }];
    
    [self.menuBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right).offset(-CGFloatIn750(30));
        make.left.equalTo(self.backContentView.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.backContentView.mas_top).offset(CGFloatIn750(60));
        make.height.mas_equalTo(CGFloatIn750(52));
    }];
    
    [self.leftContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backContentView.mas_left);
        make.top.equalTo(self.menuBackView.mas_bottom).offset(CGFloatIn750(40));
        make.right.equalTo(self.backContentView.mas_centerX);
    }];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftContentLabel.mas_centerX);
        make.top.equalTo(self.leftContentLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [self.rightContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backContentView.mas_right);
        make.top.equalTo(self.menuBackView.mas_bottom).offset(CGFloatIn750(40));
        make.left.equalTo(self.backContentView.mas_centerX);
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightContentLabel.mas_centerX);
        make.top.equalTo(self.rightContentLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    [self.menuBackView removeAllSubviews];
    NSArray *titleArr = @[@"今天",@"昨天",@"本周",@"本月"].mutableCopy;
    UIButton *tempBtn = nil;
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *menuBtn = [self getBtnWithText:titleArr[i] index:i];

        [_menuBtnArr addObject:menuBtn];
        [self.menuBackView addSubview:menuBtn];
        if (tempBtn) {
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tempBtn.mas_right).offset(1);
                make.top.bottom.equalTo(self.menuBackView);
                make.width.equalTo(self.menuBackView.mas_width).multipliedBy(1.0f/titleArr.count);
            }];
        }else{
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.menuBackView.mas_left);
                make.top.bottom.equalTo(self.menuBackView);
                make.width.equalTo(self.menuBackView.mas_width).multipliedBy(1.0f/titleArr.count);;
            }];
        }
        tempBtn = menuBtn;
    }
    self.selectedIndex = 0;
}


#pragma mark -Getter
- (UILabel *)refreshLabel {
    if (!_refreshLabel) {
        _refreshLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _refreshLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        _refreshLabel.numberOfLines = 1;
        _refreshLabel.textAlignment = NSTextAlignmentRight;
        [_refreshLabel setFont:[UIFont fontMin]];
    }
    return _refreshLabel;
}


- (UILabel *)leftContentLabel {
    if (!_leftContentLabel) {
        _leftContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftContentLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        
        _leftContentLabel.numberOfLines = 1;
        _leftContentLabel.textAlignment = NSTextAlignmentCenter;
        [_leftContentLabel setFont:[UIFont boldFontMax2Title]];
    }
    return _leftContentLabel;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        _leftTitleLabel.text = @"校区访问人数";
        _leftTitleLabel.numberOfLines = 1;
        _leftTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_leftTitleLabel setFont:[UIFont fontSmall]];
    }
    return _leftTitleLabel;
}


- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        _rightTitleLabel.text = @"校区缴费总额";
        _rightTitleLabel.numberOfLines = 1;
        _rightTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_rightTitleLabel setFont:[UIFont fontSmall]];
    }
    return _rightTitleLabel;
}

- (UILabel *)rightContentLabel {
    if (!_rightContentLabel) {
        _rightContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightContentLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorGrayBG]);
        
        _rightContentLabel.numberOfLines = 1;
        _rightContentLabel.textAlignment = NSTextAlignmentCenter;
        [_rightContentLabel setFont:[UIFont boldFontMax2Title]];
    }
    return _rightContentLabel;
}

- (UIView *)menuBackView {
    if (!_menuBackView) {
        _menuBackView = [[UIView alloc] init];
        _menuBackView.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorTextBlackDark]);
        ViewBorderRadius(_menuBackView, CGFloatIn750(26), 1, isDarkModel() ? [UIColor colorGrayBG] : [UIColor colorWhite]);
    }
    return _menuBackView;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        ViewRadius(_backContentView, CGFloatIn750(16));
        ViewShadowRadius(_backContentView, CGFloatIn750(10), CGSizeMake(2, 2), 0.5, isDarkModel() ? [UIColor colorWhite] : [UIColor colorTextBlackDark]);

    }
    return _backContentView;
}


- (UIButton *)getBtnWithText:(NSString *)text index:(NSInteger)index{
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    menuBtn.tag = index;
    __weak typeof(self) weakSelf = self;
    [menuBtn bk_addEventHandler:^(id sender) {
        [weakSelf menuBtn:menuBtn.tag];
    } forControlEvents:UIControlEventTouchUpInside];
    menuBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    [menuBtn setTitle:text forState:UIControlStateNormal];
    [menuBtn setTitleColor:adaptAndDarkColor([UIColor colorWhite], [UIColor colorGrayBG]) forState:UIControlStateNormal];
    [menuBtn.titleLabel setFont:[UIFont fontSmall]];
    
    return menuBtn;
}

- (void)menuBtn:(NSInteger)index {
    self.selectedIndex = index;
    
    if (self.handleBlock) {
        self.handleBlock(index);
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    for (int i = 0; i < self.menuBtnArr.count; i++) {
        UIButton *menuBtn = self.menuBtnArr[i];
        if (i == selectedIndex) {
            menuBtn.backgroundColor = adaptAndDarkColor(HexAColor(0x4dd599, 0.5), HexAColor(0x4dd599, 0.5));
        }else{
            menuBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
        }
    }
}


- (void)setModel:(ZStoresStatisticalModel *)model {
    _model = model;
    _refreshLabel.text = model.date;
    _rightContentLabel.text = ValidStr(model.total_amount)? [NSString stringWithFormat:@"￥%@",model.total_amount] :@"￥0.00";
    _leftContentLabel.text = ValidStr(model.visit_num)? model.visit_num :@"0";
}

+(CGFloat)z_getCellHeight:(id)sender {
    return CGFloatIn750(302);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    ViewBorderRadius(_menuBackView, CGFloatIn750(26), 1, isDarkModel() ? [UIColor colorGrayBG] : [UIColor colorTextBlackDark]);
}
@end

