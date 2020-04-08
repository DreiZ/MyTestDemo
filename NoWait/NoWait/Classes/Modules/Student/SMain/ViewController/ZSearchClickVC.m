//
//  ZSearchClickVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSearchClickVC.h"

@interface ZSearchClickVC ()<UITextFieldDelegate>

@end

@implementation ZSearchClickVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.isHidenNaviBar = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;
    [self.navigationItem setTitle:self.navTitle];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
   
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(0));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-CGFloatIn750(0));
        make.top.equalTo(self.searchView.mas_bottom).offset(-CGFloatIn750(0));
    }];
    self.searchView.iTextField.placeholder = self.navTitle;
}

#pragma mark lazy loading...
- (ZSearchFieldView *)searchView {
    if (!_searchView) {
        __weak typeof(self) weakSelf = self;
        _searchView = [[ZSearchFieldView alloc] init];
        _searchView.iTextField.delegate = self;
        _searchView.textChangeBlock = ^(NSString *text) {
            [weakSelf valueChange:text];
        };
        _searchView.backBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        _searchView.searchBlock = ^(NSString *text) {
            [weakSelf searchClick:weakSelf.searchView.iTextField.text];
        };
    }
    return _searchView;
}

- (void)cancleBtnOnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - -textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//    [self searchPoiByKeyword:textField.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    self.searhView.hidden = NO;
}

- (void)valueChange:(NSString *)text {
    
}

- (void)searchClick:(NSString *)text {
    
}
@end


