//
//  ZOrganizationTimeRightCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/25.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZBaseUnitModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationTimeRightCell : ZBaseCell
@property (nonatomic,strong) ZBaseUnitModel *model;
@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
