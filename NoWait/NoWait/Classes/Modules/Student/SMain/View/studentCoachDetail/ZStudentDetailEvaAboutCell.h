//
//  ZStudentDetailEvaAboutCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"


@interface ZStudentDetailEvaAboutCell : ZBaseCell
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSArray <ZCellConfig *>*configList;
@property (nonatomic,strong) void (^handleBlock)(ZCellConfig *);
@property (nonatomic,strong) void (^cellSetBlock)(UITableViewCell *, NSIndexPath*, ZCellConfig*);
@end


