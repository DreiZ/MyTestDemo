//
//  ZMessageListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/5/9.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZMessgeModel.h"

@interface ZMessageListCell : ZBaseCell
@property (nonatomic,strong) ZMessgeModel *model;
@property (nonatomic,strong) void (^handleBlock)(ZMessgeModel *);
@end

