//
//  ZOrganizationTeachingScheduleBuCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationTeachingScheduleBuCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationStudentListModel *model;
@property (nonatomic,strong) BOOL (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
