//
//  ZOrganizationCardAddVC.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZTableViewViewController.h"
#import "ZOriganizationModel.h"
#import "ZOriganizationCardViewModel.h"

@interface ZOrganizationCardAddVC : ZTableViewViewController
@property (nonatomic,strong) ZOriganizationCardViewModel *viewModel;
@property (nonatomic,strong) ZOriganizationSchoolListModel *school;
@end

