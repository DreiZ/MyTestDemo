//
//  ZMessageTypeEntryItemCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCollectionViewCell.h"
#import "ZMessgeModel.h"

@interface ZMessageTypeEntryItemCell : ZBaseCollectionViewCell
@property (nonatomic,strong) ZMessageTypeEntryModel *model;

@property (nonatomic,strong) void (^handleBlock)(void);
@end

