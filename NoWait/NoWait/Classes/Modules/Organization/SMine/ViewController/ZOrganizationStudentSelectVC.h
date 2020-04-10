//
//  ZOrganizationStudentSelectVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationStudentManageVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationStudentSelectVC : ZOrganizationStudentManageVC
@property (nonatomic,strong) void (^bottomBlock)(NSArray *);
@property (nonatomic,strong) NSMutableArray *ids;

@end

NS_ASSUME_NONNULL_END
