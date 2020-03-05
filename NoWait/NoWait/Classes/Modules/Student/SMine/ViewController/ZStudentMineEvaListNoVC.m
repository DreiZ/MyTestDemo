//
//  ZStudentMineEvaListNoVC.m
//  NoWait
//
//  Created by zhuang zhang on 2020/1/14.
//  Copyright © 2020 zhuang zhang. All rights reserved.
//

#import "ZStudentMineEvaListNoVC.h"
#import "ZCellConfig.h"

#import "ZSpaceEmptyCell.h"
#import "ZMineStudentEvaListNoEvaCell.h"
#import "ZStudentMineEvaEditVC.h"

@interface ZStudentMineEvaListNoVC ()

@end
@implementation ZStudentMineEvaListNoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self initCellConfigArr];
}

- (void)initCellConfigArr {
    [super initCellConfigArr];
    
    ZCellConfig *spacCellConfig = [ZCellConfig cellConfigWithClassName:[ZMineStudentEvaListNoEvaCell className] title:[ZMineStudentEvaListNoEvaCell className] showInfoMethod:nil heightOfCell:[ZMineStudentEvaListNoEvaCell z_getCellHeight:nil] cellType:ZCellTypeClass dataModel:nil];
    [self.cellConfigArr addObject:spacCellConfig];
    [self.cellConfigArr addObject:spacCellConfig];
    [self.cellConfigArr addObject:spacCellConfig];
    [self.cellConfigArr addObject:spacCellConfig];
    [self.cellConfigArr addObject:spacCellConfig];
}


- (void)setNavigation {
    self.isHidenNaviBar = NO;
    [self.navigationItem setTitle:@"视频课程"];
}

- (void)setupMainView {
    [super setupMainView];
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}

#pragma mark lazy loading...
- (void)zz_tableView:(UITableView *)tableView cell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath cellConfig:(ZCellConfig *)cellConfig {
    if ([cellConfig.title isEqualToString:@"ZMineStudentEvaListNoEvaCell"]){
        ZMineStudentEvaListNoEvaCell *enteryCell = (ZMineStudentEvaListNoEvaCell *)cell;
        enteryCell.evaBlock = ^{
            ZStudentMineEvaEditVC *evc = [[ZStudentMineEvaEditVC alloc] init];
            [self.navigationController pushViewController:evc animated:YES];
        };
    }
}
@end

