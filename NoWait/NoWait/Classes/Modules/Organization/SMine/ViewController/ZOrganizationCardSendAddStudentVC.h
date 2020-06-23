//
//  ZOrganizationCardSendAddStudentVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/23.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationCardSendAddStudentVC : ZTableViewController
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) void (^handleBlock)(NSArray *);
@end

NS_ASSUME_NONNULL_END
