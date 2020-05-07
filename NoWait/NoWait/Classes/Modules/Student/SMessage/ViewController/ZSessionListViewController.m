//
//  ZSessionListViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSessionListViewController.h"

#import "ZSessionViewController.h"
#import "ZContactViewController.h"

@interface ZSessionListViewController ()

@end

@implementation ZSessionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会话";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSession)];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)onSelectedRecent:(NIMRecentSession *)recent
             atIndexPath:(NSIndexPath *)indexPath
{
    ZSessionViewController *vc = [[ZSessionViewController alloc] initWithSession:recent.session];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addSession
{
    ZContactViewController *vc = [[ZContactViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
