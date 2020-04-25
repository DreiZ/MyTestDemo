//
//  ZOriganizationTeachHeadImageCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/21.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOriganizationTeachHeadImageCell : ZBaseCell
@property (nonatomic,strong) id image;
@property (nonatomic,assign) BOOL isTeacher;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
