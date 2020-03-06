//
//  ZTableViewListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

@interface ZTableViewListCell : ZBaseCell
@property (nonatomic,strong) NSArray <ZCellConfig *>*configList;
@property (nonatomic,strong) void (^handleBlock)(ZCellConfig *);
@property (nonatomic,strong) void (^cellSetBlock)(UITableViewCell *, NSIndexPath*, ZCellConfig*);
@end
