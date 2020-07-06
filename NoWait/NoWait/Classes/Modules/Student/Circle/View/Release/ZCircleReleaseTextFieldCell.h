//
//  ZCircleReleaseTextFieldCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/6.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleReleaseTextFieldCell : ZBaseCell
@property (nonatomic,strong) ZBaseTextFieldCellModel *model;
@property (nonatomic,strong) void (^valueChangeBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
