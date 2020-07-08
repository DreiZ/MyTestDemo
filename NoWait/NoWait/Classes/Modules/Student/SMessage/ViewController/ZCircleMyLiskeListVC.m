//
//  ZCircleMyLiskeListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMyLiskeListVC.h"
#import "ZMessageLikeListCell.h"

#import "ZCircleMineVC.h"

@interface ZCircleMyLiskeListVC ()

@end

@implementation ZCircleMyLiskeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zChain_setNavTitle(@"喜欢")
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshHeaderNet(^{
        
    }).zChain_block_setRefreshMoreNet(^{
        
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageLikeListCell className] title:@"ZMessageLikeListCell" showInfoMethod:nil heightOfCell:[ZMessageLikeListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageLikeListCell"]) {
            ZMessageLikeListCell *lcell = (ZMessageLikeListCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        
    });
    
    self.zChain_reload_ui();
}


@end



