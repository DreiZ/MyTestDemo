//
//  ZOrganizationSwitchSchoolCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/29.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationSwitchSchoolCell : ZBaseCell
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@property (nonatomic,strong) ZOriganizationSchoolDetailModel *model;

@end

NS_ASSUME_NONNULL_END
