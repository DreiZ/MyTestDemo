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
@property (nonatomic,strong) NSString *can_operation;

@property (nonatomic,strong) void (^handleBlock)(ZSignInfoListModel *,NSInteger signType);//0签课 1补签
@end

NS_ASSUME_NONNULL_END
