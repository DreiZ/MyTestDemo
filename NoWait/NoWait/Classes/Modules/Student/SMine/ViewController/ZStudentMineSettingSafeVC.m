//
//  ZStudentMineSettingSafeVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/15.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineSettingSafeVC.h"
#import "ZStudentDetailModel.h"

#import "ZStudentMineChangePasswordVC.h"


@interface ZStudentMineSettingSafeVC ()
@end
@implementation ZStudentMineSettingSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableViewGaryBack];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    NSArray <NSArray *>*titleArr = @[@[@"修改密码", @"rightBlackArrowN", @"已设置",@"changePassWord"],
                                     @[@"更换绑定手机号", @"rightBlackArrowN", @"188*****553",@"changePhone"]];
    
    for (int i = 0; i < titleArr.count; i++) {
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = titleArr[i][0];
        model.rightImage = titleArr[i][1];
        model.rightTitle = titleArr[i][2];
        model.cellTitle = titleArr[i][3];
        
        model.leftFont = [UIFont fontContent];
        model.cellHeight = CGFloatIn750(110);
        model.isHiddenLine = NO;
        
        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:model];
        [self.cellConfigArr addObject:menuCellConfig];
    }
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"账号与安全"];
}

#pragma mark tableView -------datasource----------delegate-----
- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"changePassword"]) {
        ZStudentMineChangePasswordVC *cpvc = [ZStudentMineChangePasswordVC alloc];
        [self.navigationController pushViewController:cpvc animated:YES];
    }
}

@end
