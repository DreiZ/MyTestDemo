//
//  ZOrganizationMenuCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZBaseUnitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationMenuCell : ZBaseCell

@property (nonatomic,strong) void (^menuBlock)(ZBaseUnitModel *);

@property (nonatomic,strong) NSArray <ZBaseUnitModel*>*channelList;
@end

NS_ASSUME_NONNULL_END
