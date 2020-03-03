//
//  ZMineAccountTextFieldCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMineAccountTextFieldCell : ZBaseCell
@property (nonatomic,assign) ZFormatterType formatterType;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,assign) BOOL isCode;
@property (nonatomic,strong) void (^valueChangeBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
