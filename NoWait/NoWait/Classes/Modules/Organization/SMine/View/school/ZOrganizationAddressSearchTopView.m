//
//  ZOrganizationAddressSearchTopView.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/17.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationAddressSearchTopView.h"

@interface ZOrganizationAddressSearchTopView ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIImageView *addressHintImageView;
@property (nonatomic,strong) UIView *searhBackView;

@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIImageView *searchImageView;

@property (nonatomic,strong) UIButton *cancleBtn;

@property (nonatomic,strong) UIView *backView;

@end

@implementation ZOrganizationAddressSearchTopView

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
        make.height.mas_equalTo(CGFloatIn750(88));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.contView addSubview:self.addressLabel];
    [self.contView addSubview:self.addressHintImageView];
    [self.contView addSubview:self.searhBackView];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(CGFloatIn750(30));
        make.centerY.equalTo(self.contView.mas_centerY);
        make.width.mas_equalTo(CGFloatIn750(120));
    }];
    
    [self.addressHintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(CGFloatIn750(-8));
        make.centerY.equalTo(self.addressLabel.mas_centerY);
        make.width.height.mas_equalTo(CGFloatIn750(44));
    }];
    
    [self.contView addSubview:self.cancleBtn];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contView);
        make.right.equalTo(self.contView.mas_right).offset(-CGFloatIn750(20));
        make.width.mas_equalTo(CGFloatIn750(90));
    }];
    
    [self.contView addSubview:self.searhBackView];
    [self.searhBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(CGFloatIn750(18));
        make.height.mas_equalTo(CGFloatIn750(64));
        make.right.equalTo(self.cancleBtn.mas_left).offset(-CGFloatIn750(10));
        make.centerY.equalTo(self.addressHintImageView);
    }];
    
    UIButton *addressBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [addressBtn bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:addressBtn];
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contView);
        make.right.equalTo(self.searhBackView.mas_left);
    }];
    
    self.addressHintImageView.hidden = YES;
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.layer.masksToBounds = YES;
//        _contView.backgroundColor = adaptAndDarkColor([UIColor colorWhite],[UIColor colorBlackBGDark]);
    }
    return _contView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack],[UIColor colorWhite]);
        _addressLabel.text = @"徐州";
        _addressLabel.numberOfLines = 1;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont fontTitle]];
        [_addressLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _addressLabel;
}

- (UIImageView *)addressHintImageView {
    if (!_addressHintImageView) {
        _addressHintImageView = [[UIImageView alloc] init];
        _addressHintImageView.image = [[UIImage imageNamed:@"mineLessonDown"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _addressHintImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorBlackBGDark];
        _addressHintImageView.layer.masksToBounds = YES;
        _addressHintImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _addressHintImageView;
}

- (UIView *)searhBackView {
    if (!_searhBackView) {
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
        
        [_searhBackView addSubview:self.iTextField];
        [self.iTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searchImageView.mas_centerY);
            make.left.equalTo(self.searchImageView.mas_right).offset(CGFloatIn750(20));
            make.top.bottom.right.equalTo(self.searhBackView);
        }];
    }
    return _searhBackView;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        __weak typeof(self) weakSelf = self;
        _cancleBtn = [[UIButton alloc] init];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:adaptAndDarkColor([UIColor colorTextGray], [UIColor colorTextGrayDark]) forState:UIControlStateNormal];
        [_cancleBtn.titleLabel setFont:[UIFont fontContent]];
        [_cancleBtn bk_addEventHandler:^(id sender) {
            [weakSelf.iTextField resignFirstResponder];
            if (weakSelf.cancleBlock) {
                weakSelf.cancleBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIImageView *)searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mainSearch"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
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
        [_iTextField setPlaceholder:@"请输入地址"];
        [_iTextField setTextColor:adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark])];
        _iTextField.delegate = self;
        [_iTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _iTextField;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _addressLabel.text = title;
}

#pragma mark - 处理一些特殊的情况，比如layer的CGColor、特殊的，明景和暗景造成的文字内容变化等等
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // darkmodel change
//    [self setupDarkModel];
    _searchImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorTextGray1];
    _addressHintImageView.tintColor = isDarkModel() ? [UIColor colorWhite] : [UIColor colorBlackBGDark];
}

- (void)textFieldDidChange:(UITextField *)textField {
    [ZPublicTool textField:textField maxLenght:30 type:ZFormatterTypeAny];
    if (self.textChangeBlock) {
        self.textChangeBlock(textField.text);
    }
 
}
@end

