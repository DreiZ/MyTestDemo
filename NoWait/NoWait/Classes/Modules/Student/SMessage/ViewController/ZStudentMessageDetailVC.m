//
//  ZStudentMessageDetailVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageDetailVC.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZStudentMessageListDetailCell.h"


@interface ZStudentMessageDetailVC ()

@end
@implementation ZStudentMessageDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
//    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZSpaceEmptyCell className] title:[ZSpaceEmptyCell className] showInfoMethod:@selector(setBackColor:) heightOfCell:CGFloatIn750(8) cellType:ZCellTypeClass dataModel:[UIColor colorGrayBG]];
//    [self.cellConfigArr addObject:spacCellConfig];
    
    ZCellConfig *messageCellConfig = [ZCellConfig cellConfigWithClassName:[ZStudentMessageListDetailCell className] title:[ZStudentMessageListDetailCell className] showInfoMethod:nil heightOfCell:[ZStudentMessageListDetailCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:messageCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"课程提醒"];
}

- (void)setupMainView {
    [super setupMainView];
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

@end

