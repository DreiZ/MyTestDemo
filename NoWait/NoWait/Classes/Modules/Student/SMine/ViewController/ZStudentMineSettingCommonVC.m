//
//  ZStudentMineSettingCommonVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingCommonVC.h"
#import "ZStudentMineSettingBottomCell.h"
#import "ZStudentMineSettingSwitchCell.h"
#import <SDImageCache.h>

@interface ZStudentMineSettingCommonVC ()
@property (nonatomic,strong) NSString *isOpen;
@end

@implementation ZStudentMineSettingCommonVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHidenNaviBar = NO;
    
    __weak typeof(self) weakSelf = self;
    self.zChain_updateDataSource(^{
        weakSelf.isOpen = @"2";
    }).zChain_setNavTitle(@"通用").zChain_setTableViewGary();
    
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingSwitchCell className] title:[ZStudentMineSettingSwitchCell className] showInfoMethod:@selector(setIsOpen:) heightOfCell:CGFloatIn750(110) cellType:ZCellTypeClass dataModel:weakSelf.isOpen];
        [weakSelf.cellConfigArr addObject:messageCellConfig];

        [weakSelf.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(10))];
        ZCellConfig *loginOutCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"cache" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(110) cellType:ZCellTypeClass dataModel:@"清空缓存"];
        [weakSelf.cellConfigArr addObject:loginOutCellConfig];
    }).zChain_block_setCellConfigForRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"ZStudentMineSettingSwitchCell"]){
            ZStudentMineSettingSwitchCell *lcell = (ZStudentMineSettingSwitchCell *)cell;
            lcell.handleBlock = ^(NSString * isOpen) {
                weakSelf.isOpen = isOpen;
                [weakSelf setTokenIsOpen:isOpen];
                
                weakSelf.zChain_reload_ui();
            };
        }
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"cache"]){
            [[SDImageCache sharedImageCache] clearMemory];
            [TLUIUtility showSuccessHint:@"操作成功"];
        }
    });
    
    self.zChain_reload_ui();
    [self getDeviceToken];
}

- (void)setTokenIsOpen:(NSString *)isOpen {
    if ([isOpen intValue] == 1) {
        [[ZUserHelper sharedHelper] updateToken:YES];
    }else{
        [[ZUserHelper sharedHelper] updateToken:NO];
    }
}

- (void)getDeviceToken {
    __weak typeof(self) weakSelf = self;
    if ([ZUserHelper sharedHelper].push_token) {
        [[ZUserHelper sharedHelper] getDeviceTokenWithParams:@{@"device_token":SafeStr([ZUserHelper sharedHelper].push_token)} block:^(BOOL isSuccess, NSString *status) {
            if (isSuccess) {
                if ([status intValue] == 1) {
                    weakSelf.isOpen = @"1";
                    
                    weakSelf.zChain_reload_ui();
                    return;;
                }
            }
            weakSelf.isOpen = @"2";
            weakSelf.zChain_reload_ui();
        }];
    }
}
@end
