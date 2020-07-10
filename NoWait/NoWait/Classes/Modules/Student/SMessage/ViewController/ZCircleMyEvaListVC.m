//
//  ZCircleMyEvaListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZCircleMyEvaListVC.h"
#import "ZMessageEvaListCell.h"

#import "ZCircleMineCollectionVC.h"
#import "ZCircleDetailVC.h"

@interface ZCircleMyEvaListVC ()

@end

@implementation ZCircleMyEvaListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"评论")
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_block_setRefreshHeaderNet(^{
        
    }).zChain_block_setRefreshMoreNet(^{
        
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [self.cellConfigArr removeAllObjects];
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageEvaListCell className] title:@"ZMessageEvaListCell" showInfoMethod:nil heightOfCell:[ZMessageEvaListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
        [self.cellConfigArr addObject:menuCellConfig];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageEvaListCell"]) {
            ZMessageEvaListCell *lcell = (ZMessageEvaListCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                if (index == 0) {
                    ZCircleMineCollectionVC *mvc = [[ZCircleMineCollectionVC
                                                     alloc] init];
                    [weakSelf.navigationController pushViewController:mvc animated:YES];
                }else{
                    ZCircleDetailVC *dvc = [[ZCircleDetailVC alloc] init];
                    [weakSelf.navigationController pushViewController:dvc animated:YES];
                }
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageEvaListCell"]) {
            ZCircleDetailVC *dvc = [[ZCircleDetailVC alloc] init];
            [self.navigationController pushViewController:dvc animated:YES];
        }
    });
    
    self.zChain_reload_ui();
}

@end
