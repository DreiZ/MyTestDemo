//
//  UIScrollView+ZRefreshHeader.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (ZRefreshHeader)

- (void)tt_addRefreshHeaderWithAction:(void (^)(void))refreshAction;
- (void)tt_beginRefreshing;
- (void)tt_endRefreshing;
- (void)tt_removeRefreshHeader;

@end

NS_ASSUME_NONNULL_END
