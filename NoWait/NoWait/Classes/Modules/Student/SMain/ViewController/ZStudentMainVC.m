//
//  ZStudentMainVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMainVC.h"

@interface ZStudentMainVC ()

@end

@implementation ZStudentMainVC

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"记录"), @"record_normal", @"record_highlighted");
        self.analyzeTitle = @"首页";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
