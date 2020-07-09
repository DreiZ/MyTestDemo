//
//  ZMessageListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/7/8.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZMessageListVC.h"
#import "ZStudentMessageListCell.h"
#import "ZMessageTypeEntryCell.h"
#import <TLTabBarControllerProtocol.h>

#import "ZCircleMyFansNewListVC.h"
#import "ZCircleMyLiskeListVC.h"
#import "ZCircleMyEvaListVC.h"

@interface ZMessageListVC ()<TLTabBarControllerProtocol>
@property (nonatomic,strong) NSMutableDictionary *param;
@end

@implementation ZMessageListVC


- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"消息"), @"tabBarMessage", @"tabBarMessage_highlighted");
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.zChain_setNavTitle(@"消息")
    .zChain_setTableViewWhite()
    .zChain_addRefreshHeader()
    .zChain_addLoadMoreFooter()
    .zChain_addEmptyDataDelegate()
    .zChain_resetMainView(^{
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
            make.top.equalTo(self.view.mas_top).offset(10);
        }];
    }).zChain_updateDataSource(^{
        self.loading = YES;
        self.param = @{}.mutableCopy;
        if (ValidStr([ZUserHelper sharedHelper].user_id)) {
            self.emptyDataStr = @"您还没有收到过消息";
        }else{
            self.emptyDataStr = @"您还没有登录";
        }
    }).zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];

        NSArray *tempArr = @[@[@"finderMessageLike",@"喜欢"],@[@"finderMessageReceive",@"评论"],@[@"finderMessageFans",@"新增粉丝"]];
        NSMutableArray *itemArr = @[].mutableCopy;
        for (int i = 0; i < tempArr.count; i++) {
            ZMessageTypeEntryModel *model = [[ZMessageTypeEntryModel alloc] init];
            model.name = tempArr[i][1];
            model.image = tempArr[i][0];
            model.entry_id = i;
            [itemArr addObject:model];
        }
        
        ZCellConfig *entryCellConfig = [ZCellConfig cellConfigWithClassName:[ZMessageTypeEntryCell className] title:[ZMessageTypeEntryCell className] showInfoMethod:@selector(setItemArr:) heightOfCell:[ZMessageTypeEntryCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:itemArr];
        [self.cellConfigArr addObject:entryCellConfig];
        
        
        [self.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
       
        ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMessageListCell className] title:[ZStudentMessageListCell className] showInfoMethod:nil heightOfCell:[ZStudentMessageListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
        [self.cellConfigArr addObject:messageCellConfig];
        [self.cellConfigArr addObject:messageCellConfig];
        [self.cellConfigArr addObject:messageCellConfig];
        [self.cellConfigArr addObject:messageCellConfig];
        
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZMessageTypeEntryCell"]) {
            ZMessageTypeEntryCell *lcell = (ZMessageTypeEntryCell *)cell;
            lcell.handleBlock = ^(NSInteger index) {
                if (index == 0) {
                    ZCircleMyLiskeListVC *lvc = [[ZCircleMyLiskeListVC alloc] init];
                    [weakSelf.navigationController pushViewController:lvc animated:YES];
                }else if(index == 1){
                    ZCircleMyEvaListVC *evc = [[ZCircleMyEvaListVC alloc] init];
                    [weakSelf.navigationController pushViewController:evc animated:YES];
                }else{
                    ZCircleMyFansNewListVC *lvc = [[ZCircleMyFansNewListVC alloc] init];
                    [weakSelf.navigationController pushViewController:lvc animated:YES];
                }
            };
        }
    }).zChain_block_setRefreshHeaderNet(^{
//        [weakSelf refreshData];
    }).zChain_block_setRefreshMoreNet(^{
//        [weakSelf refreshMoreData];
    });
    self.loading = NO;
    self.zChain_reload_ui();
}

- (void)tabBarItemDidDoubleClick {
//    [self refreshAllData];
}
@end
