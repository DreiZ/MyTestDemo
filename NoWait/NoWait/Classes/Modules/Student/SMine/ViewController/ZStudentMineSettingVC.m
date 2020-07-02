//
//  ZStudentMineSettingVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingVC.h"

#import "ZStudentMineSettingBottomCell.h"

#import "ZStudentMineSettingMineVC.h"
#import "ZStudentMineSettingCommonVC.h"
#import "ZStudentMineSettingSafeVC.h"
#import "ZStudentMineSettingAboutUsVC.h"
#import "ZStudentMineSwitchAccountVC.h"
#import "ZMineFeedbackVC.h"
#import "ZUserHelper.h"


@interface ZStudentMineSettingVC ()

@end
@implementation ZStudentMineSettingVC

#pragma mark vc delegate-------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isHidenNaviBar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.zChain_setTableViewGary()
    .zChain_setNavTitle(@"设置")
    .zChain_resetMainView(^{
        weakSelf.isHidenNaviBar = NO;
    });
    
    self.zChain_block_setUpdateCellConfigData(^(void (^update)(NSMutableArray *)) {
        [weakSelf.cellConfigArr removeAllObjects];
        NSArray <NSArray *>*titleArr = @[@[@"个人信息", @"rightBlackArrowN",@"us"], @[@"账号与安全", @"rightBlackArrowN",@"safe"],@[@"通用", @"rightBlackArrowN",@"common"],@[@"意见反馈", @"rightBlackArrowN",@"opinion"],@[@"关于似锦", @"rightBlackArrowN",@"about"]];
        
        for (int i = 0; i < titleArr.count; i++) {
            ZLineCellModel *model = ZLineCellModel.zz_lineCellModel_create(SafeStr(titleArr[i][2]));
            model.zz_titleLeft(titleArr[i][0]).zz_imageRight(titleArr[i][1])
            .zz_fontLeft([UIFont fontContent]).zz_cellHeight(CGFloatIn750(100)).zz_imageRightHeight(CGFloatIn750(14));
            ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZBaseLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZBaseLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
            [weakSelf.cellConfigArr addObject:menuCellConfig];
        }
        
        [weakSelf.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        
//        ZCellConfig *switchCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"switch" showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentMineSettingBottomCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"切换账号"];
//        [weakSelf.cellConfigArr addObject:switchCellConfig];
        
        [weakSelf.cellConfigArr addObject:getGrayEmptyCellWithHeight(CGFloatIn750(20))];
        
        ZCellConfig *loginOutCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"logout" showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentMineSettingBottomCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"退出登录"];
        [weakSelf.cellConfigArr addObject:loginOutCellConfig];
    }).zChain_block_setConfigDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath, ZCellConfig *cellConfig) {
        if ([cellConfig.title isEqualToString:@"us"]){
            ZStudentMineSettingMineVC *dvc = [[ZStudentMineSettingMineVC alloc] init];
            [weakSelf.navigationController pushViewController:dvc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"common"]) {
            ZStudentMineSettingCommonVC *cvc = [[ZStudentMineSettingCommonVC alloc] init];
            [weakSelf.navigationController pushViewController:cvc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"safe"]) {
            ZStudentMineSettingSafeVC *svc = [[ZStudentMineSettingSafeVC alloc] init];
            [weakSelf.navigationController pushViewController:svc animated:YES];
        }else if( [cellConfig.title isEqualToString:@"about"]){
            ZStudentMineSettingAboutUsVC *avc = [[ZStudentMineSettingAboutUsVC alloc] init];
            [weakSelf.navigationController pushViewController:avc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"logout"]){
            [[ZUserHelper sharedHelper] loginOutUser:[ZUserHelper sharedHelper].user];
            [[ZUserHelper sharedHelper] updateToken:NO];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else if ([cellConfig.title isEqualToString:@"switch"]){
            ZStudentMineSwitchAccountVC *accountvc = [[ZStudentMineSwitchAccountVC alloc] init];
            [weakSelf.navigationController pushViewController:accountvc animated:YES];
        }else if ([cellConfig.title isEqualToString:@"opinion"]){
            ZMineFeedbackVC *fvc = [[ZMineFeedbackVC alloc] init];
            [weakSelf.navigationController pushViewController:fvc animated:YES];
        }
    });
    
    self.zChain_reload_ui();
}

@end
