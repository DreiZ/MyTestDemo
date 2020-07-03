//
//  ZCircleRecommendCollectionCell.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleRecommendCollectionCell : ZBaseCollectionViewCell
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
