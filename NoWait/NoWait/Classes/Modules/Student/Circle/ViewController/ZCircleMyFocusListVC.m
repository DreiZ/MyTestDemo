//
//  ZCircleMyFocusListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/7.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMyFocusListVC.h"
#import "ZCircleMyFocusCell.h"

#import "ZCircleMineCollectionVC.h"

@interface ZCircleMyFocusListVC ()

@end

@implementation ZCircleMyFocusListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zChain_setNavTitle(@"我的关注")
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshHeaderNet(^{
        
    }).zChain_block_setRefreshMoreNet(^{
        
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZCircleMyFocusCell className] title:@"ZCircleMyFocusCell" showInfoMethod:nil heightOfCell:[ZCircleMyFocusCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleMyFocusCell"]) {
            ZCircleMyFocusCell *lcell = (ZCircleMyFocusCell *)cell;
            lcell.handleBlock = ^{
                
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZCircleMyFocusCell"]) {
            ZCircleMineCollectionVC *mvc = [[ZCircleMineCollectionVC alloc] init];
            [self.navigationController pushViewController:mvc animated:YES];
        }
    });
    
    self.zChain_reload_ui();
}


@end
