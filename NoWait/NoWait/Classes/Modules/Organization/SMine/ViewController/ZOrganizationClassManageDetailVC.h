//
//  ZOrganizationClassManageDetailVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"

@interface ZOrganizationClassManageDetailVC : ZTableViewViewController
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) ZOriganizationClassDetailModel *model;
 
@end

