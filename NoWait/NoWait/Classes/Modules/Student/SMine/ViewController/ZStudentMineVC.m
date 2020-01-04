//
//  ZStudentMineVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineVC.h"

@interface ZStudentMineVC ()

@end

@implementation ZStudentMineVC

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"我的"), @"tabBarMine_highlighted", @"tabBarMine_highlighted");
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.analyzeTitle = @"个人主页";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
//    //更新用户信息
//    [[ZUserHelper sharedHelper] updateUserInfoWithCompleteBlock:^(BOOL isSuccess) {
//
//    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
