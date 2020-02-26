//
//  ZOriganizationClassStudentListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationClassStudentListCell : ZBaseCell
@property (nonatomic,strong) ZBaseCellModel *model;
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
