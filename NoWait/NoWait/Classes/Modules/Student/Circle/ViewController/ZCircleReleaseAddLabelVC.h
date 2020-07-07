//
//  ZCircleReleaseAddLabelVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewController.h"


@interface ZCircleReleaseAddLabelVC : ZTableViewController
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) void (^handleBlock)(NSArray *);

@end

