//
//  ZCircleMyFocusCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZCircleMineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMyFocusCell : ZBaseCell
@property (nonatomic,strong) void (^handleBlock)(ZCircleMinePersonModel *);
@property (nonatomic,strong) ZCircleMinePersonModel *model;

@end

NS_ASSUME_NONNULL_END
