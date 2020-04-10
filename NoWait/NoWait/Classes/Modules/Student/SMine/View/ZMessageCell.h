//
//  ZMessageCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/4/10.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZMineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZMessageCell : ZBaseCell
@property (nonatomic,strong) ZMineMessageModel *model;

@end

NS_ASSUME_NONNULL_END
