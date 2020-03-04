//
//  ZOrganizationTeachingScheduleNoCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationTeachingScheduleNoCell : ZBaseCell
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@property (nonatomic,strong) ZOriganizationLessonOrderListModel *model;

@end

NS_ASSUME_NONNULL_END
