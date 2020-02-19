//
//  UIScrollView+ZLoadMoreFooter.h
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (ZLoadMoreFooter)

- (void)tt_addLoadMoreFooterWithAction:(void (^)(void))loadMoreAction;
- (void)tt_beginLoadMore;
- (void)tt_endLoadMore;
- (void)tt_showNoMoreFooter;
- (void)tt_showNoMoreFooterWithTitle:(NSString *)title;
- (void)tt_removeLoadMoreFooter;

@end

NS_ASSUME_NONNULL_END
