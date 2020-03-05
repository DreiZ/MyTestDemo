//
//  ZStudentMessageVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/3.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageVC.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentMessageListCell.h"

#import "ZStudentMessageDetailVC.h"

@interface ZStudentMessageVC ()

@end
@implementation ZStudentMessageVC


- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"消息"), @"tabBarMessage", @"tabBarMessage_highlighted");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
//    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(8) cellType:ZCellTypeClass dataModel:[UIColor colorGrayBG]];
//    [self.cellConfigArr addObject:spacCellConfig];
    
    ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMessageListCell className] title:[ZStudentMessageListCell className] showInfoMethod:nil heightOfCell:[ZStudentMessageListCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:messageCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"消息"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

- (void)zz_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZStudentMessageListCell"]) {
        ZStudentMessageDetailVC *dvc = [[ZStudentMessageDetailVC alloc] init];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

@end

