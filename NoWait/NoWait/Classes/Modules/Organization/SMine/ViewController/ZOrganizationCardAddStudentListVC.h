//
//  ZOrganizationCardAddStudentListVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

@interface ZOrganizationCardAddStudentListVC : ZTableViewViewController
@property (nonatomic,strong) NSMutableArray *studentArr;
@property (nonatomic,strong) void (^handleBlock)(NSArray *);
@end

