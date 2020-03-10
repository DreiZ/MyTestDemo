//
//  ZOrganizationTimeHourCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/18.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZAlertDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationTimeHourCell : ZBaseCell
@property (nonatomic,strong) void (^handleBlock)(NSString *,NSString *);

- (void)setStart:(NSString *)start end:(NSString *)end;
@end

NS_ASSUME_NONNULL_END
