//
//  ZOrganizationEvaListUserInfoCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"
#import "CWStarRateView.h"
#import "ZCircleMineModel.h"

@interface ZOrganizationEvaListUserInfoCell : ZBaseCell
@property (nonatomic,strong) ZOrderEvaListModel *model;
@property (nonatomic,strong) ZCircleDynamicEvaModel *crModel;
@property (nonatomic,strong) CWStarRateView *crView;
@end

