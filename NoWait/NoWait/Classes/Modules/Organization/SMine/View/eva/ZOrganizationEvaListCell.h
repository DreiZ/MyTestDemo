//
//  ZOrganizationEvaListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZStudentMineModel.h"

@interface ZOrganizationEvaListCell : ZBaseCell
@property (nonatomic,strong) ZStudentOrderEvaModel *model;
@property (nonatomic,strong) void (^evaBlock)(void);
@end


