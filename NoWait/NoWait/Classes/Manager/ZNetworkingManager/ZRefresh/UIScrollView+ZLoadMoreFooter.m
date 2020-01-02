//
//  UIScrollView+ZLoadMoreFooter.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/16.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import "UIScrollView+ZLoadMoreFooter.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (ZLoadMoreFooter)

- (void)tt_addLoadMoreFooterWithAction:(void (^)(void))loadMoreAction
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:loadMoreAction];
    [footer setTitle:LOCSTR(@"正在加载...") forState:MJRefreshStateRefreshing];
    [footer setTitle:LOCSTR(@"没有更多数据了") forState:MJRefreshStateNoMoreData];
    [self setMj_footer:footer];
}

- (void)tt_beginLoadMore
{
    [self.mj_footer beginRefreshing];
}

- (void)tt_endLoadMore
{
    self.mj_footer.hidden = NO;
    [self.mj_footer endRefreshing];
}

- (void)tt_showNoMoreFooter
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)tt_showNoMoreFooterWithTitle:(NSString *)title
{
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.mj_footer;
    [footer setTitle:title forState:MJRefreshStateNoMoreData];
    [self tt_showNoMoreFooter];
}

- (void)tt_removeLoadMoreFooter
{
    self.mj_footer.hidden = YES;
//    [self setMj_footer:nil];
}

@end
