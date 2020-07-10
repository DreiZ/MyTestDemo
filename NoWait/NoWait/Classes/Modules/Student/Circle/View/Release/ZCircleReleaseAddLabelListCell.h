//
//  ZCircleReleaseAddLabelListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZCircleReleaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleReleaseAddLabelListCell : ZBaseCell
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) void (^selectBlock)(ZCircleReleaseTagModel *);
@end

NS_ASSUME_NONNULL_END
