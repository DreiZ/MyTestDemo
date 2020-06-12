//
//  ZLoginTypeController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZLoginTypeController.h"
#import "ZLoginCodeController.h"
#import "ZLaunchManager.h"

@interface ZLoginTypeController ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIImageView *backImageView;

@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong) NSMutableArray *btnArr;
@property (nonatomic,strong) NSMutableArray *labelArr;
@end

@implementation ZLoginTypeController

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDataSource];
    [self setMainView];
    self.selectIndex = 0;
}

#pragma mark - set data
- (void)setDataSource {
    self.selectIndex = 0;
    self.btnArr = @[].mutableCopy;
    self.labelArr = @[].mutableCopy;
}

- (void)setNavigation {
    self.isHidenNaviBar = YES;
    
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
        make.height.mas_equalTo(CGFloatIn750(88));
    }];
    [self.navigationItem setTitle:@"身份选择"];
}


- (void)setMainView {
    
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn750(240));
    }];
    

    NSArray *imageArr = @[@"student_login",@"teacher_login",@"all_login",@"school_login"];
    NSArray *titleArr = @[@"我是学员",@"我是教师",@"我是机构",@"我是校区"];
    
    CGFloat leftY = CGFloatIn750(394);
    UIButton *sBtn = nil;
    for (int i = 0; i < imageArr.count; i++) {
        if (i == 2) {
            leftY += CGFloatIn750(260+120);
        }
        CGFloat multi = 0.25;
        if (i % 2 == 1) {
            multi = 0.75;
        }
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
        [btn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        ViewRadius(btn, CGFloatIn750(100));
        btn.tag = i;
        [self.view addSubview:btn];
        [self.btnArr addObject:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(leftY);
            make.width.height.mas_equalTo(CGFloatIn750(200));
            make.centerX.equalTo(self.view.mas_right).multipliedBy(multi);
        }];
        sBtn = btn;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        titleLabel.text = titleArr[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont fontContent]];
        [self.view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn.mas_centerX);
            make.top.equalTo(btn.mas_bottom).offset(CGFloatIn750(30));
        }];
        [self.labelArr addObject:titleLabel];
    }
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(CGFloatIn750(30));
        make.right.equalTo(self.view.mas_right).offset(CGFloatIn750(-30));
        make.height.mas_equalTo(CGFloatIn750(78));
        make.top.equalTo(sBtn.mas_bottom).offset(CGFloatIn750(168));
    }];
}

- (void)btnOnclick:(UIButton *)sender {
    self.selectIndex = sender.tag;
}

#pragma mark - lazy loading...
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        //    1：学员 2：教师 6：校区 8：机构
        __weak typeof(self) weakSelf = self;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn bk_addEventHandler:^(id sender) {
            ZLoginCodeController *lvc = [[ZLoginCodeController alloc] init];
            if (weakSelf.selectIndex == 0) {
                lvc.type = 1;
            }else if (weakSelf.selectIndex == 1){
                lvc.type = 2;
            }else if (weakSelf.selectIndex == 2){
                lvc.type = 8;
            }else if (weakSelf.selectIndex == 3){
                lvc.type = 6;
            }
            lvc.isSwitch = weakSelf.isSwitch;
            lvc.loginSuccess = weakSelf.loginSuccess;
            [weakSelf.navigationController pushViewController:lvc animated:YES];
       } forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = CGFloatIn750(38);
        [_loginBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:adaptAndDarkColor([UIColor colorMain], [UIColor colorMainDark]) forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWhite] forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont fontContent]];
    }
    return _loginBtn;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
        _nameLabel.text = @"请选择您的身份";
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:[UIFont boldFontMax1Title]];
    }
    return _nameLabel;
}


- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFloatIn750(88))];
        __weak typeof(self) weakSelf  = self;
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [backBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.isSwitch) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } else {
                [[ZLaunchManager sharedInstance] showMainTab];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(98));
            make.top.bottom.left.equalTo(self.navView);
        }];
        
        [backBtn addSubview:self.backImageView];
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(backBtn);
        }];
    }
    
    return _navView;
}


- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [[UIImage imageNamed:@"lessonSelectClose"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _backImageView.tintColor = adaptAndDarkColor([UIColor colorBlack], [UIColor colorWhite]);
    }
    return _backImageView;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    for (int i = 0; i < self.btnArr.count; i++) {
        UIButton *btn = self.btnArr[i];
        UILabel *label = self.labelArr[i];
        
        if (i == selectIndex) {
            label.textColor = adaptAndDarkColor([UIColor colorMain], [UIColor colorMain]);
            label.font = [UIFont boldFontContent];
            ViewBorderRadius(btn, CGFloatIn750(100), 2, [UIColor colorMain]);
        }else{
            label.font = [UIFont fontContent];
            label.textColor = adaptAndDarkColor([UIColor colorTextBlack], [UIColor colorTextBlackDark]);
            ViewBorderRadius(btn, CGFloatIn750(100), 2, [UIColor clearColor]);
        }
    }
}
@end

