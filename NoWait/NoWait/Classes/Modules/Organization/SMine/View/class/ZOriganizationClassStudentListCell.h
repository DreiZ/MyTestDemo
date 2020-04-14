//
//  ZOriganizationClassStudentListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/26.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOriganizationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationClassStudentListCell : ZBaseCell
@property (nonatomic,strong) ZOriganizationStudentListModel *model;
@property (nonatomic,assign) BOOL isEnd;
@property (nonatomic,strong) void (^handleBlock)(NSInteger,ZOriganizationStudentListModel*);
@end

NS_ASSUME_NONNULL_END
