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

@end

@implementation ZStudentMineSettingCommonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
//    ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingSwitchCell className] title:[ZStudentMineSettingSwitchCell className] showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(110) cellType:ZCellTypeClass dataModel:@"消息推送"];
//    [self.cellConfigArr addObject:messageCellConfig];
//    
    ZCellConfig *loginOutCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMineSettingBottomCell className] title:@"cache" showInfoMethod:@selector(setTitle:) heightOfCell:CGFloatIn750(110) cellType:ZCellTypeClass dataModel:@"清空缓存"];
    [self.cellConfigArr addObject:loginOutCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"通用"];
}

#pragma mark tableView ------delegate-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
     if ([cellConfig.title isEqualToString:@"cache"]){
         [[SDImageCache sharedImageCache] clearMemory];
         [TLUIUtility showSuccessHint:@"操作成功"];
     }
}

@end
