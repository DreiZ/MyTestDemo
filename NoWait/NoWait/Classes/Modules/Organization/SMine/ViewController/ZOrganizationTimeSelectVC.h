//
//  ZOrganizationTimeSelectVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZViewController.h"
#import "ZBaseUnitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationTimeSelectVC : ZViewController
@property (nonatomic,strong) void (^timeBlock)(NSMutableArray <ZBaseMenuModel *>*);
@property (nonatomic,strong) NSMutableArray *timeArr;

@end

NS_ASSUME_NONNULL_END
