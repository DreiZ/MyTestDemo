//
//  ZSearchMapView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/27.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSearchMapView.h"

@interface ZSearchMapView ()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *searhBackView;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *searchImageView;

@property (nonatomic,strong) UIButton *searchBtn;

@property (nonatomic,strong) UIView *backView;

@end

@implementation ZSearchMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self addSubview:self.contView];
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.contView addSubview:self.searhBackView];
    
    [self.contView addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contView);
        make.right.equalTo(self.contView.mas_right);
        make.width.mas_equalTo(CGFloatIn750(80));
        make.height.mas_equalTo(CGFloatIn750(60));
    }];
    
    [self.contView addSubview:self.searhBackView];
    [self.searhBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(380));
        make.height.mas_equalTo(CGFloatIn750(60));
        make.right.equalTo(self.searchBtn.mas_left).offset(-CGFloatIn750(10));
        make.centerY.equalTo(self.contView.mas_centerY);
    }];
    
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
//        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    }
    return _contView;
}


- (UIView *)searhBackView {
    if (!_searhBackView) {
        __weak typeof(self) weakSelf = self;
        _searhBackView = [[UIView alloc] init];
        _searhBackView.layer.masksToBounds = YES;
        _searhBackView.backgroundColor = adaptAndDarkColor([UIColor colorGrayLine],[UIColor colorGrayBGDark]);
        _searhBackView.layer.cornerRadius = CGFloatIn750(32);
        
        [_searhBackView addSubview:self.searchImageView];
        [_searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searhBackView.mas_centerY);
            make.width.mas_equalTo(self.searchImageView.width);
            make.left.mas_equalTo(CGFloatIn750(20));
            make.height.mas_equalTo(self.searchImageView.height);
        }];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [closeBtn bk_whenTapped:^{
            if (weakSelf.backBlock) {
                weakSelf.backBlock();
            }
        }];
        [_searhBackView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.searhBackView);
            make.right.equalTo(self.searchImageView.mas_right);
        }];
        
        [_searhBackView addSubview:self.iTextField];
        [self.iTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searchImageView.mas_centerY);
            make.left.equalTo(self.searchImageView.mas_right).offset(CGFloatIn750(20));
            make.top.bottom.right.equalTo(self.searhBackView);
        }];
    }
    return _searhBackView;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        __weak typeof(self) weakSelf = self;
        _searchBtn = [[UIButton alloc] init];
        _searchBtn.clipsToBounds = YES;
        [_searchBtn setTitle:@"" forState:UIControlStateNormal];
        [_searchBtn setImage:[[UIImage imageNamed:@"hn_seed_searchselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_searchBtn setTitleColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlack]) forState:UIControlStateNormal];
        [_searchBtn.titleLabel setFont:[UIFont fontSmall]];
        
        ViewBorderRadius(_searchBtn, CGFloatIn750(30), 1, [UIColor colorTextBlack]);
        [_searchBtn bk_addEventHandler:^(id sender) {
            [weakSelf.iTextField resignFirstResponder];
            if (weakSelf.searchBlock) {
                weakSelf.searchBlock(self.iTextField.text);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

#pragma mark - handle
- (void)setIsOpen:(BOOL)isOpen {
    _isOpen = isOpen;
    __weak typeof(self) weakSelf = self;
    if (_isOpen) {
        [self.searchBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contView);
            make.right.equalTo(self.contView.mas_right);
            make.width.mas_equalTo(CGFloatIn750(120));
            make.height.mas_equalTo(CGFloatIn750(60));
        }];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [weakSelf.searchBtn setImage:nil forState:UIControlStateNormal];
            [weakSelf.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
            
            [weakSelf layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }else {
        [self.searchBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contView);
            make.right.equalTo(self.contView.mas_right);
            make.width.mas_equalTo(CGFloatIn750(80));
            make.height.mas_equalTo(CGFloatIn750(60));
        }];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [weakSelf.searchBtn setImage:[[UIImage imageNamed:@"hn_seed_searchselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [weakSelf.searchBtn setTitle:nil forState:UIControlStateNormal];
            [weakSelf layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)backOnclick:(id)sender {
    [self.iTextField resignFirstResponder];
    if (self.backBlock) {
        self.backBlock();
    }
}

- (UIImageView *)searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"lessonSelectClose"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _searchImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorTextGray1];
        _searchImageView.layer.masksToBounds = YES;
        _searchImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _searchImageView;
}


- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = adaptAndDarkColor([UIColor  colorMain], [UIColor colorBlackBGDark]);
        _backView.alpha = 0;
    }
    return _backView;
}

- (UITextField *)iTextField {
    if (!_iTextField ) {
        _iTextField = [[UITextField alloc] init];
        [_iTextField setFont:[UIFont fontSmall]];
        _iTextField.leftViewMode = UITextFieldViewModeAlways;
        [_iTextField setBorderStyle:UITextBorderStyleNone];
//        [_iTextField setBackgroundColor:[UIColor redColor]];
        [_iTextField setReturnKeyType:UIReturnKeyDone];
        [_iTextField setTextAlignment:NSTextAlignmentLeft];
        [_iTextField setPlaceholder:@"请输入校区名称"];
        [_iTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _iTextField.delegate = self;
        [_iTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _iTextField;
}


#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
//    [self setupDarkModel];
    _searchImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorTextGray1];
}

- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:60 type:ZFormatterTypeAnyByte];
    if (self.textChangeBlock) {
        self.textChangeBlock(textField.text);
    }
}
@end




