//
//  ZLabelListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/6/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLabelListCell : ZBaseCell

@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic,strong) void (^handleBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
