//
//  ZMessageTypeEntryCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZMessgeModel.h"

@interface ZMessageTypeEntryCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZMessageTypeEntryModel *>*itemArr;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

