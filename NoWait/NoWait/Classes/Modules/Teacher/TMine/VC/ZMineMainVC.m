//
//  ZMineMainVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/2/28.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMineMainVC.h"
#import "ZStudentMineVC.h"
#import "ZOrganizationMineVC.h"
#import "ZTeacherMineVC.h"

#import "ZUserHelper.h"
#import <TLTabBarControllerProtocol.h>

@interface ZMineMainVC ()<TLTabBarControllerProtocol>
@property (nonatomic,strong) ZStudentMineVC *studentVC;
@property (nonatomic,strong) ZTeacherMineVC *teacherVC;
@property (nonatomic,strong) ZOrganizationMineVC *organizationVC;

@property (nonatomic,strong) UIViewController *selectedVC;

@end

@implementation ZMineMainVC

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"我的"), @"tabBarMine", @"tabBarMine_highlighted");
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.analyzeTitle = @"个人主页";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self showMainVC];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self showMainVC];
}

#pragma mark - show vc
- (void)showMainVC {
    if (![ZUserHelper sharedHelper].user) {
        [self showStudentVC];
        return;
    }
    if ([[ZUserHelper sharedHelper].user.type intValue] == 1) {
        [self showStudentVC];
    }else if ([[ZUserHelper sharedHelper].user.type intValue] == 2){
        [self showTeacherVC];
    }else if ([[ZUserHelper sharedHelper].user.type intValue] == 6 || [[ZUserHelper sharedHelper].user.type intValue] == 8){
        [self showOrganizationVC];
    }else{
        [self showStudentVC];
    }
}

- (void)showStudentVC {
    [self showVC:self.studentVC];
}

- (void)showTeacherVC {
    [self showVC:self.teacherVC];
}

- (void)showOrganizationVC {
    [self showVC:self.organizationVC];
}

- (void)showVC:(UIViewController *)vc {
    if (self.selectedVC && self.selectedVC == vc) {
        vc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight-kTabBarHeight);
        return;
    }else if (self.selectedVC){
        [self removeVC:self.selectedVC];
    }
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight-kTabBarHeight);
    [vc didMoveToParentViewController:self];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
    
    self.selectedVC = vc;
}


- (void)removeStudentVC {
    [self removeVC:self.studentVC];
}

- (void)removeTeacherVC {
    [self removeVC:self.teacherVC];
}

- (void)removeOrganizationVC {
    [self removeVC:self.organizationVC];
}


- (void)removeVC:(UIViewController *)vc {
    [vc willMoveToParentViewController:nil];
    [vc removeFromParentViewController];
    [vc.view removeFromSuperview];
}

#pragma mark - lazy loading
- (ZStudentMineVC *)studentVC {
    if (!_studentVC) {
        _studentVC = [[ZStudentMineVC alloc] init];
        
    }
    return _studentVC;
}

- (ZTeacherMineVC *)teacherVC {
    if (!_teacherVC) {
        _teacherVC = [[ZTeacherMineVC alloc] init];
        
    }
    return _teacherVC;
}


- (ZOrganizationMineVC *)organizationVC {
    if (!_organizationVC) {
        _organizationVC = [[ZOrganizationMineVC alloc] init];
        
    }
    return _organizationVC;
}

- (void)tabBarItemDidDoubleClick {
    if (_studentVC) {
        [_studentVC updateNetData];
    }
    
    if (_teacherVC) {
        [_teacherVC updateNetData];
    }
    
    if (_organizationVC) {
        [_organizationVC updateNetData];
    }
}
@end
