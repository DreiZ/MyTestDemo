//
//  ZOrganizationStudentTotalCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/9/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationStudentTotalCell : ZBaseCell
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *unit;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,assign) NSInteger min;
@property (nonatomic,strong) void (^valueChangeBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
