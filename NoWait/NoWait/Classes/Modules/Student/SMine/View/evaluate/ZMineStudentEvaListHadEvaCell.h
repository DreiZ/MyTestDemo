//
//  ZMineStudentEvaListHadEvaCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZOrderModel.h"

@interface ZMineStudentEvaListHadEvaCell : ZBaseCell
@property (nonatomic,strong) ZOrderEvaListModel *model;
@property (nonatomic,strong) void (^evaBlock)(NSInteger);
@end

