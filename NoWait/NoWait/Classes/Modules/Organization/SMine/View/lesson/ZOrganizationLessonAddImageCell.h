//
//  ZOrganizationLessonAddImageCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/2/19.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZOrganizationLessonAddImageCell : ZBaseCell
@property (nonatomic,strong) id image;
@property (nonatomic,strong) void (^valueChangeBlock)(NSString *, NSInteger);
@property (nonatomic,strong) void (^imageBlock)(NSInteger);
@property (nonatomic,strong) NSDictionary *data;

@end

NS_ASSUME_NONNULL_END
