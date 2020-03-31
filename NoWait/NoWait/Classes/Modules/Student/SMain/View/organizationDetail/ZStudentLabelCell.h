//
//  ZStudentLabelCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/3/31.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentLabelCell : ZBaseCell
@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic,strong) void (^handleBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
