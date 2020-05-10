//
//  ZSysNotificationViewController.m
//  NoWait
//
//  Created by zhuang zhang on 2020/5/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZSysNotificationViewController.h"

@interface ZSysNotificationViewController ()

@end

@implementation ZSysNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"通知消息"];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
//    for (id data in self.dataSources) {
//        ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageCell className] title:[ZMessageCell className] showInfoMethod:@selector(setModel:) heightOfCell:[ZMessageCell z_getCellHeight:data] cellType:ZCellTypeClass dataModel:data];
//        [self.cellConfigArr addObject:messageCellConfig];
//    }
}

@end
