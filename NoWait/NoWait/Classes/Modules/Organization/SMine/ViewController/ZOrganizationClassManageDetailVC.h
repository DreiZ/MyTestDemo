//
//  ZOrganizationClassManageDetailVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationClassManageDetailVC : ZTableViewViewController
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) ZOriganizationClassListModel *model;

@end

NS_ASSUME_NONNULL_END
