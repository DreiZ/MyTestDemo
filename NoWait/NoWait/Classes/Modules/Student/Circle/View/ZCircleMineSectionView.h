//
//  ZCircleMineSectionView.h
//  NoWait
//
//  Created by zhuang zhang on 2020/7/4.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCircleMineSectionView : UICollectionReusableView
@property (nonatomic,assign) BOOL isLike;
@property (nonatomic,strong) void (^handleBlock)(NSInteger);

- (void)setDynamic:(NSString *)dynamic like:(NSString *)like;
@end

NS_ASSUME_NONNULL_END
