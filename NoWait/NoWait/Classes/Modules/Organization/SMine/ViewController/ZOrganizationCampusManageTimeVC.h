//
//  ZOrganizationCampusManageTimeVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationCampusManageTimeVC : ZTableViewViewController
@property (nonatomic,strong) NSMutableArray *months;
@property (nonatomic,strong) NSMutableArray *weeks;
@property (nonatomic,strong) NSString *start;
@property (nonatomic,strong) NSString *end;

@property (nonatomic,strong) void (^timeBlock)(NSMutableArray *, NSMutableArray*, NSString *,NSString *);
@end

NS_ASSUME_NONNULL_END
