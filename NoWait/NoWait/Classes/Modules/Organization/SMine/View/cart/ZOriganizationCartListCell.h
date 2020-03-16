//
//  ZOriganizationCartListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

@interface ZOriganizationCartListCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationCardListModel *model;

@property (nonatomic,strong) void (^handleBlock)(NSInteger,ZOriganizationCardListModel *);
@end


