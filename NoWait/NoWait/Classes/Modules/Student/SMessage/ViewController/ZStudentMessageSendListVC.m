//
//  ZStudentMessageSendListVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/4/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMessageSendListVC.h"

@interface ZStudentMessageSendListVC ()

@end

@implementation ZStudentMessageSendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCellConfigArr];
    [self.iTableView reloadData];
}

- (void)setNavigation {
    [self.navigationItem setTitle:@"收件人列表"];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    if (ValidStr(self.model.extra)) {
        NSDictionary *extra = [self.model.extra zz_JSONValue];
        if ([extra objectForKey:@"name"]) {
            id temp = extra[@"name"];
            if ([temp isKindOfClass:[NSArray class]]) {
                NSArray *send = extra[@"name"];

                for (NSString *name in send) {
                    ZBaseSingleCellModel *model = [[ZBaseSingleCellModel alloc] init];
                    model.leftTitle = name;
                    model.isHiddenLine = YES;
                    model.cellHeight = CGFloatIn750(96);
                    model.leftFont = [UIFont fontContent];
                    
                    ZCellConfig *menuCellConfig = [ZCellConfig cellConfigWithClassName:[ZSingleLineCell className] title:model.cellTitle showInfoMethod:@selector(setModel:) heightOfCell:[ZSingleLineCell z_getCellHeight:model] cellType:ZCellTypeClass dataModel:model];
                    
                    [self.cellConfigArr addObject:menuCellConfig];
                }
            }
        }
    }
}

@end
