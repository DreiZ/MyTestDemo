//
//  ZOrganizationTestVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/6/2.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationTestVC.h"
#import "ZStudentMineSettingBottomCell.h"

@interface ZOrganizationTestVC ()

@end

@implementation ZOrganizationTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    __weak typeof(self) weakSelf = self;
//    
//    self.setUpdateConfigArr(^(void (^update)(NSMutableArray *cellConfig)) {
//        ZCellConfig *topCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(20) cellType:ZCellTypeClass dataModel:adaptAndDarkColor([UIColor colorGrayBG], [UIColor colorGrayBGDark])];
//        [weakSelf.cellConfigArr addObject:topCellConfig];
//        
//        ZCellConfig *switchCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"switch" showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentMineSettingBottomCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"切换账号"];
//        [weakSelf.cellConfigArr addObject:switchCellConfig];
//        
//        [weakSelf.cellConfigArr addObject:topCellConfig];
//        
//        ZCellConfig *loginOutCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"logout" showInfoMethod:@selector(setTitle:) heightOfCell:[ZStudentMineSettingBottomCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:@"退出登录"];
//        [weakSelf.cellConfigArr addObject:loginOutCellConfig];
//        
//        update(weakSelf.cellConfigArr);
//    }).setTableViewGary().setRefreshNet(^{
//        NSLog(@"head*************");
//        [weakSelf.iTableView tt_endRefreshing];
//    }).setRefreshMoreNet(^{
//        NSLog(@"more*************");
//        [weakSelf.iTableView tt_endRefreshing];
//    }).setRefreshHeader().setRefreshFooter();
//    self.setDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
//        ZCellConfig *cellConfig = [weakSelf.cellConfigArr objectAtIndex:indexPath.row];
//        if ([cellConfig.title isEqualToString:@"switch"]) {
//            NSLog(@"会误会误会误会");
//        }
//    });
//    self.setNavTitle(@"hahah");
//    
//    self.reloadData();
//    [self.iTableView reloadData];
}

@end
