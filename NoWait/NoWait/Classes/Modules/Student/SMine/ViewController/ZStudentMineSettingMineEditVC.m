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

@end

@implementation ZStudentMineSettingMineEditVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.userNameTF resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setMainView];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"设置昵称"];
    
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGFloatIn750(90), CGFloatIn750(50))];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor  colorMain];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont fontSmall]];
    
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
    [_userNameTF setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    [_userNameTF setBorderStyle:UITextBorderStyleNone];
    [_userNameTF setBackgroundColor:[UIColor clearColor]];
    [_userNameTF setReturnKeyType:UIReturnKeyDone];
    [_userNameTF setPlaceholder:@"请输入昵称"];
    [_userNameTF.rac_textSignal subscribeNext:^(NSString *x) {
       if (x.length > 8) {
           x = [x substringWithRange:NSMakeRange(0, 8)];
//           weakSelf.userNameTF.text = x;
       }
    //           if (weakSelf.editBlock) {
    //               weakSelf.editBlock(0, x);
    //           }
    //           weakSelf.loginViewModel.loginModel.tel = x;
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
}


#pragma mark textField delegate ---------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

@end
