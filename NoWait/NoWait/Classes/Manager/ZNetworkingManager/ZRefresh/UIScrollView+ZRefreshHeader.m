//
//  UIScrollView+ZRefreshHeader.m
//  ZBigHealth
//
//  Created by zhuang zhang on 2018/10/16.
//  Copyright © 2018年 zhuang zhang. All rights reserved.
//

#import "UIScrollView+ZRefreshHeader.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (ZRefreshHeader)

- (void)tt_addRefreshHeaderWithAction:(void (^)(void))refreshAction
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshAction];
    [self setMj_header:header];
}

- (void)tt_beginRefreshing
{
    [self.mj_header beginRefreshing];
}

- (void)tt_endRefreshing
{
    [self.mj_header endRefreshing];
}

- (void)tt_removeRefreshHeader
{
    [self setMj_header:nil];
}

@end
