//
//  ZCircleDetailEvaDelCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/20.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleDetailEvaDelCell : ZBaseCell
@property (nonatomic,strong) void (^delBlock)(void);
@end

NS_ASSUME_NONNULL_END
