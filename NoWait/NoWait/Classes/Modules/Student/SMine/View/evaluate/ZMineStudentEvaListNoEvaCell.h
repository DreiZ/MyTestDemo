//
//  ZMineStudentEvaListNoEvaCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMineStudentEvaListNoEvaCell : ZBaseCell
@property (nonatomic,strong) void (^evaBlock)(void);
@end

NS_ASSUME_NONNULL_END
