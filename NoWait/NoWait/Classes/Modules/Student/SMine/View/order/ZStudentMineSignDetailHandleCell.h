//
//  ZStudentMineSignDetailHandleCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZSignModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMineSignDetailHandleCell : ZBaseCell
@property (nonatomic,strong) ZSignInfoListModel *model;

@property (nonatomic,strong) void (^handleBlock)(ZSignInfoListModel *);
@end

NS_ASSUME_NONNULL_END
