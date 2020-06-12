//
//  ZSchoolAccountTopMainView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSchoolAccountTopMainView.h"

@interface ZSchoolAccountTopMainView ()
@property (nonatomic,strong) UILabel *navTitleLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *backImageView;
@end

@implementation ZSchoolAccountTopMainView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.contView).offset(safeAreaTop());
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    
    [topView addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(topView.mas_left).offset(CGFloatIn750(30));
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(0);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topView);
        make.left.equalTo(topView.mas_left);
        make.right.equalTo(self.backImageView.mas_right).offset(CGFloatIn750(30));
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark]);
    ViewRadius(bottomView, CGFloatIn750(40));
    [self.contView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contView);
        make.top.equalTo(self.contView.mas_bottom).offset(-CGFloatIn750(40));
        make.height.mas_equalTo(CGFloatIn750(80));
    }];
    
    
    [topView addSubview:self.navTitleLabel];
    [self addSubview:self.amountLabel];
    [self addSubview:self.detailLabel];
    
    
    [self.navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(topView.mas_bottom).offset(CGFloatIn750(60));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.amountLabel.mas_bottom).offset(CGFloatIn750(12));
    }];
    
    UIButton *allBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [allBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.handleBlock) {
            weakSelf.handleBlock(3);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.contView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.amountLabel.mas_left).offset(-CGFloatIn750(40));
        make.right.equalTo(self.amountLabel.mas_right).offset(CGFloatIn750(40));
        make.top.equalTo(self.amountLabel.mas_top).offset(-CGFloatIn750(40));
        make.bottom.equalTo(self.amountLabel.mas_bottom).offset(CGFloatIn750(40));
    }];
}


#pragma mark - lazy loading
- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    }
    return _contView;
}


- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [[UIImage imageNamed:@"navleftBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _backImageView.tintColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorWhite]);
    }
    return _backImageView;
}


- (UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _navTitleLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _navTitleLabel.text = @"账户信息";
        _navTitleLabel.numberOfLines = 1;
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_navTitleLabel setFont:[UIFont boldFontTitle]];
    }
    return _navTitleLabel;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _amountLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _amountLabel.numberOfLines = 1;
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        [_amountLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(56)]];
    }
    return _amountLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorWhite]);
        _detailLabel.text = @"校区总流水";
        _detailLabel.numberOfLines = 1;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [_detailLabel setFont:[UIFont fontSmall]];
    }
    return _detailLabel;
}

- (void)setModel:(ZStoresAccountModel *)model {
    _model = model;
    _amountLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.store_total_amount doubleValue]];
}
@end

