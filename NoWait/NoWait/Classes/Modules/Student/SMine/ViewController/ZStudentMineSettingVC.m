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
    
    self.isHidenNaviBar = NO;
    __weak typeof(self) weakSelf = self;
    
    self.setNavTitle(@"设置").setTableViewGary()
    .setUpdateConfigArr(^(void (^update)(NSMutableArray *cellConfig)) {
        
        [weakSelf.cellConfigArr removeAllObjects];
        
        NSArray <NSArray *>*titleArr = @[@[@"个人信息", @"rightBlackArrowN",@"us"], @[@"账号与安全", @"rightBlackArrowN",@"safe"],@[@"通用", @"rightBlackArrowN",@"common"],@[@"意见反馈", @"rightBlackArrowN",@"opinion"],@[@"关于似锦", @"rightBlackArrowN",@"about"]];
           
           for (int i = 0; i < titleArr.count; i++) {
               ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
               model.leftTitle = titleArr[i][0];
               model.rightImage = titleArr[i][1];
               model.leftFont = [UIFont fontContent];
               model.cellTitle = titleArr[i][2];
               model.cellHeight = CGFloatIn750(100);
               ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
               [self.cellConfigArr addObject:menuCellConfig];
           }
        
           
           ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
           [self.cellConfigArr addObject:topCellConfig];
           
           ZCellConfig *switchCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"switch" showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentMineSettingBottomCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"切换账号"];
           [self.cellConfigArr addObject:switchCellConfig];
           
           [self.cellConfigArr addObject:topCellConfig];
           
           ZCellConfig *loginOutCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"logout" showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentMineSettingBottomCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"退出登录"];
           [self.cellConfigArr addObject:loginOutCellConfig];
    })
    .setDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
        ZCellConfig *cellConfig = [weakSelf.cellConfigArr objectAtIndex:indexPath.row];
        if ([cellConfig.title isEqualToString:@"us"]){
                ZStudentMineSettingMineVC *dvc = [[ZStudentMineSettingMineVC alloc] init];
                [self.navigationController pushViewController:dvc animated:YES];
            }else if ([cellConfig.title isEqualToString:@"common"]) {
                ZStudentMineSettingCommonVC *cvc = [[ZStudentMineSettingCommonVC alloc] init];
                [self.navigationController pushViewController:cvc animated:YES];
            }else if ([cellConfig.title isEqualToString:@"safe"]) {
                ZStudentMineSettingSafeVC *svc = [[ZStudentMineSettingSafeVC alloc] init];
                [self.navigationController pushViewController:svc animated:YES];
            }else if( [cellConfig.title isEqualToString:@"about"]){
                ZStudentMineSettingAboutUsVC *avc = [[ZStudentMineSettingAboutUsVC alloc] init];
                [self.navigationController pushViewController:avc animated:YES];
            }else if ([cellConfig.title isEqualToString:@"logout"]){
                [[ZUserHelper sharedHelper] loginOutUser:[ZUserHelper sharedHelper].user];
                [[ZUserHelper sharedHelper] updateToken:NO];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if ([cellConfig.title isEqualToString:@"switch"]){
                ZStudentMineSwitchAccountVC *accountvc = [[ZStudentMineSwitchAccountVC alloc] init];
                [self.navigationController pushViewController:accountvc animated:YES];
            }else if ([cellConfig.title isEqualToString:@"opinion"]){
                ZMineFeedbackVC *fvc = [[ZMineFeedbackVC alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
            }
    });
    
    self.reloadData();
}
@end
