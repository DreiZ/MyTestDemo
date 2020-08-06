//
//  ZTabBarController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/8/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTabBarController.h"

@interface ZTabBarController ()

@end

@implementation ZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    UINavigationController *navCtl = self.viewControllers[0];
//    if ([navCtl.topViewController isKindOfClass:[YourViewController class]]) {
//        return UIInterfaceOrientationMaskAll;
//    }
    return UIInterfaceOrientationMaskPortrait;
}
@end
