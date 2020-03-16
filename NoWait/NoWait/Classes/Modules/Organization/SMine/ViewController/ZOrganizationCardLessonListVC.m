//
//  ZOrganizationCardLessonListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/3/16.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZOrganizationCardLessonListVC.h"

@interface ZOrganizationCardLessonListVC ()

@end

@implementation ZOrganizationCardLessonListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"课程"];
}


- (void)initCellConfigArr {
    [super initCellConfigArr];
    for (int i = 0; i < self.lessonList.count; i++) {
        ZOriganizationLessonListModel *listModel = self.lessonList[i];
        ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
        model.leftTitle = listModel.name;
        model.leftMargin = CGFloatIn750(60);
        model.rightMargin = CGFloatIn750(60);
        model.cellHeight = CGFloatIn750(108);
        model.leftFont = [UIFont fontMaxTitle];
        model.isHiddenLine = YES;

        ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:@"week" showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];

        [self.cellConfigArr addObject:menuCellConfig];

    }
}


@end

