//
//  ZStudentMineSettingSwitchCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZStudentMineSettingSwitchCell : ZBaseCell
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSString *isOpen;
@property (nonatomic,strong) void (^handleBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
