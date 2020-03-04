//
//  ZOrganizationSearchVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationSearchVC.h"
#import "ZOrganizationTeacherSearchTopView.h"
#import "ZOriganizationTeachListCell.h"

@interface ZOrganizationSearchVC ()<UITextFieldDelegate>
@property (nonatomic,strong) ZOrganizationTeacherSearchTopView *searchView;

@end

@implementation ZOrganizationSearchVC

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
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    for (int i = 0; i < 12; i++) {
        ZCellConfig *progressCellConfig = [ZCellConfig cellConfigWithClassName:[ZOriganizationTeachListCell className] title:[ZOriganizationTeachListCell className] showInfoMethod:nil heightOfCell:[ZOriganizationTeachListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:progressCellConfig];
    }
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;
    [self.navigationItem setTitle:self.title];
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
}

#pragma mark lazy loading...
- (ZOrganizationTeacherSearchTopView *)searchView {
    if (!_searchView) {
        __weak typeof(self) weakSelf = self;
        _searchView = [[ZOrganizationTeacherSearchTopView alloc] init];
        _searchView.iTextField.delegate = self;
        _searchView.cancleBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _searchView;
}

#pragma mark - -textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"donggggs-----");
//    [self searchPoiByKeyword:textField.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    self.searhView.hidden = NO;
}
@end

