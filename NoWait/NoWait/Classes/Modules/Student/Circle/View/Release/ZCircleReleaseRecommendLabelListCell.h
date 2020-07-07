//
//  ZCircleReleaseRecommendLabelListCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleReleaseRecommendLabelListCell : ZBaseCell
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) void (^selectBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
