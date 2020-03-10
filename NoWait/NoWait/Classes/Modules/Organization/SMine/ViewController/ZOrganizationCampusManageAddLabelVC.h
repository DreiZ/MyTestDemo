//
//  ZOrganizationCampusManageAddLabelVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationCampusManageAddLabelVC : ZViewController
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) void (^handleBlock)(NSArray *);
@property (nonatomic,assign) NSInteger max;
@end

NS_ASSUME_NONNULL_END
