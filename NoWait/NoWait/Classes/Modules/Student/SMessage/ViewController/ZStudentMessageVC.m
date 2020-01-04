//
//  ZStudentMessageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageVC.h"

@interface ZStudentMessageVC ()

@end

@implementation ZStudentMessageVC


- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"消息"), @"tabBarMessage_highlighted", @"tabBarMessage_highlighted");
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
