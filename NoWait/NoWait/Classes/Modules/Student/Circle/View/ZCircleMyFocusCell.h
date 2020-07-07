//
//  ZCircleMyFocusCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMyFocusCell : ZBaseCell
@property (nonatomic,strong) void (^handleBlock)(void);
@property (nonatomic,assign) NSInteger type;//0:关注 1：fans 2：互相
@end

NS_ASSUME_NONNULL_END
