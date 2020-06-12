//
//  ZStudentMineSettingMineEditVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingMineEditVC.h"

@interface ZStudentMineSettingMineEditVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UILabel *hintLabel;

@end

@implementation ZStudentMineSettingMineEditVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.userNameTF resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_userNameTF) {
        [_userNameTF becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setMainView];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"设置昵称"];
    
    __weak typeof(self) weakSelf = self;
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont fontSmall]];
    [sureBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.userNameTF.text > 0) {
            if (weakSelf.handleBlock) {
                weakSelf.handleBlock(weakSelf.userNameTF.text);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [TLUIUtility showErrorHint:@"你还没有输入任何昵称"];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sureBtn]];
}


- (void)setMainView {
//    __weak typeof(self) weakSelf = self;
    UIView *hintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(30), CGFloatIn750(80))];

    _userNameTF  = [[UITextField alloc] init];
    _userNameTF.tag = 105;
    _userNameTF.clearButtonMode = UITextFieldViewModeAlways;
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    _userNameTF.leftView = hintView;
    [_userNameTF setTextAlignment:NSTextAlignmentLeft];
    [_userNameTF setFont:[UIFont fontContent]];
    [_userNameTF setBorderStyle:UITextBorderStyleNone];
    [_userNameTF setBackgroundColor:[UIColor clearColor]];
    [_userNameTF setReturnKeyType:UIReturnKeyDone];
    [_userNameTF setPlaceholder:@"请输入昵称"];
    [_userNameTF.rac_textSignal subscribeNext:^(NSString *x) {
        [ZPublicTool textField:self.userNameTF maxLenght:30 type:ZFormatterTypeAnyByte];
    }];
    _userNameTF.delegate = self;
    _userNameTF.backgroundColor = adaptAndDarkColor([UIColor colorWhite], [UIColor colorBlackBGDark]);
    _userNameTF.keyboardType = UIKeyboardTypeDefault;
    _userNameTF.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);

    [self.view addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(100));
        make.top.equalTo(self.view.mas_top).offset(20);
    }];
    
    self.userNameTF.text = self.text;
    
    [self.view addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.top.equalTo(self.userNameTF.mas_bottom).offset(CGFloatIn750(20));
        make.right.equalTo(self.view.mas_right).offset(-CGFloatIn750(30));
    }];
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textColor = [UIColor colorTextGray];
        _hintLabel.text = @"昵称只可有汉字字母数字下划线组成，30字符以内";
        _hintLabel.numberOfLines = 0;
        _hintLabel.textAlignment = NSTextAlignmentLeft;
        [_hintLabel setFont:[UIFont fontContent]];
    }
    return _hintLabel;
}

#pragma mark textField delegate ---------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

@end
